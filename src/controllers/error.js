exports.client = (req, res) => {
  res.status(404).send('404 mate')
};

exports.server = (req, res) => {
  res.status(500).send('server no good mate')
};

exports.get = (err, req, res, next) => {
  res.status(500).send("error")
}