const queries = require('../model/index');
//implement form=post in frontend
exports.post = (req, response) => {
  //get params, demo_tags is array
  //const {demo_tags} = req.body;
  const demo_tags = ['age', 'disability', 'gender'];
  queries.getData(demo_tags)
    .then((res) => {
      //Pure function??
      const userDemoTag = res.rows;
      const resultArray = arrangeArray(userDemoTag);
      const outArray = filterByType(resultArray);
      console.log('OUTARRAY', outArray);
      //const resultArray = (res.rows);

      // console.log('AFTER', resultArray);

      response.render('results', { outArray });
    })
    .catch(err => console.log(err));
  //to arrange as ['meetup'= [{},{},...], 'classroom_course'= [{},{},...], 'article'=[{},{},...],.....]
  function filterByType(inArray) {
    const types = ['meetup', 'online course', 'article', 'classroom course'];
    const outArr = []
    types.forEach(mytype => {
      //outArr[meetup]= filtered result// setting keys to values from filter function
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
        // resultArray.push({inArray[i].resource_id, inArray[i].resource_name, inArray[i].url});
        resultArray.push({
          resource_id: inArray[i].resource_id, resource_name: inArray[i].resource_name,
          url: inArray[i].url, resource_type: inArray[i].resource_type
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
        // resultArray[resultArrIndx].demo_tag_relevance = [];
        // const b = {};
        // b.tag_name = inArray[i].tag_name;
        // b.relevance = inArray[i].relevance;
        // resultArray[resultArrIndx].demo_tag_relevance.push(b);

        // console.log('RESULTARRAY AFTER', resultArray);
      }
      else if (resultArray[resultArrIndx - 1].resource_id == inArray[i].resource_id) {
        //console.log('PROBLEM', inArray[i].relevance)
        // resultArray[resultArrIndx - 1].demo_tag_relevance.push({ 'tag_name': inArray[i].tag_name, 'relevance': inArray[i].relevance });
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
          resource_id: inArray[i].resource_id, resource_name: inArray[i].resource_name,
          url: inArray[i].url, resource_type: inArray[i].resource_type
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

    } //eof for
    // console.log('resultArray =', resultArray);
    // resultArray[2].demo_tag_relevance.forEach(function (officer) {
    //   console.log(officer.tag_name, ":", officer.relevance);
    //})

    return resultArray;
  }

}