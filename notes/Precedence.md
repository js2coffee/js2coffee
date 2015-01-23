Precedence levels
-----------------

## 18

- MemberExpression (`a.b` and `a[b]`)
- CallExpression (`a(b)`)
- NewExpression with args (`new X()`)

## 17

- NewExpression with no args (`new X`)

## 16

- UpdateExpression suffix (`a++`)

## 15

- UpdateExpression prefix (`++a`)
- UnaryExpression (`+a`, `delete`, `!`)
- NewExpression (`new a`)
- void

## 14

- BinaryExpression multiplications (`* / %`)

## 13

- BinaryExpression additions (`+ -`)

## 12

- BinaryExpression bitshift (`<< >> >>>`)

## 11

- BinaryExpression comparison (`> >= < <=`)
- BinaryExpression instanceof (`a instanceof b`)
- BinaryExpression in (`a in b`)

## 10

- BinaryExpression equality (`== === != !==`)

## 9

- BinaryExpression AND (`&`)

## 8

- BinaryExpression XOR (`^`)

## 7

- BinaryExpression OR (`|`)

## 6

- LogicalExpression and (`&&`)

## 5

- LogicalExpression or (`||`)

## 4

- ConditionalExpression (`a ? b : c`)

## 3

- AssignmentExpression (`a = 1`)

## 0

- SequenceExpression (`a, b`)

## Reference

https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Operator_Precedence
