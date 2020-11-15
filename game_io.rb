module Game_IO
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

  def dialer_win(&block)
    puts '╔' + '═' * 32 + '╗'
    puts '║         Вы проиграли!          ║'
    puts '║ ' + yield + ' ║'
    puts "║     Дилер забирает  #{@bank} руб.    ║"
    puts '╚' + '═' * 32 + '╝'
    @dialer.take_money(@bank)
    show_user_balance
  end

  def user_win(&block)
    puts '╔' + '═' * 35 + '╗'
    puts "║     Поздравляю вы выиграли!       ║"
    puts '║  ' + yield + '  ║'
    puts "║       Ваш выигрыш #{@bank} руб.         ║"
    puts '╚' + '═' * 35 + '╝'
    @user.take_money(@bank)
    show_user_balance
  end

  def draw
    puts '╔' + '═' * 36 + '╗'
    puts '║               Ничья!               ║'
    puts "║ Деньги делятся поровну, по #{@bank / 2} руб. ║"
    puts '╚' + '═' * 36 + '╝'
    @user.take_money(@bank / 2)
    @dialer.take_money(@bank / 2)
    show_user_balance
  end

  def spacer
    puts '--' * 20
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
    puts 'Нажмите любую клавишу, чтобы вернуться в меню'
    gets
    main_menu
  end

  def buy_buy
    puts ' ♡ ♧ ♢ ♤  Спасибо за игру ♡ ♧ ♢ ♤ '
    exit
  end

  def show_user_balance
    puts "     ** Баланс #{@user.balance} руб.  **"
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
end