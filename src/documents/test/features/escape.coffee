foo = "bar"
obj =
  key: "value"
  escape: "rock'n roll"
  escapeAnother: "rock\"n roll"
  array: [
    "one"
    2
    "tree"
  ]
  mixed: "hello" + foo
  "empty foo bar": ""
  "js-has-no-string-formatting": '#{foo}' + '#{foo}'
