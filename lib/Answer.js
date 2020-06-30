class Answer {
  static positive = [
    '',
    'y',
    'yes',
    'ye',
    'ya',
    'si',
    'ja',
    'sure',
    'davai',
    'da'
  ]
    .map(x => x.toUpperCase())

  static k = [
    'let me speak to a manager!',
    'who is the manager?',
    'pp',
    'lemme some'
  ]
    .map(x => x.toUpperCase())

  constructor(val) {
    this.val = val
  }

  async result() {
    const val = this.val.trim().toUpperCase()

    if (Answer.k.indexOf(val) >= 0) {
      console.log('Sure! Wait...')

      return new Promise(() => {
        setTimeout(() => {
          throw new Error('Hold on! Are you drunk? It\'s a bloody CLI program you twat')
        }, require('os').platform() === 'linux' ? 3_000 : 10_000)
      })
    }

    return Answer.positive.indexOf(val) >= 0
  }
}

exports.Answer = Answer
