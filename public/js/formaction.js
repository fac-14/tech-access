var backgroundString = [];
var resourceString = [];

Object.keys(sessionStorage).forEach(i => {
  if (i.includes("-background")) {
  backgroundString.push(i.replace('-background', '').replace(" ", "%20"))  
  } else if (i.includes("-resource")) {
    resourceString.push(i.replace ('-resource', '').replace(" ", "%20"))
  }
})

var url = '/sendinfo?bg=' + backgroundString.join('%2C+') + '&rsc=' + resourceString.join('%2C+');

document.getElementById('final-form').action = url;