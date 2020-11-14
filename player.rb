class Player

  attr_reader :name, :balance
  attr_accessor :cards, :flag_lose, :flag_pass

  def initialize(name)
    @name = name || 'Player'
    @balance = START_BALANCE
    @cards = []
    @flag_lose = false
    @flag_pass = false
  end

  # - взять карты у Hand
  # - показывать карты
  # - делать ставку
  # - забирать деньги
  #
  def make_bet
    @balance -= MIN_BET
    MIN_BET
  end

  def take_cards(cards)
    @cards.concat(cards)
  end

  private

  def have_money?
    self.balance > 0
  end

  def lose_money?
    @flag_lose = true if @balance < MIN_BET
  end

  MIN_BET = 10
  START_BALANCE = 100

end