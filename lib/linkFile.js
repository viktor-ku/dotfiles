const fs = require('fs').promises
const config = require('../config')

async function _linkFile(file, n = 0) {
  if (n > 10) return 'Err(TooMuchTries)'

  try {
    await fs.link(file.source, file.target)

    return n === 0
      ? 'Ok(Create)'
      : 'Ok(Replace)'
  } catch (e) {
    if (e.code !== 'EEXIST') {
      return `Err(${e.code})`
    }

    if (config.skip) {
      return 'Ok(Skip)'
    } else {
      await fs.unlink(file.target)

      n += 1;
      return _linkFile(file, n)
    }
  }
}

async function linkFile(file) {
  const status = await _linkFile(file)

  return {
    ...file,
    status,
  }
}

module.exports = {
  linkFile,
}
