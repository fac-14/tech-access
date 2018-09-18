exports.get = (req, res) => {
  res.render('results', {
    layout: 'scrollable',
    progressamt: '100',
    title: 'Results',
    pageInfo: 'Based on the checkboxes you have selected, here are your results.'
  });
}