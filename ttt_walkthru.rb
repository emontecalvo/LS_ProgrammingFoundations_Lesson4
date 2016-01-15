INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'


def prompt(msg)
  puts "=> #{msg}"
end

def display_board(brd)
  system 'clear'
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end

def initialize_board
  # don't have to pass in a board because you're returning a new board
  new_board = {}

  #iterate thru this range, then populate new board with a space
  (1..9).each {|num| new_board[num] = INITIAL_MARKER}

  new_board # return new board
  # this works because new_board[num] = the syntax of how we
  # create a new key-value pair in a hash
  # (1..9) is [num] is the key
end

def empty_squares(brd)
  brd.keys.select{|num| brd[num] == INITIAL_MARKER}
end


def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square (#{empty_squares(brd).join(', ')}):"
    square = gets.chomp.to_i
    # hashes have the .keys method to return an array of keys
    break if empty_squares(brd).include?(square)
      prompt "Sorry, that's not a valid choice."
  end

    brd[square] = PLAYER_MARKER
end

def computer_places_piece!(brd)
  square = empty_squares(brd).sample # this will return an array of integers we can call sample on
  brd[square] = COMPUTER_MARKER
end

board = initialize_board
display_board(board)

# for a method to modify local variable we have to
# pass it in, & if we modify the state of the board

def board_full?(brd)
  empty_squares(brd).empty?
end


def someone_won?(brd)
  false
end

loop do
  player_places_piece!(board)
  computer_places_piece!(board)
  display_board(board)
  break if someone_won?(board) || board_full?(board)
end

display_board(board)





