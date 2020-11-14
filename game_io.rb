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

    #TODO
  end

  def user_choice_menu
    puts 'Выбери действие:'
    puts '1. Еще карту'
    puts '2. Пас\вскрываем'
    input = gets.chomp.to_i
    case input
      when 1
         @user.take_cards(@hand.deal_cards(1))
      when 2
         @user.flag_pass = true
      else
        user_choice_menu
    end
  end

  def  show_game_situation #TODO
    # Отрисовтаь карты
    # отрисовать очки
    puts 'ОТРИСОВКА СТОЛА '
    p " Пользователь: #{count_score(@user)} "
     @user.show_cards_open
    p " Дилер "
     @dialer.show_cards_close
    p "Банк #{@bank}"
  end


  def clear_screen
    system("cls") || system("clear") || puts("\e[H\e[2J")
  end

  def show_rules
end
