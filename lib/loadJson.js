const fs = require('fs').promises

exports.loadJson = async filePath => JSON.parse(await fs.readFile(filePath))
