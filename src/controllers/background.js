exports.get = (req, res) => {
  res.render('background', {
    layout: 'scrollable'
  });
}