class Interface

  def new_game?
    clear_screen
    puts 'Выберите, что необходимо сделать '
    puts '1. Начать новую игру'
    puts '2. Посмотреть правила'
    puts '9. Выйти'
    input = gets.chomp.to_i
    case input
      when 1
        true
      when 2
        show_rules
        new_game?
      when 9
        buy_buy
      else
        clear_screen
        puts '** Вам необходимо выбрать пункт меню **'
        new_game?
    end
  end

  def greeting
    puts '♡ ♧ ♢ ♤   BlackJack   ♡ ♧ ♢ ♤'
  end

  def get_name
    print 'Как тебя зовут?:'
    name = gets.chomp
    raise puts 'Имя не может быть пустым' if name == ''
    name
  rescue
    retry
  end

  def user_choice_menu(can_take)
    spacer
    if can_take
      puts 'Выбери действие:'
      puts '1. Еще карту |  2. Пас   |  3. Вскрываем'
      gets.chomp.to_i
    end

  end

  def over_scored_message(player_name)
    puts '╔' + '═' * 32 + '╗'
    puts "║     У #{player_name} перебор!"
    puts '╚' + '═' * 32 + '╝'
  end

  def user_lose_message(args)
    puts '╔' + '═' * 32 + '╗'
    puts '║         Вы проиграли!          ║'
    puts '║ ' + "У дилера #{args[:dialer_score]}, а у вас  #{args[:user_score]}!"
    puts "║     Дилер забирает  #{args[:bank]} руб.    ║"
    puts '╚' + '═' * 32 + '╝'
  end

  def user_win_message(args)
    puts '╔' + '═' * 32 + '╗'
    puts "║     Поздравляю вы выиграли!    ║"
    puts '║  ' + "У вас  #{args[:user_score]}, а у дилера  #{args[:dialer_score]}!"
    puts "║       Ваш выигрыш #{args[:bank]} руб.      ║"
    puts '╚' + '═' * 32 + '╝'
  end

  def draw_message(bank)
    puts '╔' + '═' * 36 + '╗'
    puts '║               Ничья!               ║'
    puts "║ Деньги делятся поровну, по #{bank / 2} руб. ║"
    puts '╚' + '═' * 36 + '╝'
  end

  def spacer
    puts '--' * 20
  end

  def clear_screen
    system("cls") || system("clear") || puts("\e[H\e[2J")
  end

  def next_game_menu
      puts 'Хотите продолжить?   1. ДА  |  2. ВЫХОД '
      gets.chomp.to_i
  end

  def no_money_message
    puts 'У одного из игроков закончились деньги'
    buy_buy
  end

  def show_rules
    puts "В начале игры каждый участник делает минимульную ставку в банк"
    puts 'Игрок и дилер получаютпо 2 карты на руки'
    puts 'После этого игрок делает свой ход (Взять карту | Пропустить | Открыться)'
    puts '- Если игрок взял карту и при этом уго очки не превысили 21, то ход перезодит к дилеру'
    puts '- Если игрок Пропускает, то ход просто переходит к дилеру'
    puts '- Если игрок выбирает "Открыться", вскрываются карты обоих игроков и считаются очки'
    puts 'Игра заканчивается автоматически, если у каждого игрока на руках по три карты'
    puts 'Нажмите любую клавишу, чтобы вернуться в меню'
    gets
  end

  def buy_buy
    puts ' ♡ ♧ ♢ ♤  Спасибо за игру ♡ ♧ ♢ ♤ '
  end

  def show_user_balance(balance)
    puts "     ** Баланс #{balance} руб.  **"
    spacer
  end

  def end_of_word(score)
    if score.between?(2, 4)
      'очка'
    elsif score == 21 || score == 1
      'очко'
    elsif score.between?(22, 24)
      'очка'
    else
      'очков'
    end
  end

  def show_cards_on_table(args)
    clear_screen
    show_cards_open(args[:user_hand])
    puts " #{args[:user].name}: #{args[:user_hand].score}  #{end_of_word(args[:user_hand].score)}"
    puts '┅' * 20
    if args[:open_cards]
      show_cards_open(args[:dialer_hand])
      puts " #{args[:dialer].name}: #{args[:dialer_hand].score.to_s + ' ' + end_of_word(args[:dialer_hand].score)}"
    else
      show_cards_close(args[:dialer_hand])
      puts " #{args[:dialer].name}:  '***'}"
    end
    spacer
  end

  def show_cards_open(hand)
    hand.cards.each do |card|
      print "#{card.value}#{card.suit} "
      end
    puts
  end

  def show_cards_close(hand)
      print  " ▒ " * hand.cards.count
    puts
  end

end