const db = require("../database/db_connection.js");

const getDemoTagId = demoTag => {
  return new Promise((resolve, reject) => {
    db.query(
      `SELECT demographic_tag.id FROM demographic_tag WHERE tag_name = '${demoTag}'`
    )
      .then(res => resolve(res))
      .catch(err => reject(err));
  });
};

module.exports = getDemoTagId;
