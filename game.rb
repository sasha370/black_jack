class Game
  include Game_IO
  attr_reader :name

  def initialize
    greeting
    @name = get_name
    main_menu
    @open_cards = false
  end

  def main_menu
    puts 'Выберите, что необходимо сделать '
    puts '1. Начать новую игру'
    puts '2. Посмотреть правила'
    puts '9. Выйти'
    input = gets.chomp.to_i
    case input
      when 1
        make_players
        new_game
      when 2
        show_rules
      when 9
        buy_buy
      else
        clear_screen
        puts '** Вам необходимо выбрать пункт меню **'
        main_menu
    end
  end

  def new_game
    clear_screen
    set_players
    puts ' Новая игра началась'
    @hand = Hand.new
    @bank = 0
    make_bets(@players)
    deal_cards(@players)
    play_game
    open_cards
    next_game?
  end

  def make_players
    @user = User.new(@name)
    @dialer = Dialer.new
  end

  def set_players
    @players = []
    @players << @user
    @players << @dialer
  end

  def make_bets(players)
    players.each do |player|
      @bank += player.make_bet
    end
  end

  def deal_cards(players)
    players.each do |player|
      player.take_cards(@hand.deal_cards)
      player.score = count_score(player)
    end
  end

  def count_score(player)
    player.score = @hand.score(player.cards)
  end

  def play_game
    until stop_game?
      clear_screen
      user_move
      break if player_over_scored?(@user) || stop_game? || @open_cards
      dialer_move
      break if player_over_scored?(@dialer)
    end
  end

  def user_move
    show_info
    user_choice_menu
    count_score(@user)
  end

  def dialer_move
    show_info
    @dialer.take_cards(@hand.deal_one_card) if @dialer.take_card?
    count_score(@dialer)
  end

  def stop_game?
    players_pass? || players_limit_cards_reached?
  end

  def player_over_scored?(player)
    if @hand.over_score?(player.score)
      player.flag_lose = true
    end

  end

  def next_game?
    if @user.have_money?
      puts 'Хотите продолжить?   1. ДА  |  2. НЕТ'
      choice = gets.chomp.to_i
      case choice
        when 1
          start_next_game
        when 2
          buy_buy
        else
          clear_screen
          puts '** Вам необходимо выбрать пункт меню **'
          next_game?
      end
    else
      puts 'В вашем кошельке денег меньше, чем минимальная ставка'
      buy_buy
    end
  end

  def start_next_game
    @players.each do |player|
      player.clean_status
    end
    @open_cards = false
    new_game
  end

  private

  def show_info
    clear_screen
    @user.score = @hand.score(@user.cards)
    @dialer.score = @hand.score(@dialer.cards)
    @user.show_cards_open
    puts " #{@user.name}: #{@user.score} очков"
    @open_cards ? @dialer.show_cards_open : @dialer.show_cards_close
    puts " #{@dialer.name}: #{@open_cards ? @dialer.score : '*'} очков"
  end

  def open_cards
    @open_cards = true
    show_info
    spacer
    define_winner
  end

  def players_limit_cards_reached?
    !@user.can_take_card? && !@dialer.can_take_card?
  end

  def players_pass?
    @user.flag_pass && @dialer.flag_pass
  end

  def define_winner
    if @user.flag_lose
      dialer_win { "У вас перебор #{@user.score}!" }
    elsif @dialer.flag_lose
      user_win { "У дилера перебор #{@dialer.score}!" }
    else
      define_winner_by_score
    end
  end

  def define_winner_by_score
    if @user.score == @dialer.score
      draw
    elsif @user.score > @dialer.score
      user_win { "У вас  #{@user.score}, а у дилера всего #{@dialer.score}!" }
    else
      dialer_win { "У дилера #{@dialer.score}, а у вас всего #{@user.score}!" }
    end
  end

  def user_win(&block)
    puts " ** Поздравляю вы выиграли! " + yield + " Ваш выигрыш #{@bank} руб. ** "
    @user.take_money(@bank)
    show_user_balance
  end

  def dialer_win(&block)
    puts "Вы проиграли! " + yield + " Дилер забирает выигрыш #{@bank} руб."
    @dialer.take_money(@bank)
    show_user_balance
  end

  def draw
    puts "Ничья!!! Деньги делятся поровну, по #{@bank / 2} руб."
    @user.take_money(@bank / 2)
    @dialer.take_money(@bank / 2)
    show_user_balance
  end
end