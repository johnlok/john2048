randomInt = (x) ->
  Math.floor(Math.random()*x)

randomCellIndices = ->
  [randomInt(4),randomInt(4)]

buildBoard = ->
  # board = []
  # for row in [0..3]
  #   board[row] = []
  #   for column in [0..3]
  #     board[row][column] = 0
  # board
  [0..3].map -> [0..3].map -> 0
  #the map array applies a function to every element in an array.
  #in this example all items in the array are turned into "0"

generateTile = ->
  value = 2
  console.log "randomInteger:", randomInt(4)
  console.log "generate tile"

printArray = (array) ->
  console.log "--start--"
  for row in array
    console.log row
  console.log "--end--"

$ ->
  board = buildBoard()
  printArray(board)
  buildBoard()
  generateTile()
  generateTile()