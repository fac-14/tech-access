exports.get = (req, res) => {
  res.render('results', {
    layout: 'scrollable'
  });
}