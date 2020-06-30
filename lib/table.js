const fmt = require('./fmt')

function linksTable(files) {
  console.log()

  const maxLen = Math.max(...files.map(file => file.source.length))

  for (file of files) {
    const addedLength = maxLen - file.source.length

    console.log(
      '|-',
      fmt.secondary(file.name),
      `(${fmt.secondary(file.source)}`,
      ...Array(addedLength).fill(''),
      '=>',
      `${fmt.secondary(file.target)})`
    )
  }

  console.log()
}

function resultsTable(data) {
  console.log()

  const maxLen = Math.max(...data.map(one => one.target.length))

  for (one of data) {
    const addedLength = maxLen - one.target.length

    console.log(
      '==',
      fmt.secondary(one.target),
      ...Array(addedLength).fill(''),
      '=>',
      `${one.status}`,
    )
  }

  console.log()
}

module.exports = {
  linksTable,
  resultsTable,
}
