class Player

  attr_reader :name, :balance

  def initialize(args = {})
    @balance = START_BALANCE
    post_initialize(args)
  end

  def post_initialize(args)
    nil
  end

  def make_bet
    @balance -= MIN_BET
    MIN_BET
  end

  def take_money(amount)
    @balance += amount
  end

  def have_money?
    self.balance >= MIN_BET
  end

  private

  MIN_BET = 10
  START_BALANCE = 100
end