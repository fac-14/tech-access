const express = require('express');
const router = express.Router();
const bodyParser = require('body-parser');
const home = require('./home')
const error = require('./error')

router.use(bodyParser.urlencoded({extended: true}));
router.get('/', home.get);

router.use(error.client);
router.use(error.server);

module.exports = router;