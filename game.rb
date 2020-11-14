class Game
  include Game_IO
  # Класс полностью отвечает за внешний интерфес:
  #-  ведет коммуникацию с User
  # Расширен Game_io для визуализации (=шаблон страницы)
  attr_reader :name

  def initialize
    greeting
    @name = get_name
    Table.new(User.new(@name), Dialer.new)
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
        next_game #TODO проверить, что уже была создана игра
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
    
  end

  def next_game
    #TODO
  end


end