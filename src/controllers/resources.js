exports.get = (req, res) => {
  res.render('resources', {
    progressamt: '60',
    title: 'Resources',
    pageInfo: 'Please check all the boxes of the types of resources you feel would be most helpful to get you into tech.'
  });
}