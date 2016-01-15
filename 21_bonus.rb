SUITS = ['H', 'D', 'S', 'C']
VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
WINNING_SCORE = 21
DEALER_MIN = 17


def prompt(msg)
  puts "=> #{msg}"
end

def initialize_deck
  SUITS.product(VALUES).shuffle
end

def total(cards)
  # cards = [['H', '3'], ['S', 'Q'], ... ]
  values = cards.map { |card| card[1] }

  sum = 0
  values.each do |value|
    if value == "A"
      sum += 11
    elsif value.to_i == 0 # J, Q, K
      sum += 10
    else
      sum += value.to_i
    end
  end

  # correct for Aces
  values.select { |value| value == "A" }.count.times do
    sum -= 10 if sum > WINNING_SCORE
  end

  sum
end

def busted?(cards)
  total(cards) > 21
end

# :tie, :dealer, :player, :dealer_busted, :player_busted
def detect_result(dealer_cards, player_cards)
  player_total = total(player_cards)
  dealer_total = total(dealer_cards)

  if player_total > WINNING_SCORE
    :player_busted
    prompt "You busted, dealer wins!"
    return 'DEALER'
  elsif dealer_total > WINNING_SCORE
    :dealer_busted
    prompt "Dealer busted, you win!"
    return 'PLAYER'
  elsif dealer_total < player_total
    :player
    prompt "You win!"
    return 'PLAYER'
  elsif dealer_total > player_total
    :dealer
    prompt "Dealer wins."
    return 'DEALER'
  else
    :tie
    prompt "It's a tie!"
  end
end

def play_again?
    puts "-------------"
    prompt "Do you want to play again? (y or n)"
    answer = gets.chomp
    answer.downcase.start_with?('y')
end

def round_winner?(dealer_points, player_points)
  false unless dealer_points != 5 || player_points != 5
end

player_points = 0
dealer_points = 0

# ******* MAIN LOOP
loop do

  prompt "Welcome to Twenty-One!"

  # initialize vars
  deck = initialize_deck
  player_cards = []
  dealer_cards = []

  # initial deal
  2.times do
    player_cards << deck.pop
    dealer_cards << deck.pop
  end

  prompt "Dealer has #{dealer_cards[0]} and ?"
  prompt "You have: #{player_cards[0]} and #{player_cards[1]}, for a total of #{total(player_cards)}."

  # ******** player turn loop
  loop do
    player_turn = nil
    loop do
      prompt "Would you like to (h)it or (s)tay?"
      player_turn = gets.chomp.downcase
      break if ['h', 's'].include?(player_turn)
      prompt "Sorry, must enter 'h' or 's'."
    end

    if player_turn == 'h'
      player_cards << deck.pop
      prompt "You chose to hit!"
      prompt "Your cards are now: #{player_cards}"
      prompt "Your total is now: #{total(player_cards)}"
    end

    break if player_turn == 's' || busted?(player_cards)
  end

  if busted?(player_cards)
    detect_result(dealer_cards, player_cards)
    dealer_points += 1
    puts "Dealer wins:  #{dealer_points}"
    puts "Player wins: #{player_points}"
    play_again? ? next : break
  else
    prompt "You stayed at #{total(player_cards)}"
  end

  # dealer turn
  prompt "Dealer turn..."

  loop do
    break if busted?(dealer_cards) || total(dealer_cards) >= DEALER_MIN

    prompt "Dealer hits!"
    dealer_cards << deck.pop
    prompt "Dealer's cards are now: #{dealer_cards}"
  end

  if busted?(dealer_cards)
    prompt "Dealer total is now: #{total(dealer_cards)}"
    detect_result(dealer_cards, player_cards)
    player_points += 1
    puts "Dealer wins:  #{dealer_points}"
    puts "Player wins: #{player_points}"
    play_again? ? next : break
  else
    prompt "Dealer stays at #{total(dealer_cards)}"
  end

  # both player and dealer stays - compare cards!
  puts "=============="
  prompt "Dealer has #{dealer_cards}, for a total of: #{total(dealer_cards)}"
  prompt "Player has #{player_cards}, for a total of: #{total(player_cards)}"
  puts "=============="

  detect_result(dealer_cards, player_cards)

  if detect_result(dealer_cards, player_cards) == 'DEALER'
    dealer_points += 1
  elsif detect_result(dealer_cards, player_cards) == 'PLAYER'
    player_points += 1
  end

  puts "Dealer wins:  #{dealer_points}"
  puts "Player wins: #{player_points}"

  break unless round_winner?(dealer_points, player_points)

  break unless play_again?
end

prompt "Thank you for playing Twenty-One! Good bye!"