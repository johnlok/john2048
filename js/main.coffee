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
  if board[row][column] is 0
    board[row][column] = value
  else
    generateTile(board)

move = (board, direction) ->
  newBoard = buildBoard()

  for i in [0..3]
    switch direction
      when 'right', 'left'
        row = getRow(i, board)
        row = mergeCells(row, direction)
        row = collapseCells(row, direction)
        setRow(row, i, newBoard)
      when 'up', 'down'
        column = getColumn(i, board)
        column = mergeCells(column, direction)
        column = collapseCells(column, direction)
        setColumn(column, i, newBoard)


    # if direction is 'right' or 'left'
    #   row = getRow(i, board)
    #   row = mergeCells(row, direction)
    #   row = collapseCells(row, direction)
    #   setRow(row, i, newBoard)
    # else if direction is 'up' or 'down'
    #   column = getColumn(i, board)
    #   column = mergeCells(column, direction)
    #   column = collapseCells(column, direction)
    #   setColumn(column, i, newBoard)

  newBoard


getRow = (r, board) ->
  [board[r][0], board[r][1], board[r][2], board[r][3]]

getColumn = (c, board) ->
  [board[0][c], board[1][c], board[2][c], board[3][c]]

# getColumn = (c, board) ->
#   column = []
#   for row in [0..3]
#     column[row] = board[row][c]
#   column

# check = ->
# a = [[2, 0, 0, 0],
# [0, 0, 2, 0],
# [0, 0, 0, 0],
# [0, 0, 0, 0]]
# console.log

#harry's version
# @getColumn = (columnNumber, board) ->
#   column = []
#   for row in [0..3]
#     column[row] = board[row][columnNumber]
#   column

setColumn = (columnArray, columnNumber, board) -> #column refers to the column array, columnNumber is the column number, board is the original multidimensional array
  for i in [0..3]
    board[i][columnNumber] = columnArray[i]


setRow = (row, index, board) ->
  board[index] = row

mergeCells = (cells, direction) ->
  #to merge the cells we need to know the cellss and the direction
  #this is a double for loop which iterates over all the possible comparisons within the array
  merge = (cells) ->
    for a in [3...0]
      for b in [a-1..0]
        if cells[a] is 0
          break
        else if cells[a] is cells[b]
          cells[a] *= 2
          cells[b] = 0
        else if cells[b] isnt 0
          break
    cells

  switch direction
    when 'right', 'down'
      cells = merge(cells)
    when 'left', 'up'
      cells = merge(cells.reverse()).reverse()
  cells

console.log mergeCells [2,2,4,4], 'up'

collapseCells = (row, direction) ->
  row = row.filter (x) -> x isnt 0
  zeroesToAdd = 4 - row.length
  for i in [0...zeroesToAdd]
    switch direction
      when 'right', 'down'
        row.unshift 0
      when 'left','up'
        row.push 0
  console.log row
  row

  # if direction is 'right'
  #   while row.length < 4
  #     row.unshift 0
  # console.log row
  # row

printArray = (array) ->
  console.log "--start--"
  for row in array
    console.log row
  console.log "--end--"

arrayEqual = (arr1, arr2) ->
  for element, index in arr1
    if element != arr2[index]
      return false
  true

boardEqual = (oBoard, nBoard) ->
  for e, i in oBoard
    # console.log "old row: ", e
    # console.log "new row: ", nBoard[i]
    #watch out for iterating this that you don't return "true" if the first element is true!!!
    if not arrayEqual(e, nBoard[i])
      return false
  true

moveIsValid = (oBoard, nBoard) ->
  result = boardEqual(oBoard, nBoard)
  not result

boardIsFull = (board) ->
  for row in board
    if 0 in row
      return false
  true

noValidMoves = (board) ->
  directions = ['right','left','up','down']
  for direction in directions
    newBoard = move(board,direction)
    if moveIsValid(board,newBoard)
      return false
  true

isGameOver = (board) ->
  boardIsFull(board) and noValidMoves(board)

showValue = (value) ->
  if value == 0 then "" else value
  #this function changes all values from 0 to ""


opacityFunction = (board) ->
  for row in [0..3]
    for col in [0..3]
      for power in [0..11]
        p = 2 ** power
        if board[row][col] = p
          $(".r#{row}.c#{col}").css('opacity',(1-(1/11)*power))

showBoard = (board) ->
  for row in [0..3]
    for col in [0..3]
      for power in [0..11]
        p = 2 ** power
        $(".r#{row}.c#{col}").removeClass('val-0')
        $(".r#{row}.c#{col}").removeClass('val-' + (2 ** power))
        $(".r#{row}.c#{col}").addClass('val-' + board[row][col])
        # $(".r#{row}.c#{col}.val-#{p}").css('opacity',((1/11) * power))
      $(".r#{row}.c#{col} > div").html(showValue(board[row][col]))

  #this part of the code assigns the value of the board array into divs using jquery


$ ->
  @board = buildBoard()
  generateTile(@board)
  generateTile(@board)
  printArray(@board)
  showBoard(@board)

  $('body').keydown (e) => #where keydown is the event and everything after (e) is the event handler
    #e.preventDefault() #if here, would stop all keydown events on the page from working
    key = e.which #event.which is a function in jquery which returns which key you pressed
    keys = [37..40]
    if key in keys
      e.preventDefault()
      direction = switch key #the switch function switches the value based upon conditions
        when 37 then 'left'
        when 38 then 'up'
        when 39 then 'right'
        when 40 then 'down'
        #continue the game
      console.log "The direction is " + direction

      #try moving
      newBoard = move(@board, direction)
      printArray(@board)
      printArray(newBoard)

      if moveIsValid(@board, newBoard)
        console.log "valid"
        @board = newBoard
        #generate tile
        generateTile(@board)
        #show the new board
        showBoard(@board)
        #check GAME OVER
        if isGameOver(@board)
          console.log "YOU LOSE"
      else
        showBoard(@board)
      #check move validity
    else

