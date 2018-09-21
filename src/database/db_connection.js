const { Pool } = require("pg");
const url = require("url");
require("env2")("./config.env");

let DB_URL = process.env.DB_URL;

if(process.env.NODE_ENV === 'test') {
    DB_URL = process.env.TEST_DB_URL;
    console.log(DB_URL);
}

if (!DB_URL) throw new Error("DB_URL env variable must be set");

const params = url.parse(DB_URL);
const [username, password] = params.auth.split(":");

const options = {
    host: params.hostname,
    port: params.port,
    database: params.pathname.split("/")[1],
    max: process.env.DB_URL_CONNECTIONS || 8,
    user: username,
    password,
    ssl: params.hostname !== 'localhost',
};

module.exports = new Pool(options);