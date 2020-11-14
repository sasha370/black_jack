require_relative 'card'

class Deck
  SUIT = %w[♡ ♧ ♢ ♤]
  VALUE = %w[2 3 4 5 6 7 8 9 10 J Q K A]

  attr_reader :cards

  def initialize
    @cards = make_cards
  end

  private

  def make_cards
    cards = []
    VALUE.each do |value|
      SUIT.each do |suit|
        cards << Card.new(suit,value)
      end
    end
    cards.shuffle!
  end

end
