player_total = 0
dealer_total = 0
win = 21
dealer_min = 17
player_wins = 0
dealer_wins = 0

def calc_hand_total(player_hand)
  player_total = 0
  player_hand.each do |x|
    if x.include?('J')
      player_total += 10
    elsif x.include?('Q')
      player_total += 10
    elsif x.include?('K')
      player_total += 10
    elsif x.include?('A')
      player_total += 11
    else
      b = x[0].to_i
      player_total += b
    end
  end
  if player_total > 21
    player_hand.each do |x|
      if x.include?('A')
        player_total -= 10
      end
    end
  end
  player_total
end

def dealer_calc_hand_total(dealer_hand)
  dealer_total = 0
  dealer_hand.each do |x|
    if x.include?('J')
      dealer_total += 10
    elsif x.include?('Q')
      dealer_total += 10
    elsif x.include?('K')
      dealer_total += 10
    elsif x.include?('A')
      dealer_total += 11
    else
      b = x[0].to_i
      dealer_total += b
    end
  end
  if dealer_total > 21
    dealer_hand.each do |x|
      if x.include?('A')
        dealer_total -= 10
      end
    end
  end
  dealer_total
end

def play(user_name, dealer_total, player_total, dealer_min, win, player_wins, dealer_wins)
  cards = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
  suit = ['H', 'C', 'D', 'S']
  deck = cards.product(suit)
  deck.shuffle!
  player_hand = []
  dealer_hand = []
  puts "Alright, #{user_name}. Let me deal out the cards."
  player_hand << deck.pop
  player_hand << deck.pop
  dealer_hand << deck.pop
  dealer_hand << deck.pop
  puts "*****Your cards:  #{player_hand}"
  sleep 1
  puts "dealer upcard: #{dealer_hand[0]}"
  player_total = calc_hand_total(player_hand)
  puts "player total before while loop: #{player_total}"
  sleep 1
  if player_total < win
    puts "Would you like to hit or stay?"
    player_hit_or_stay = gets.chomp
    while player_hit_or_stay.downcase == 'h'
      player_hand << deck.pop
      puts "player hand is now: #{player_hand}"
      player_total = calc_hand_total(player_hand)
      puts "player total is now #{player_total}"
      sleep 1
      if player_total > win
        puts "You bust!"
        break
      end
      puts "Would you like to hit or stay? h/s"
      player_hit_or_stay = gets.chomp
    end
  end

  dealer_total = dealer_calc_hand_total(dealer_hand)
  if dealer_total < dealer_min && player_total <= win
    while dealer_total < dealer_min
      puts "Dealer is drawing another card"
      sleep 1
      dealer_hand << deck.pop
      dealer_total = dealer_calc_hand_total(dealer_hand)
    end
  end

  puts "Now we compare scores:"
  puts "*****Player hand is: #{player_hand}"
  puts "Player total is: #{player_total}"
  puts " "
  sleep 1
  puts "......Dealer hand is #{dealer_hand}"
  puts "Dealer total is #{dealer_total}"
  puts " "
  if player_total > win && dealer_total > win
    puts "We're both out."
  elsif player_total > win
    puts "You bust, dealer wins."
    dealer_wins += 1
  elsif dealer_total > win
    puts "Dealer bust, player wins."
    player_wins += 1
  elsif player_total == win
    puts "You've got blackjack!"
    player_wins += 1
  elsif player_total > dealer_total
    puts "Player wins"
    player_wins += 1
  elsif dealer_total > player_total
    puts "Dealer wins"
    dealer_wins += 1
  elsif player_total == dealer_total
    puts "We tie!"
  end
  puts "Player wins:  #{player_wins}"
  puts "Dealer wins: #{dealer_wins}"
  sleep 1
  puts "Would you like to play again? y/n"
  user_input2 = gets.chomp
  if user_input2.downcase == 'y'
    play(user_name, dealer_total, player_total, dealer_min, win, player_wins, dealer_wins)
  else
    puts "Goodbye, thanks for playing!"
  end
end

puts "Hello!  Welcome to 21.  Would you like to play? y/n"
user_input = gets.chomp
if user_input.downcase == 'y'
  puts "What is your name?"
  user_name = gets.chomp
  play(user_name, dealer_total, player_total, dealer_min, win, player_wins, dealer_wins)
else
  puts "Goodbye, then!"
end
