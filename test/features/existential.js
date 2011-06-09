function ifChecks() {
    if (x) { alert("if x") }
    if (!x) { alert("if !x") }
}
function ifNullChecks() {
    if (x==null) { alert("x == null") }
    if (x===null) { alert("x === null") }
}
function voidChecks() {
    if (x==void 0) { alert("x == void 0") }
    if (x===void 0) { alert("x === void 0") }
    if (x==void 1) { alert("x == void 1") }
}
function undefinedChecks() {
    if (typeof x == 'undefined') { alert("typeof x == 'undefined'") }
}
function edgeCase() {
    if (!x == y) { alert("!x == y") }
}

function unlessChecks() {
    if (x!=null) { alert("x != null") }
    if (x!==null) { alert("x !== null") }
    if (typeof x != 'undefined') { alert("typeof x != 'undefined'") }
}

function whileAndFor() {
    while (x==null) { alert }
    while (x===null) { alert }

    for (a;x==null;2) { alert }
}
