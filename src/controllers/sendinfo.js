const queries = require('../model/index')
const queryString = require('query-string');

exports.post = (req, response) => {
  var queryObj = queryString.parseUrl(req.url).query;
  var backgroundArr = queryObj.bg.split(",");
  var resourceArr = queryObj.rsc.split(",");
  console.log("bg Arr is", backgroundArr, "rsc Arr is", resourceArr);

  queries.getData(backgroundArr, resourceArr) 
  .then( dbObj => {
    const resultArray = arrangeArray(dbObj.rows); 
    console.log('resultArray', resultArray);
    const outArray = filterByType(resultArray);
   console.log('OUTPUT ARRAY', outArray);
   response.render('results', {
     results: outArray,
    layout: 'scrollable',
    progressamt: '100',
    title: 'Results',
    pageInfo: 'Based on the checkboxes you have selected, here are your results. This is a work in progress - if you feel there aren\'t many resources that apply to you, please come back again later. We\'ll be adding more as we go long.',
  });
  })
  .catch(err => console.log(err));

  function filterByType(inArray) {
    const types = ['meetup', 'online course', 'article', 'classroom course', 'mentor', 'others'];
    const outArr = {}
    types.forEach(mytype => {
      //outArr[meetup]= filtered result
      // setting keys to values from filter function
      outArr[mytype] = inArray.filter(function (value) {
        return value.resource_type == mytype;
      })
    })
    return outArr;
  }
   //to arrange repeated resource as {resource_id='1', resource_name='codebar', direct=['age','ethnicity'], indirect=['disability']},....
  function arrangeArray(inArray) {
    var resultArray = []; //empty array to start with
    for (let i = 0; i < inArray.length; i++) {
      if (i == 0) {
        //populate new resouce in our result array
        resultArrIndx = 0;
        resultArray.push({
          resource_id: inArray[i].resource_id, 
          resource_name: inArray[i].resource_name,
          url: inArray[i].url, 
          resource_type: inArray[i].resource_type, 
          resource_description: inArray[i].resource_description,
          resource_country: inArray[i].country, 
          resource_city: inArray[i].city
        });
         resultArray[resultArrIndx].direct = [];
        resultArray[resultArrIndx].indirect = [];
        //if incoming demo_tag_relevance is direct push it into resultArray[resultArrIndx].direct array else
        //push into resultArray[resultArrIndx].indirect array
        if (inArray[i].relevance === 'direct') {
          resultArray[resultArrIndx].direct.push(inArray[i].tag_name);
        } else {
          resultArray[resultArrIndx].indirect.push(inArray[i].tag_name);
        }
        resultArrIndx++;
      }
      else if (resultArray[resultArrIndx - 1].resource_id == inArray[i].resource_id) {
        if (inArray[i].demo_tag_relevance === 'direct') {
           resultArray[resultArrIndx - 1].direct.push(inArray[i].tag_name);
        } else {
          resultArray[resultArrIndx - 1].indirect.push(inArray[i].tag_name);
        }
      }
      else {
        //populate new resouce in our result array
        //create new key demo_tag_relevance and push {tagname:'tagname value', relevance:'rel value'}
        resultArray.push({
          resource_id: inArray[i].resource_id, 
          resource_name: inArray[i].resource_name,
          url: inArray[i].url, 
          resource_type: inArray[i].resource_type, 
          resource_description: inArray[i].resource_description,
          resource_country: inArray[i].country, 
          resource_city: inArray[i].city
        });
        resultArray[resultArrIndx].direct = [];
        resultArray[resultArrIndx].indirect = [];
        //if incoming demo_tag_relevance is direct push it into resultArray[resultArrIndx].direct array else
        //push into resultArray[resultArrIndx].indirect array
        if (inArray[i].relevance === 'direct') {
          resultArray[resultArrIndx].direct.push(inArray[i].tag_name);
        } else {
          resultArray[resultArrIndx].indirect.push(inArray[i].tag_name);
        }
        resultArrIndx++;
      }
     } //end of for loop
  
     return resultArray;
  }

}
