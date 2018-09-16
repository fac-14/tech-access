exports.get = (req, res) => {
  res.render('resources', {
    layout: 'scrollable'
  });
}