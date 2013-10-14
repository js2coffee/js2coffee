// OPTIONS: {"single_quotes": true}
var foo = 'bar';

var obj = {
    key: "value",
    "array": ["one", 2, 'tree'],
    'mixed': "hello" + foo,
    'empty foo bar': '',
    "js-has-no-string-formatting": "#{foo}" + '#{foo}'

};