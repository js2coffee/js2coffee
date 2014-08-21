---
browserify: true
uglify: true
---

window.onload =  function() {
  "use strict";

  window.js2coffee = require('./lib/browser.js')
  window.CoffeeScript = require('coffee-script')

  window.js2coffeeOptions = {}
  js2coffeeOptions.show_src_lineno = false;

  var TokenTooltip = ace.require("kitchen-sink/token_tooltip").TokenTooltip;

  window.editor1 = ace.edit("editor1");
  editor1.getSession().setMode("ace/mode/javascript");
  editor1.setFontSize(14);

  editor1.commands.addCommand({
    name: 'execute',
    bindKey: "ctrl+enter",
    exec: function(editor) {
        var r;
        try {
            var r = window.eval(editor.getCopyText()||editor.getValue());
        } catch(e) {
            r = e;
        }
        console.dir(r);
    },
    readOnly: true
  });

  window.editor2 = ace.edit("editor2");
  editor2.getSession().setMode("ace/mode/coffee");
  editor2.setFontSize(14);

  var editMode = editor1;
  var toggleMode = function() {
    if (editMode === editor1) {
      editMode = editor2;
    } else if (editMode === editor2) {
      editMode = editor1;
    }
    schedule();
  }

  editor1.on('change', function(event, editor) {
    var focused = document.activeElement.parentElement;
    if (focused === editor1.container) {
      editMode = editor1;
      schedule();
    }
  });

  editor2.on('change', function(event, editor) {
    var focused = document.activeElement.parentElement;
    if (focused === editor2.container) {
      editMode = editor2;
      schedule();
    }
  });


  var job = null;
  var schedule = function() {
    if (job != null) {
      clearTimeout(job);
    }
    return job = setTimeout(doCompile, 200);
  };

  var doCompile = function() {
    if (editMode === editor1) {
      compileToCoffee();
    } else {
      compileToJavaScript();
    }
  }

  var compileToJavaScript = function() {
    try {
      var input = editor2.getSession().getDocument().getValue();
      var jsOutput = CoffeeScript.compile(input, {bare: true});
      editor1.getSession().getDocument().setValue(jsOutput);
      document.querySelector(".infobox-content").innerText = ""
      document.querySelector("#infobox").style.display = "none";
    } catch (err) {
      //console.error(err.message);
      //console.error(err.stack);
      document.querySelector(".infobox-content").innerText = err.message;
      document.querySelector("#infobox").style.display = "block";
    }
  }

  var compileToCoffee = function() {
    //TODO: check if JS is valid before compile to coffee
    try {
      var input = editor1.getSession().getDocument().getValue();
      var coffeeOutput = js2coffee.build(input, js2coffeeOptions);
      editor2.getSession().getDocument().setValue(coffeeOutput);
      document.querySelector(".infobox-content").innerText = ""
      document.querySelector("#infobox").style.display = "none";
    } catch (err) {
      //console.error(err.message);
      //console.error(err.stack);
      document.querySelector(".infobox-content").innerText = err.message;
      document.querySelector("#infobox").style.display = "block";
    }
  };

  var enableOptions = function (editors) {
    for (var i=0; i < editors.length; i++) {
      var editor = editors[i];
      editor.setTheme("ace/theme/monokai");
      editor.tokenTooltip = new TokenTooltip(editor);
      editor.setShowInvisibles(true);
      editor.renderer.setShowGutter(true);
      editor.renderer.setShowPrintMargin(false);
    }
  };

  window.disableToolTips = function() {
    tooltip1 = editor1.tokenTooltip;
    tooltip2 = editor2.tokenTooltip;
    tooltip1.destroy();
    tooltip2.destroy();
  }

  window.enableToolTips = function() {
    editor1.tokenTooltip = new TokenTooltip(editor1);
    editor2.tokenTooltip = new TokenTooltip(editor2);
  }

  enableOptions([editor1, editor2]);

  compileToCoffee();
}