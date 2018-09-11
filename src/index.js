const app = require('./app');

app.listen(app.get('port'), () => {
  console.log('The party is happening on port', app.get('port'));
});