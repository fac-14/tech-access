exports.get = (req, res) => {
  res.render('welcome',
    {
      progressamt: '20',
      title: 'Tech Access App'
    });
}