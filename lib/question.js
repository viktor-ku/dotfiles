const readline = require('readline')
const { Answer } = require('./Answer')
const fmt = require('./fmt')

function question (text) {
  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
  })

  return new Promise((resolve) => {
    rl.question(fmt.question(text), (answer) => {
      resolve(new Answer(answer))
      rl.close()
    })
  })
}

module.exports = {
  question
}
