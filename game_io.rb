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

end