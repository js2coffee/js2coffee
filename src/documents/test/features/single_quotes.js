// OPTIONS: {"single_quotes": true}
var foo = 'bar';

var obj = {
    key: "value",
    escape: 'rock\'n roll "escaped" strings',
    "array": ["one", 2, 'tree'],
    'mixed': "hello" + foo,
    'empty foo bar': '',
    "js-has-no-string-formatting": "#{foo}" + '#{foo}'

};