---
uglify: true
---

window.onload =  function() {
    "use strict";

    var editorFrame = document.getElementById("editorFrame");

    // Tooltips
    document.querySelector('#overlay input[name="token_highlight"]').addEventListener('click', function(e){
        var value = e.target.checked;
        if (value === true) {
            editorFrame.contentWindow.enableToolTips();
        }
        if (value === false) {
            editorFrame.contentWindow.disableToolTips();
        }
    });

    // js2coffee line numbers
    document.querySelector('#overlay input[name="line_numbers"]').addEventListener('click', function(e){
        var value = e.target.checked;
        editorFrame.contentWindow.js2coffeeOptions.show_src_lineno = value;
        // editorFrame.contentWindow.compileToCoffee();
    });
    // js2coffee indent
    document.querySelector('#overlay select[name="js2coffee_indent"]').addEventListener('change', function(e){
        var value = e.target.value;
        editorFrame.contentWindow.js2coffeeOptions.indent = value;
        // editorFrame.contentWindow.compileToCoffee();
    });

    //
    var toggleEditorSettings = function(e) {
        var value = e.target.checked;
        var name = e.target.name;
        if (e.target.className.indexOf("renderer") >= 0) {
            editorFrame.contentWindow.editor1.renderer['set'+name](value);
            editorFrame.contentWindow.editor2.renderer['set'+name](value);
        } else {
            editorFrame.contentWindow.editor1['set'+name](value);
            editorFrame.contentWindow.editor2['set'+name](value);
        }
    }
    var inputs = document.querySelectorAll('#overlay input.editor');
    for (var i=0; i<inputs.length; i++) {
        inputs[i].addEventListener('click', toggleEditorSettings);
    }
    var injectVersion = function() {
        if (editorFrame !== null && editorFrame.contentWindow.js2coffee !== null) {
            var js2coffeeVersion = editorFrame.contentWindow.js2coffee.VERSION;
            var coffeeVersion = editorFrame.contentWindow.CoffeeScript.VERSION;
            document.querySelector("#js2coffee-version").innerText = "Js2coffee v. "+js2coffeeVersion;
            document.querySelector("#coffeescript-version").innerText = "CoffeeScript v. "+coffeeVersion;
        } else {
            // schedule if iframe not ready yet
            setTimeout(injectVersion, 100);
        }
    }
    injectVersion();
}