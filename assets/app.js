;(function () {

  var defaultText = [
    'function add(x, y) {',
    '  // Welcome to the new js2coffee, now',
    '  // rewritten to use esprima.',
    '  return x + y;',
    '}'
  ].join("\n");

  ready(function () {
    var $src = q('#src');

    new Behave({ textarea: $src, tabSize: 2 });

    if ($src.value.length === 0)
      $src.value = defaultText;

    on($src, 'input', update);
    update();
  });

  function update() {
    var input = q('#src').value;
    var output;

    try {
      output = Js2coffee.build(input);
      q('#out').value = output.code;
      q('#errors').style.display = 'none';
    } catch (err) {
      q('#errors').innerHTML = err.message;
      q('#errors').style.display = 'block';
    }
  }

  /*
   * Helpers taken from npmjs.com/dom101
   */

  function ready (fn) {
    if (document.addEventListener) {
      document.addEventListener('DOMContentLoaded', fn);
    } else {
      document.attachEvent('onreadystatechange', function() {
        if (document.readyState === 'interactive') fn();
      });
    }
  }

  function q (query) {
    return document.querySelector(query);
  }

  function on (el, event, handler) {
    if (el.addEventListener) {
      el.addEventListener(event, handler);
    } else {
      el.attachEvent('on' + event, function(){
        handler.call(el);
      });
    }
  }

})();
