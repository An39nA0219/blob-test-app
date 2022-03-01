num = nil
until [1, 3, 5].include?(num)
  puts '何本勝負？(press 1 or 3 or 5)'
  num = gets.chomp.to_i
end

puts "#{num}本勝負を選びました\n\n"

win_num = 0
fail_num = 0

num.times do |i|
  puts "#{i + 1}本目"

  choices = { g: 'グー', c: 'チョキ', p: 'パー' }

  should_replay = true
  while should_replay
    player_choice = nil
    until choices.keys.include?(player_choice)
      puts should_replay ? 'あいこで...(press g or c or p)' : 'じゃんけん…(press g or c or p)'
      player_choice = gets.chomp.to_sym
    end

    cpu_choice = choices.keys[rand(choices.length)]

    puts "CPU…#{choices[cpu_choice]}\nあなた…#{choices[player_choice]}"

    if player_choice == cpu_choice
      should_replay = true
    elsif (player_choice == :g && cpu_choice == :c) ||
          (player_choice == :c && cpu_choice == :p) ||
          (player_choice == :p && cpu_choice == :g)
      puts '勝ち！'
      win_num += 1
      should_replay = false
    else
      puts '負け！'
      fail_num += 1
      should_replay = false
    end
  end
  puts "#{win_num}勝#{fail_num}敗\n\n"
end

winner = win_num > fail_num ? 'あなた' : 'CPU'
puts "\n結果\n#{win_num}勝#{fail_num}敗で#{winner}の勝ち"