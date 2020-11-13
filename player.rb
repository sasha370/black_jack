class Player

  attr_reader :name, :balance

  def initialize(name)
    @name = name
    @balance = START_BALANCE
  end

  private

  START_BALANCE = 100

end