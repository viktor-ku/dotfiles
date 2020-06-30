module.exports = {
  baseDir: __dirname,
  skip: process.argv.some(arg => arg === '--skip'),
}
