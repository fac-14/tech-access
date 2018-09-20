exports.get = (req, res) => {
  res.render('results', {
    layout: 'scrollable',
    progressamt: '100',
    title: 'Results',
    pageInfo: 'Based on the checkboxes you have selected, here are your results. This is a work in progress - if you feel there aren\'t many resources that apply to you, please come back again later. We\'ll be adding more as we go long.',
    results: req.cookies.results
  });
}