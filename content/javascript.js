function colivreShow() {
    c = document.getElementById('colivre');
    if (c.className=='colivre-opacity') {
        c.className = '';
        setTimeout(function(){ c.className = 'colivre-none'; }, 250);
    } else if (c.className=='colivre-none') {
        c.className = '';
        setTimeout(function(){ c.className = 'colivre-opacity'; }, 50);
    }
}
