exports.get = (req, res) => {
  res.render('moreinfo', {
    layout: 'scrollable',
    progressamt: '80',
    title: 'More Info',
    pageInfo: 'If you\'d like to, you can give us more detail about your background. We can\'t use these to tailor your results yet, but we hope to use this infromation to improve our service down the line.'
  });
}