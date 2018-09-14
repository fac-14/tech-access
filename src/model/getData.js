const db = require("../database/db_connection");
var inputArray = ["age"];
const getResource = inputArray => {
  var dataQuery = `select resource.resource_id ,resource.resource_name,resource.url, demographic_tag. demographic_tag_id, demographic_tag.tag_name, demographic_resource_link.relevance from resource INNER JOIN demographic_resource_link ON resource.resource_id = demographic_resource_link.link_resource_id INNER JOIN demographic_tag ON demographic_resource_link.link_demographic_tag_id = demographic_tag. demographic_tag_id WHERE demographic_tag.tag_name = '${
    inputArray[0]
  }'`;
  // 'refugee' OR demographic_tag.tag_name = 'ethnicity' OR demographic_tag.tag_name = 'age' " ;

  //iterator appends users selected demographic tags
  for (let i = 0; i < inputArray.length - 1; i++) {
    dataQuery += ` OR demographic_tag.tag_name = '${inputArray[i]}'`;
  }
  console.log("DATAQUERY=", dataQuery);

  return new Promise((resolve, reject) => {
    db.query(dataQuery)
      .then(res => resolve(res))
      .catch(err => reject(err));
  });
};
module.exports = getResource;

console.log("HERE");

// getResource(['age', 'disability', 'gender'])
// .then(res => console.log(res.rows))
// .catch(err => console.log(err))
const resultArr = getResource(["age", "disability", "gender"])
  .then(res => {
    var resultArr = res.rows;
    var newAns = resultArr.reduce(reducer);
    console.log("HELLO", newAns);
  })
  .catch(err => console.log(err));

////////

//myArray.reduce(reducer)
// var myarr = [1, 2, 3];
// const reducer = (accumulator, currentvalue) => {
//   return accumulator + currentvalue;
// };

// var sum = myarr.reduce(reducer);
// console.log(sum);
var accumulator = []; //empty array to start with
const reducer = (accumulator, currentvalue) => {
  // accumulator.forEach(function(element) {
  //   if (element.resource_id == currentvalue.resource_id) {
  //     //if one of the relevance is direct set our result's relevance to direct
  //     if (element.relevance == "direct" || currentvalue.relevance == "direct") {
  //       element.relevane = "direct";
  //     }
  //   } else {
  //     //populate new resouce in our result array
  //     accumulator.push(currentvalue);
  //   }
  // });
  for (let i = 0; i < accumulator.length; i++) {
    if (accumulator[i].resource_id == currentvalue.resource_id) {
      if (
        accumulator[i].relevance == "direct" ||
        currentvalue.relevance == "direct"
      ) {
        accumulator[i].relevance = "direct";
      }
    } else {
      //populate new resouce in our result array
      accumulator.push(currentvalue);
    }
  }
};

//var newAns = resultArr.reduce(reducer);
//console.log("HELLO", newAns);
