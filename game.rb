class Game
  include Game_IO
  # Класс полностью отвечает за внешний интерфес:
  #-  ведет коммуникацию с User
  # Расширен Game_io для визуализации (=шаблон страницы)
  attr_reader :name

  def initialize
    greeting
    @name = get_name
    p user = User.new(@name)
    Table.new(user)
  end


end