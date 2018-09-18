const db = require("../database/db_connection");

const getResourceDetail = resourceId => {
  return new Promise((resolve, reject) => {
    db.query(`SELECT * from resource WHERE resource_id ='${resourceId}' `)
      .then(res => resolve(res))
      .catch(err => reject(err));
  });
};

module.exports = getResourceDetail;
console.log("herehere");
getResourceDetail(1)
  .then(res => console.log(res.rows))
  .catch(err => console.log(err));

// const getResourceDetail = resourceId =>{
//   let query = `SELECT * FROM resource WHERE id = '${resourceId}'`;
//   db.query(query, (err, res) => {
//     if(err){
//       cb('Error', null);
//     } else {
//       cb(null, res);
//     }
//   })
// }

// module.exports = getResourceDetail;

// console.log("HERE", getResourceDetail(1, callback()));
