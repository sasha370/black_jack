module Game_IO
  # модуль отвечает за отрисовку базовых событий( отображение игрального стола, карт, рубашек  и т.п.)

  private

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

  def spacer
    puts '--' * 20
  end

  def user_choice_menu
    spacer
    if @user.can_take_card?
    puts 'Выбери действие:'
    puts '1. Еще карту |  2. Пас   |  3. Вскрываем'
    input = gets.chomp.to_i
    case input
      when 1
        @user.take_cards(@hand.deal_one_card)
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

  def clear_screen
    system("cls") || system("clear") || puts("\e[H\e[2J")
  end

  def show_rules
    puts "В начале игры каждый участник делает минимульную ставку в банк"
    puts 'Игрок и дилер получаютпо 2 карты на руки'
    puts 'После этого игрок делает свой ход (Взять карту | Пропустить | Открыться)'
    puts '- Если игрок взял карту и при этом уго очки не превысили 21, то ход перезодит к дилеру'
    puts '- Если игрок Пропускает, то ход просто переходит к дилеру'
    puts '- Если игрок выбирает "Открыться", вскрываются карты обоих игроков и считаются очки'
    puts 'Игра заканчивается автоматически, если у каждого игрока на руках по три карты'
  end

  def buy_buy
    puts ' ♡ ♧ ♢ ♤  Спасибо за игру ♡ ♧ ♢ ♤ '
    exit
  end

  def show_user_balance
    puts " Ваш баланс #{@user.balance} руб."
  end
end