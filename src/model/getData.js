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

