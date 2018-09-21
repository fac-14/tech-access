// Script to make it compulsory to have at least one item ticked

document.getElementById("submit-form").addEventListener("submit", forceChecked);

function forceChecked(e){
    var resourceOrSession = "";

    if(document.getElementById("title-heading").textContent == "Background") {
        resourceOrSession = "background"
    } else {
        resourceOrSession = "resource"
    }

    if (Object.keys(sessionStorage).toString().includes(resourceOrSession)){
        return true;
    } else {
        e.preventDefault();
        window.alert("Please select at least one item to receive your results")
    }
}