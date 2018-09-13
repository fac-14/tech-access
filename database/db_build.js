const fs = require("fs");
const db_connection = require("./db_connection.js");

const sql = fs.readFileSync(`${__dirname}/db_build.sql`).toString();

const runDbBuild = cb => {
    db_connection.query(sql, (err, res) => {
        if(err) {
            cb(err, null);
        } else { 
            cb(null, res);
        }
    });
};

module.exports = runDbBuild;