exports.get = (req, res) => {
  res.render('background', {
    layout: 'scrollable',
    progressamt: '40',
    title: 'Background',
    pageInfo: 'Please check all the boxes you feel are things holding you back from getting into tech.'
  });
}