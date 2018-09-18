const db = require("../database/db_connection");
var inputArray = ["age"];
const getData = inputArray => {
  var dataQuery = `select resource.resource_id ,resource.resource_name,resource.url, resource.resource_type,demographic_tag. demographic_tag_id, demographic_tag.tag_name, demographic_resource_link.relevance from resource INNER JOIN demographic_resource_link ON resource.resource_id = demographic_resource_link.link_resource_id INNER JOIN demographic_tag ON demographic_resource_link.link_demographic_tag_id = demographic_tag. demographic_tag_id WHERE demographic_tag.tag_name = '${
    inputArray[0]
    }'`;
  // 'refugee' OR demographic_tag.tag_name = 'ethnicity' OR demographic_tag.tag_name = 'age' " ;

  //iterator appends users selected demographic tags
  for (let i = 1; i < inputArray.length; i++) {
    dataQuery += ` OR demographic_tag.tag_name = '${inputArray[i]}'`;
  }
  console.log("DATAQUERY=", dataQuery);

  return new Promise((resolve, reject) => {
    db.query(dataQuery)
      .then(res => resolve(res))
      .catch(err => reject(err));
  });
};
module.exports = getData;

// getData(['age', 'disability', 'gender'])
// .then(res => console.log(res.rows))
// .catch(err => console.log(err))

//function invoking/ function call
// const resultArr = getData(["age", "disability", "gender"])
//   .then((res) => {
//     var inArray = res.rows;

//     var resultArray = []; //empty array to start with

//     for (let i = 0; i < inArray.length; i++) {
//       if (i == 0) {
//         //populate new resouce in our result array
//         //create new key demo_tag_relevance and push {tagname:'tagname value', relevance:'rel value'}
//         resultArrIndx = 0;
//         resultArray.push(res.rows[i]);
//         resultArray[resultArrIndx].demo_tag_relevance = [];
//         const b = {};
//         b.tag_name = inArray[i].tag_name;
//         b.relevance = inArray[i].relevance;
//         resultArray[resultArrIndx].demo_tag_relevance.push(b);
//         resultArrIndx++;


//       }
//       else if (resultArray[resultArrIndx - 1].resource_id == inArray[i].resource_id) {
//         resultArray[resultArrIndx - 1].demo_tag_relevance.push({ 'tag_name': inArray[i].tag_name, 'relevance': inArray[i].relevance });
//       }
//       else {
//         //populate new resouce in our result array
//         //create new key demo_tag_relevance and push {tagname:'tagname value', relevance:'rel value'}
//         resultArray.push(res.rows[i]);
//         resultArray[resultArrIndx].demo_tag_relevance = [];
//         const b = {};
//         b.tag_name = inArray[i].tag_name;
//         b.relevance = inArray[i].relevance;
//         resultArray[resultArrIndx].demo_tag_relevance.push(b);
//         resultArrIndx++;
//       }

//     } console.log('resultArray =', resultArray);
//     resultArray[2].demo_tag_relevance.forEach(function (officer) {
//       console.log(officer.tag_name, ":", officer.relevance);
//     })
//   })
//   .catch(err => console.log(err));


//var newAns = resultArr.reduce(reducer);
//console.log("HELLO", newAns);
