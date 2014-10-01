buildBoard = ->
  board = []
  for row in [0..3]
    # console.log "row is now", row
    board[row] = []
    for column in [0..3]
      board[row][column] = 0
      # console.log "column is now", i2
  console.log "build board"
  board

  # console.log board

generateTile = ->
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