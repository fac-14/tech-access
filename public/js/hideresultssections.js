function hideMe(event) {
  var a;
  if (event.target.nodeName == "IMG"){
    var a = event.target.parentNode.id + '-results';
  } else {
    var a = event.target.id + '-results';
  }
  var elementToHide = document.getElementById(a)
  elementToHide.classList.toggle('hidden');
}