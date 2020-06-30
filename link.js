#!/usr/bin/env node

console.time('Done')

const path = require('path')
const os = require('os')
const {loadJson} = require('./lib/loadJson')
const { AssetManager } = require('./lib/AssetManager')
const table = require('./lib/table')
const config = require('./config')
const {linkFile} = require('./lib/linkFile')
const {question} = require('./lib/question')

async function main() {
  const homeDir = os.homedir()
  const platform = os.platform()

  const assetManager = new AssetManager(platform, homeDir)

  const filesMap = await loadJson(path.join(config.baseDir, 'files.json'))
  const files = assetManager.files(filesMap)

  table.linksTable(files)
  const answer = await question('Link these files?')
  const shouldContinue = await answer.result()

  if (!shouldContinue) return

  const results = await Promise.all(files.map(file => linkFile(file)))
  table.resultsTable(results)
}

main()
  .catch(console.error)
  .finally(() => {
    console.timeEnd('Done')
  })
