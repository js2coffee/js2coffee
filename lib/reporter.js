module.exports = MyReporter;

function MyReporter(runner) {
  var failures = 0;

  runner.on('suite', function(test) {
  });

  runner.on('pass', function(test){
    if (test.fn.data) {
      var data = test.fn.data;
      var title = test.fullTitle();
      title = title.replace(/^specs: /, '');
      console.log([
        "### " + title,
        "",
        "<table width='100%'>",
        "<tr><th>JavaScript</th><th>CoffeeScript</th></tr>",
        "<tr><td width='50%' valign='top'>",
        "<pre class='lang-js'>" + data.input + "</pre>",
        "</td><td width='50%' valign='top'>",
        "<pre class='lang-coffee'>" + data.output + "</pre>",
        "</td></tr></table>",
        "",
      ].join("\n"));
    }
  });

  runner.on('fail', function (test, err) {
  });

  runner.on('end', function () {
    process.exit(failures);
  });
}
