const NO_FORMAT = '\033[0m'
const C_BLUE = '\033[1;34m'
const C_GREEN = '\033[1;32m'

const primary = (text) => `${C_GREEN}${text}${NO_FORMAT}`
const secondary = (text) => `${C_BLUE}${text}${NO_FORMAT}`

exports.primary = primary
exports.secondary = secondary

exports.question = (text) => `|> ${primary(text)} (Y/n): `
