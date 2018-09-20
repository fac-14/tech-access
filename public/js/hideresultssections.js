function hideMe() {
  var a = event.target.id + '-results';
  var elementToHide = document.getElementById(a)
  elementToHide.classList.toggle('hidden');
}