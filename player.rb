class Player

  attr_reader :name, :balance
  attr_accessor :cards, :flag_pass, :score, :flag_lose

  def initialize(name)
    @name = name || 'Player'
    @balance = START_BALANCE
    @cards = []
    @score = 0
    @flag_pass = false
    @flag_lose = false
  end

  def make_bet
    @balance -= MIN_BET
    MIN_BET
  end

  def take_cards(cards)
    @cards.concat(cards)
  end

  def take_money(amount)
    @balance += amount
  end

  def show_cards_open
    self.cards.each do |card|
      print "#{card.value}#{card.suit} "
    end
    puts
  end

  def show_cards_close
    self.cards.each do
      print  "▒ "
    end
      puts
  end

  def can_take_card?
    self.cards.count < 3
  end

  def have_money?
    self.balance >= MIN_BET
  end


  def clean_status
    self.flag_lose = false
    self.flag_pass = false
    self.score = 0
    self.cards = []
  end

  private

  MIN_BET = 10
  START_BALANCE = 100
end