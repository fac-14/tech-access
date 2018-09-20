exports.get = (req, res) => {
  res.render('home', 
    {
      activePage:{home: true},
      progressamt: '0',
      title: 'diversiTech'
    })
}