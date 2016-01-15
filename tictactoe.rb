# 1. Display the initial empty 3x3 board.
# 2. Ask the user to mark a square.
# 3. Computer marks a square.
# 4. Display the updated board state.
# 5. If winner, display winner.
# 6. If board is full, display tie.
# 7. If neither winner nor board is full, go to #2
# 8. Play again?
# 9. If yes, go to #1
# 10. Good bye!

# x = "hello".gsub!(/[aeiou]/, "*")

board = [" "," "," "," "," "," "," "," "," "]

def initialize_board(board)
  puts " "
  puts "_#{board[0]}_|_#{board[1]}_|_#{board[2]}_"
  puts "_#{board[3]}_|_#{board[4]}_|_#{board[5]}_"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
  puts " "
end

initialize_board(board)
puts "Welcome to Tic Tac Toe!"
puts "Please pick a number on the board to pick your starting spot:"
puts " "
puts "__1__|__2__|__3__"
puts "__4__|__5__|__6__"
puts "  7  |  8  |  9  "
puts " "

player_move = gets.chomp.to_i

# player_move = 32
# if player_move.to_i < 10 && player_move.to_i > 0
#   puts "hello"
# end

if player_move < 10 && player_move > 0
  board[player_move].gsub!(" ", "X")
end

p board
initialize_board(board)

computer_turn = board.sample

puts "#{computer_turn}"

p computer_turn

board.index(computer_turn).gsub!(" ", "O")
initialize_board(board)





















