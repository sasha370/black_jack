require_relative 'card'
class Deck

  attr_reader :cards

  def initialize
    @cards = make_cards
  end

  private

  def make_cards
    cards = []
    Card::VALUE.each do |value|
      Card::SUIT.each do |suit|
        cards << Card.new(suit,value)
      end
    end
    cards.shuffle!
  end
end
