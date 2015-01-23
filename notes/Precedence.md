Precedence levels
-----------------

## 1

- MemberExpression (`a.b` and `a[b]`)
- CallExpression (`a(b)`)

## 2

- UnaryExpression (`++a`, `delete`, `!`)
- NewExpression (`new a`)
- void

## 3

- BinaryExpression multiplications (`* / %`)

## 4

- BinaryExpression additions (`+ -`)

## 5

- BinaryExpression bitshift (`<< >>`)

## 6

- BinaryExpression comparison (`> >= < <=`)
- BinaryExpression instanceof (`a instanceof b`)

## 7

- BinaryExpression equality (`== === != !==`)

## 8

- BinaryExpression AND (`&`)

## 9

- BinaryExpression XOR (`^`)

## 10

- BinaryExpression OR (`|`)

## 11

- LogicalExpression and (`&&`)

## 12

- LogicalExpression or (`||`)

## 13

- ConditionalExpression (`a ? b : c`)

## 14

- AssignmentExpression (`a = 1`)

## 15

- SequenceExpression (`a, b`)
