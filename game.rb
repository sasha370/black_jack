class Game
  include Game_IO
  # Класс полностью отвечает за внешний интерфес:
  #-  ведет коммуникацию с User
  # Расширен Game_io для визуализации (=шаблон страницы)
  attr_reader :name

  def initialize
    greeting
    @name = get_name
    main_menu
  end

  def main_menu
    puts 'Выберите, что необходимо сделать '
    puts '1. Начать новую игру'
    puts '2. Продолжить игру'
    puts '3. Посмотреть правила'
    puts '9. Выйти'
    input = gets.chomp.to_i
    case input
      when 1
        new_game
      when 2
        next_game
      when 3
        show_rules
      when 9
        puts ' ♡ ♧ ♢ ♤  Спасибо за игру ♡ ♧ ♢ ♤ '
        exit
      else
        clear_screen
        puts '** Вам необходимо выбрать пункт меню **'
        main_menu
    end
  end

  def new_game
      clear_screen
      puts ' Новая игра началась'
      @user = User.new(@name)
      @dialer = Dialer.new
      # puts "Игрок #{@user.name}, баланс #{@user.balance}"
      # puts "Дилер #{@dialer.name}, баланс #{@dialer.balance}"
      @hand = Hand.new
      @bank = 0
      make_bets # игроки вносят деньги, банк принимет ставку
      deal_cards # - рука раздает карты \ игроки принимают карты

      # - рука подчиьывает очки  = проверяет флаги
      # - раздает ся по карте \ подсчитываются очки \ ЦИКЛ
      #
  end

  def make_bets
    @bank += @user.make_bet
    @bank += @dialer.make_bet
  end

  def deal_cards
    @user.take_cards(@hand.deal_cards)
    @dialer.take_cards(@hand.deal_cards)
  end


  def next_game
    ##TODO проверить, что уже была создана игра
    # Проверить, что у игроков есть деньги для ставки
  end

  private


  def game_over?
    # @user.lose? || @dialer.lose?
  end
end