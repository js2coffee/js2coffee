function extractEventInfo(e, eventName) {
  var sheet = e.source.getActiveSheet()
  var range = e.range
  var row   = range.getRow()
  var col   = range.getColumn()

  return {eventName, sheet, range, row, col}
}

function initEventHandlers() {
  var eventNames = 'open install edit selectionChange get post'
    .split(' ')
    .map((name) => 'on' + name[0].toUpperCase() + name[1..name.length - 1])

  for (var name of eventNames) {
    
  }
}

function onOpen(e) {  handleEvent(extractEventInfo, 'onOpen'); }
function onEdit(e) {
  var eventInfo = extractEventInfo(e)
  var handler = getOnEditHandler(eventInfo)

  if (handler) {
    handler()
  }
}

function getOnEditHandler(sheet, range, row, col) {
  var handlerFactories = lookupHandlerFactories('onEdit', sheet, row, col)
  var handler = undefined

  if (!handlerFactories.length)
    return;
  

}

function lookupHandlerFactories(eventName, sheet, row, col) {
  for (var factory in handlerFactories()) {
    
  }
  //if (sheet.getName() === 'TestCases' && col === 3) { // Assuming column C
  //  showRelationDialog(row);
  //}
}