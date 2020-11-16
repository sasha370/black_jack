class Player

  attr_reader :name, :balance
  attr_accessor :cards, :flag_pass, :score, :flag_lose, :hand

  def initialize(args = {})
    @balance = START_BALANCE
    @hand = Hand.new
    @flag_pass = false
    @flag_lose = false
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

  def show_cards_open
    @hand.cards.each do |card|
      print "#{card.value}#{card.suit} "
    end
    puts
  end

  def show_cards_close
    @hand.cards.each do
      print  " ▒ "
    end
      puts
  end

  def can_take_card?
    @hand.cards.count < 3
  end

  def have_money?
    self.balance >= MIN_BET
  end

  def clean_status
    self.flag_lose = false
    self.flag_pass = false
    @hand = Hand.new
  end

  private

  MIN_BET = 10
  START_BALANCE = 100
end