// Generated by CoffeeScript 1.8.0
(function() {
  var arrayEqual, boardEqual, boardIsFull, buildBoard, collapseCells, generateTile, getColumn, getRow, getTileValue, highestCurrentScore, isGameOver, mergeCells, move, moveIsValid, noValidMoves, opacityFunction, printArray, randomCellIndices, randomInt, setColumn, setRow, showBoard, showValue,
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  randomInt = function(x) {
    return Math.floor(Math.random() * x);
  };

  randomCellIndices = function() {
    return [randomInt(4), randomInt(4)];
  };

  buildBoard = function() {
    return [0, 1, 2, 3].map(function() {
      return [0, 1, 2, 3].map(function() {
        return 0;
      });
    });
  };

  getTileValue = function() {
    var values;
    values = [2, 2, 2, 4];
    return values[randomInt(values.length)];
  };

  generateTile = function(board) {
    var column, row, value, _ref;
    value = getTileValue();
    _ref = randomCellIndices(), row = _ref[0], column = _ref[1];
    if (board[row][column] === 0) {
      return board[row][column] = value;
    } else {
      return generateTile(board);
    }
  };

  move = function(board, direction) {
    var column, i, newBoard, row, _i;
    newBoard = buildBoard();
    for (i = _i = 0; _i <= 3; i = ++_i) {
      switch (direction) {
        case 'right':
        case 'left':
          row = getRow(i, board);
          row = mergeCells(row, direction);
          row = collapseCells(row, direction);
          setRow(row, i, newBoard);
          break;
        case 'up':
        case 'down':
          column = getColumn(i, board);
          column = mergeCells(column, direction);
          column = collapseCells(column, direction);
          setColumn(column, i, newBoard);
      }
    }
    return newBoard;
  };

  getRow = function(r, board) {
    return [board[r][0], board[r][1], board[r][2], board[r][3]];
  };

  getColumn = function(c, board) {
    return [board[0][c], board[1][c], board[2][c], board[3][c]];
  };

  setColumn = function(columnArray, columnNumber, board) {
    var i, _i, _results;
    _results = [];
    for (i = _i = 0; _i <= 3; i = ++_i) {
      _results.push(board[i][columnNumber] = columnArray[i]);
    }
    return _results;
  };

  setRow = function(row, index, board) {
    return board[index] = row;
  };

  mergeCells = function(cells, direction) {
    var merge;
    merge = function(cells) {
      var a, b, _i, _j, _ref;
      for (a = _i = 3; _i > 0; a = --_i) {
        for (b = _j = _ref = a - 1; _ref <= 0 ? _j <= 0 : _j >= 0; b = _ref <= 0 ? ++_j : --_j) {
          if (cells[a] === 0) {
            break;
          } else if (cells[a] === cells[b]) {
            cells[a] *= 2;
            cells[b] = 0;
          } else if (cells[b] !== 0) {
            break;
          }
        }
      }
      return cells;
    };
    switch (direction) {
      case 'right':
      case 'down':
        cells = merge(cells);
        break;
      case 'left':
      case 'up':
        cells = merge(cells.reverse()).reverse();
    }
    return cells;
  };

  console.log(mergeCells([2, 2, 4, 4], 'up'));

  collapseCells = function(row, direction) {
    var i, zeroesToAdd, _i;
    row = row.filter(function(x) {
      return x !== 0;
    });
    zeroesToAdd = 4 - row.length;
    for (i = _i = 0; 0 <= zeroesToAdd ? _i < zeroesToAdd : _i > zeroesToAdd; i = 0 <= zeroesToAdd ? ++_i : --_i) {
      switch (direction) {
        case 'right':
        case 'down':
          row.unshift(0);
          break;
        case 'left':
        case 'up':
          row.push(0);
      }
    }
    console.log(row);
    return row;
  };

  printArray = function(array) {
    var row, _i, _len;
    console.log("--start--");
    for (_i = 0, _len = array.length; _i < _len; _i++) {
      row = array[_i];
      console.log(row);
    }
    return console.log("--end--");
  };

  arrayEqual = function(arr1, arr2) {
    var element, index, _i, _len;
    for (index = _i = 0, _len = arr1.length; _i < _len; index = ++_i) {
      element = arr1[index];
      if (element !== arr2[index]) {
        return false;
      }
    }
    return true;
  };

  boardEqual = function(oBoard, nBoard) {
    var e, i, _i, _len;
    for (i = _i = 0, _len = oBoard.length; _i < _len; i = ++_i) {
      e = oBoard[i];
      if (!arrayEqual(e, nBoard[i])) {
        return false;
      }
    }
    return true;
  };

  moveIsValid = function(oBoard, nBoard) {
    var result;
    result = boardEqual(oBoard, nBoard);
    return !result;
  };

  boardIsFull = function(board) {
    var row, _i, _len;
    for (_i = 0, _len = board.length; _i < _len; _i++) {
      row = board[_i];
      if (__indexOf.call(row, 0) >= 0) {
        return false;
      }
    }
    return true;
  };

  noValidMoves = function(board) {
    var direction, directions, newBoard, _i, _len;
    directions = ['right', 'left', 'up', 'down'];
    for (_i = 0, _len = directions.length; _i < _len; _i++) {
      direction = directions[_i];
      newBoard = move(board, direction);
      if (moveIsValid(board, newBoard)) {
        return false;
      }
    }
    return true;
  };

  isGameOver = function(board) {
    return boardIsFull(board) && noValidMoves(board);
  };

  showValue = function(value) {
    if (value === 0) {
      return "";
    } else {
      return value;
    }
  };

  showBoard = function(board) {
    var col, power, row, _i, _results;
    _results = [];
    for (row = _i = 0; _i <= 3; row = ++_i) {
      _results.push((function() {
        var _j, _k, _results1;
        _results1 = [];
        for (col = _j = 0; _j <= 3; col = ++_j) {
          for (power = _k = 0; _k <= 11; power = ++_k) {
            $(".r" + row + ".c" + col).removeClass('val-0');
            $(".r" + row + ".c" + col).removeClass('val-' + (Math.pow(2, power)));
            $(".r" + row + ".c" + col).addClass('val-' + board[row][col]);
          }
          _results1.push($(".r" + row + ".c" + col + " > div").html(showValue(board[row][col])));
        }
        return _results1;
      })());
    }
    return _results;
  };

  highestCurrentScore = (function(_this) {
    return function(board) {
      var col, row, score, _i, _j;
      score = 0;
      for (row = _i = 0; _i <= 3; row = ++_i) {
        for (col = _j = 0; _j <= 3; col = ++_j) {
          if (board[row][col] >= score) {
            score = board[row][col];
          }
        }
      }
      return score;
    };
  })(this);

  opacityFunction = function(maxScore) {
    var opacity;
    opacity = (function() {
      switch (maxScore) {
        case 4:
          return 1 - (1 / 11) * 1;
        case 8:
          return 1 - (1 / 11) * 2;
        case 16:
          return 1 - (1 / 11) * 3;
        case 32:
          return 1 - (1 / 11) * 4;
        case 64:
          return 1 - (1 / 11) * 5;
        case 128:
          return 1 - (1 / 11) * 6;
        case 256:
          return 1 - (1 / 11) * 7;
        case 512:
          return 1 - (1 / 11) * 8;
        case 1024:
          return 1 - (1 / 11) * 9;
        case 2048:
          return 1 - (1 / 11) * 11;
      }
    })();
    return opacity;
  };

  $(function() {
    $('#start').click(function(e) {
      e.preventDefault();
      $('#startScreen').addClass('hidden');
      return $('#game').animate({
        opacity: 1
      }, 1500);
    });
    $('#tryAgain').click((function(_this) {
      return function(e) {
        e.preventDefault();
        $('#gameOgre').css('opacity', 0);
        $('#game').show(0).animate({
          opacity: 1
        }, 1500);
        $(".cell").css('opacity', 0.9);
        _this.board = buildBoard();
        generateTile(_this.board);
        generateTile(_this.board);
        printArray(_this.board);
        return showBoard(_this.board);
      };
    })(this));
    this.currentScore = 0;
    this.maxScore = 0;
    this.opacityValue = 1;
    this.board = buildBoard();
    generateTile(this.board);
    generateTile(this.board);
    printArray(this.board);
    showBoard(this.board);
    return $('body').keydown((function(_this) {
      return function(e) {
        var direction, key, keys, newBoard;
        key = e.which;
        keys = [37, 38, 39, 40];
        if (__indexOf.call(keys, key) >= 0) {
          e.preventDefault();
          direction = (function() {
            switch (key) {
              case 37:
                return 'left';
              case 38:
                return 'up';
              case 39:
                return 'right';
              case 40:
                return 'down';
            }
          })();
          console.log("The direction is " + direction);
          newBoard = move(_this.board, direction);
          printArray(_this.board);
          printArray(newBoard);
          if (moveIsValid(_this.board, newBoard)) {
            console.log("valid");
            _this.board = newBoard;
            generateTile(_this.board);
            showBoard(_this.board);
            _this.maxScore = highestCurrentScore(_this.board);
            _this.opacityValue = opacityFunction(_this.maxScore);
            console.log(_this.maxScore);
            console.log("the current opacity value is:" + _this.opacityValue);
            $(".cell").css('opacity', _this.opacityValue);
            if (isGameOver(_this.board)) {
              $('#game').animate({
                opacity: 0
              }, 1200).hide(0);
              $('#gameOgre').animate({
                opacity: 1
              }, 1200);
              return console.log("YOU LOSE");
            }
          } else {
            return showBoard(_this.board);
          }
        } else {

        }
      };
    })(this));
  });

}).call(this);

//# sourceMappingURL=main.js.map
