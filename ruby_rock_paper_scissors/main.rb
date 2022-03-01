class Hand
  CHOICES = { g: 'グー', c: 'チョキ', p: 'パー' }
end

class Player < Hand
  attr_accessor :should_replay

  @player_choice = nil
  @should_replay = false

  def select_hand
    puts @should_replay ? 'あいこで...(press g or c or p)' : 'じゃんけん…(press g or c or p)'
    @player_choice = gets.chomp.to_sym
  end
end

class Cpu < Hand
  @cpu_choice = nil  

  def select_hand
    @cpu_choice = CHOICES.keys[rand(CHOICES.length)]
  end
end

class Janken  
  def initialize(player, cpu, hand)
    @player = player
    @cpu = cpu
    @hand = hand
    @WIN = { g: :p, c: :g, p: :c}
    @num = 0
    @win_count = 0
    @fail_count = 0
  end

  def battle_sequence
    self.select_battle_times
    @num.times do
      self.battle
      self.battle while @player.should_replay
      puts "#{@win_count}勝#{@fail_count}敗\n\n"
    end
    self.announce_result
  end

private

  def select_battle_times
    until [1, 3, 5].include?(@num)
      puts '何本勝負？(press 1 or 3 or 5)'
      @num = gets.chomp.to_i
    end
  end

  def battle
    @player_choice = @player.select_hand
    @cpu_choice = @cpu.select_hand
    puts "CPU…#{@cpu_choice}\nあなた…#{@player_choice}"
    jadge(@player_choice, @cpu_choice)
  end

  def jadge(player_choice, cpu_choice)
    case player_choice
    when cpu_choice then
      @player.should_replay = true
    when @WIN[cpu_choice]
      puts '勝ち！'
      @player.should_replay = false
      @win_count += 1
    else
      puts '負け！'
      @player.should_replay = false
      @fail_count += 1
    end
  end

  def announce_result
    winner = @win_count > @fail_count ? 'あなた' : 'CPU'
    puts "\n結果\n#{@win_count}勝#{@fail_count}敗で#{winner}の勝ち"
  end
end

player = Player.new
cpu = Cpu.new
hand = Hand.new
janken = Janken.new(player, cpu, hand)
janken.battle_sequence
