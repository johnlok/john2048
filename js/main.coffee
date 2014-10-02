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

move = (board, direction) ->
  for i in [0..3]
    if direction is 'right'
      row = getRow(i, board)
      mergeCells(row, direction)
      collapseCells(row, direction)


getRow = (r, board) ->
  [board[r][0], board[r][1], board[r][2], board[r][3]]

mergeCells = (row, direction) ->
  #to merge the cells we need to know the rows and the direction
  #this is a double for loop which iterates over all the possible comparisons within the array
  if direction is 'right'
    for a in [3...0]
      for b in [a-1..0]
        if row[a] is 0
          break
        else if row[a] is row[b]
          row[a] *= 2
          row[b] = 0
        else if row[b] isnt 0
          break
  row

collapseCells = (row, direction) ->
  row = row.filter (x) -> x isnt 0
  zeroesToAdd = 4 - row.length
  for i in [0...zeroesToAdd]
    switch direction
      when 'right','down' then row.unshift 0
      when 'left','up' then row.push 0
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

showValue = (value) ->
  if value == 0 then "" else value
  #this function changes all values from 0 to ""

showBoard = (board) ->
  for row in [0..3]
    for col in [0..3]
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
      move(@board, direction)
      #check move validity
    else

