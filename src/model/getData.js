const db = require("../database/db_connection");

const getData = (bgArray, rscArray) => {
  console.log('INPUTARR', bgArray, rscArray);
  var dataQuery = `select resource.resource_id ,resource.resource_name,resource.url, resource.resource_type, demographic_tag. demographic_tag_id, demographic_tag.tag_name, demographic_resource_link.relevance from resource INNER JOIN demographic_resource_link ON resource.resource_id = demographic_resource_link.link_resource_id INNER JOIN demographic_tag ON demographic_resource_link.link_demographic_tag_id = demographic_tag. demographic_tag_id WHERE (demographic_tag.tag_name='${
    bgArray[0]
    }'`;


  //iterator appends users selected demographic tags
  for (let i = 1; i < bgArray.length; i++) {
    dataQuery += ` OR demographic_tag.tag_name = '${bgArray[i].trim()}'`;
  }

  dataQuery += `) AND (resource.resource_type = '${rscArray[0].trim()}'`;

  for (let i = 1; i < rscArray.length; i++) {
    dataQuery += ` OR resource.resource_type = '${rscArray[i].trim()}'`;
  }

  dataQuery += ')'

  console.log("DATAQUERY=", dataQuery);

  return new Promise((resolve, reject) => {
    db.query(dataQuery)
      .then(res => resolve(res))
      .catch(err => reject(err));
  });
};
module.exports = getData;

