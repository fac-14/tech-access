const queries = require('../model/index')
const queryString = require('query-string');

exports.post = (req, response) => {
  var queryObj = queryString.parseUrl(req.url).query;
  var backgroundArr = queryObj.bg.split(",");
  var resourceArr = queryObj.rsc.split(",");
  console.log("bg Arr is", backgroundArr, "rsc Arr is", resourceArr);
  const demo_tags = [];
}

// Old code:
/*
exports.get = (req, res) => {
  res.render('results', {
    layout: 'scrollable'
  });
}
*/