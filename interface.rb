class Interface

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

  def count_free_space_in_line(line_length, word, have_char)
    (line_length - word.length - have_char).to_i
  end

  def over_scored_message(player)
    spaces = ' ' * (count_free_space_in_line(35, player.name, 15) / 2)
    puts '╔' + '═' * 33 + '╗'
    puts "║ " + spaces + "У #{player.name} перебор!"
    puts '╚' + '═' * 33 + '╝'
  end

  def user_lose_message(user_score, dialer_score, bank)
    puts '╔' + '═' * 32 + '╗'
    puts '║         Вы проиграли!          ║'
    puts '║ ' + "У дилера #{dialer_score}, а у вас всего #{user_score}!" + ' ║'
    puts "║     Дилер забирает  #{bank} руб.    ║"
    puts '╚' + '═' * 32 + '╝'
  end

  def user_win_message(user_score, dialer_score, bank)
    puts '╔' + '═' * 35 + '╗'
    puts "║     Поздравляю вы выиграли!       ║"
    puts '║  ' + "У вас  #{user_score}, а у дилера всего #{dialer_score}!" + '  ║'
    puts "║       Ваш выигрыш #{bank} руб.         ║"
    puts '╚' + '═' * 35 + '╝'
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
    # system("cls") || system("clear") || puts("\e[H\e[2J")
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
  end

  def buy_buy
    puts ' ♡ ♧ ♢ ♤  Спасибо за игру ♡ ♧ ♢ ♤ '
    exit
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

  def show_cards_on_table(user, dialer, open_cards)
    clear_screen
    user_score = user.hand.score
    dialer_score = dialer.hand.score
    user.show_cards_open
    puts " #{user.name}: #{user_score}  #{end_of_word(user_score)}"
    puts '┅' * 20
    if open_cards
      dialer.show_cards_open
      puts " #{dialer.name}: #{dialer_score.to_s + ' ' + end_of_word(dialer_score)}"
    else
      dialer.show_cards_close
      puts " #{dialer.name}:  '***'}"
    end
    spacer
  end
end