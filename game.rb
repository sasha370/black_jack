require_relative 'interface'

class Game


  def initialize
    @interface = Interface.new
    @open_cards = false #TOdo
    @deck = Deck.new
    @interface.greeting
    make_players
    main_menu
  end

  def main_menu
    puts 'Выберите, что необходимо сделать '
    puts '1. Начать новую игру'
    puts '2. Посмотреть правила'
    puts '9. Выйти'
    input = gets.chomp.to_i
    case input
      when 1
        new_game
      when 2
        @interface.show_rules
        main_menu
      when 9
        @interface.buy_buy
      else
        # clear_screen todo
        puts '** Вам необходимо выбрать пункт меню **'
        main_menu
    end
  end



  def new_game
    # clear_screen # todo
    set_players
    puts ' Новая игра началась'
    @bank = 0
    make_bets(@players)
    deal_cards(@players)
    play_game
    show_open_cards
    next_game?
  end

  def make_players
    @user = User.new({name:  @interface.get_name})
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
      player.hand.take_cards(@deck.deal_cards)
    end
  end


  def play_game
    until stop_game?
      @interface.clear_screen
      user_move unless @user.flag_pass # можно убрать проверку, но придется пасовать повторно после хода дилера
      break if player_over_scored?(@user) || stop_game? || @open_cards
      dialer_move
      break if player_over_scored?(@dialer)
    end
  end

  def user_move
    show_info
    user_choice_menu
  end

  def user_choice_menu
    @interface.spacer
    if @user.can_take_card?
      puts 'Выбери действие:'
      puts '1. Еще карту |  2. Пас   |  3. Вскрываем'
      input = gets.chomp.to_i
      case input
        when 1
          @user.hand.take_cards(@deck.deal_one_card)
        when 2
          @user.flag_pass = true
        when 3
          @open_cards = true
        else
          user_choice_menu
      end
    else
      @user.flag_pass = true
    end
  end

  def dialer_move
    show_info
    @dialer.hand.take_cards(@deck.deal_one_card) if @dialer.take_card?
  end

  def stop_game?
    players_pass? || players_limit_cards_reached?
  end

  def player_over_scored?(player)
    if player.hand.over_score?
       player.flag_lose = true
    end
  end

  def players_limit_cards_reached?
    !@user.can_take_card? && !@dialer.can_take_card?
  end

  def players_pass?
    @user.flag_pass && @dialer.flag_pass
  end

  def next_game?
    if @user.have_money?
      puts 'Хотите продолжить?   1. ДА  |  2. ВЫХОД '
      choice = gets.chomp.to_i
      case choice
        when 1
          start_next_game
        when 2
          @interface.show_user_balance(@user.balance)
          @interface.buy_buy
        else
          @interface.clear_screen
          puts '** Вам необходимо выбрать пункт меню **'
          next_game?
      end
    else
      puts 'В вашем кошельке денег меньше, чем минимальная ставка'
      @interface. buy_buy
    end
  end

  def start_next_game
    @players.each do |player|
      player.clean_status
    end
    @open_cards = false
    new_game
  end

  def show_open_cards
    @open_cards = true
    show_info
    define_winner
  end

  def show_info
    @interface.show_cards_on_table(@user, @dialer, @open_cards)
  end

  def define_winner
    if @user.flag_lose
      @interface.over_scored_message(@user)
      @interface.show_user_balance(@user.balance)
    elsif @dialer.flag_lose
      @interface.over_scored_message(@dialer)
      @interface.show_user_balance(@user.balance)
    else
      define_winner_by_score
    end
  end

  def define_winner_by_score
    if @user.hand.score == @dialer.hand.score
      draw
    elsif @user.hand.score > @dialer.hand.score
      user_win
    else
      user_lose
    end
  end

  def user_win(&block)
    @interface.user_win_message(@user.hand.score, @dialer.hand.score, @bank, &block)
    @user.take_money(@bank)
    @interface.show_user_balance(@user.balance)
  end

  def draw
    @interface.draw_message(@bank)
    @user.take_money(@bank / 2)
    @dialer.take_money(@bank / 2)
    @interface.show_user_balance(@user.balance)
  end

  def user_lose(&block)
    @interface.user_lose_message(@user.hand.score, @dialer.hand.score, @bank, &block)
    @dialer.take_money(@bank)
    @interface.show_user_balance(@user.balance)
  end
end