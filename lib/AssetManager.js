const path = require('path')
const config = require('../config')

class AssetManager {
  static HomeDir = '$HOME'

  constructor(platform, homeDir) {
    this.platform = platform
    this.homeDir = homeDir
  }

  files(filesMap) {
    const commonFiles = filesMap.common.map(file => ({
      ...file,
      source: path.join(config.baseDir, 'files', file.name),
    }))

    const platformFiles = filesMap[this.platform].map(file => ({
      ...file,
      source: path.join(config.baseDir, 'files', this.platform, file.name),
    }))

    return [
      ...commonFiles,
      ...platformFiles
    ]
      .map(file => ({
        ...file,
        target: file.target === AssetManager.HomeDir
          ? path.join(this.homeDir, file.name)
          : path.join(file.target, file.name),
      }))
  }
}

exports.AssetManager = AssetManager
