class Table
  # Класс отвечает за логику игры
  # - выбирает ход игрока
  # - анализирует WIN\Lose
  # - проверяет флаги

  def initialize(user, dialer)
    @user = user
    puts ' Новая игра началась'
    puts "Игрок #{@user.name}, баланс #{@user.balance}"
  end
end