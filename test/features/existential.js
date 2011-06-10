function ifChecks() {
    if (x) { yes }
    if (!x) { yes }
}
function ifNullChecks() {
    if (x==null) { yes }
    if (x===null) { nah }
}
function voidChecks() {
    if (x==void 0) { yes }
    if (x===void 0) { nah }
    if (x==void 1) { yes }
}
function undefinedChecks() {
    if (typeof x == 'undefined') { nah }
}
function edgeCase() {
    if (!x == y) { nah }
}

function unlessChecks() {
    if (x!=null) { yes }
    if (x!==null) { nah }
    if (typeof x != 'undefined') { wat }
}

function whileAndFor() {
    while (x==null) { yes }
    while (x===null) { yes }

    for (a;x==null;2) { yes }
}
