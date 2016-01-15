INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]

def prompt(msg)
  puts "=> #{msg}"
end

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize
def display_board(brd)
  system 'clear'
  puts "You're an #{PLAYER_MARKER}, computer is an #{COMPUTER_MARKER}"
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
# rubocop:enable Metrics/MethodLength, Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def joinor(arr, delimiter, word='or')
  arr[-1] = "#{word} #{arr.last}" if arr.size > 1
  arr.join(delimiter)
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def find_at_risk_square(line, brd)
  if board.values_at(*line).count('X') == 2
    board.select{|k,v| line.include?(k) && v == ' '}.keys.first
  else
    nil
  end
end

def player_places_piece!(brd)
  square = ''
  loop do
    # prompt "Choose a square (#{empty_squares(brd).join(', ')}):"
    prompt "Choose a position to place a piece: #{joinor(empty_squares(brd), ', ')}"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice."
  end
  brd[square] = PLAYER_MARKER
end

def find_at_risk_square(line, board, marker)
  if board.values_at(*line).count(marker) == 2
    board.select{|k,v| line.include?(k) && v == INITIAL_MARKER}.keys.first
  else
    nil
  end
end

def computer_places_piece!(brd)
  square = nil

    # offense
    WINNING_LINES.each do |line|
      square = find_at_risk_square(line, brd, COMPUTER_MARKER)
      break if square
  end

  # defense
  if !square
    WINNING_LINES.each do |line|
      square = find_at_risk_square(line, brd, PLAYER_MARKER)
      break if square
    end
  end

  # fill up middle square
  if !square
    empty_squares(brd).each do |k, v|
      if k[4] == nil
        square = empty_squares(4)
      end
    end
  end

  # just pick a square
  if !square
    square = empty_squares(brd).sample
  end

  brd[square] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

loop do
  player_wins = 0
  computer_wins = 0
  prompt "Would you like to go first?  y/n"
  player_order = gets.chomp
  # computer goes first
  if player_order.downcase != 'y'
    loop do
      board = initialize_board
      loop do
        display_board(board)
        computer_places_piece!(board)
        display_board(board)
        break if someone_won?(board) || board_full?(board)
        player_places_piece!(board)
        break if someone_won?(board) || board_full?(board)
      end
      display_board(board)
      if someone_won?(board)
        prompt "#{detect_winner(board)} won!"
        if detect_winner(board) == 'Computer'
          computer_wins += 1
        elsif detect_winner(board) == 'Player'
          player_wins += 1
        end

      else
        prompt "It's a tie!"
      end
      puts "Player wins: #{player_wins}"
      puts "Computer wins: #{computer_wins}"
      if computer_wins == 5
        break
      elsif player_wins == 5
        break
      end
      prompt "Play again? (y or n)"
      answer = gets.chomp
      break unless answer.downcase.start_with?('y')
    end
  break
  # player goes first
  else
    loop do
      board = initialize_board
      loop do
        display_board(board)
        player_places_piece!(board)
        break if someone_won?(board) || board_full?(board)
        computer_places_piece!(board)
        break if someone_won?(board) || board_full?(board)
      end
      display_board(board)
      if someone_won?(board)
        prompt "#{detect_winner(board)} won!"
        if detect_winner(board) == 'Computer'
          computer_wins += 1
        elsif detect_winner(board) == 'Player'
          player_wins += 1
        end

      else
        prompt "It's a tie!"
      end
      puts "Player wins: #{player_wins}"
      puts "Computer wins: #{computer_wins}"
      if computer_wins == 5
        break
      elsif player_wins == 5
        break
      end
      prompt "Play again? (y or n)"
      answer = gets.chomp
      break unless answer.downcase.start_with?('y')
    end
    break
  end
end

prompt "Thanks for playing Tic Tac Toe! Goodbye!"