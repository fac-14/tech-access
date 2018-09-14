

// callback just logs each key in session storage
function callback(k) {
    console.log(k)
}

function forEachKey(callback) {
    for (var i = 0; i < sessionStorage.length; i++) {
        callback(sessionStorage.key(i));
    }
}

forEachKey(callback)