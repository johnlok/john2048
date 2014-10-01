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

getTileValue = ->
  values = [2,2,2,4]
  values[randomInt(values.length)]

generateTile = (board) ->
  value = getTileValue()
  [row, column] = randomCellIndices()
  console.log "row: #{row} column: #{column}"
  if board[row][column] is 0
    board[row][column] = value
  else
    generateTile(board)
  console.log "generated tile with a value of #{value}"

printArray = (array) ->
  console.log "--start--"
  for row in array
    console.log row
  console.log "--end--"

showValue = (value) ->
  if value == 0 then "" else value

showBoard = (board) ->
  for row in [0..3]
    for col in [0..3]
      $(".r#{row}.c#{col} > div").html(showValue(board[row][col]))


$ ->
  newBoard = buildBoard()
  generateTile(newBoard)
  generateTile(newBoard)
  printArray(newBoard)
  showBoard(newBoard)