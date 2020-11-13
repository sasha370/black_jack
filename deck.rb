require_relative 'card'

class Deck
  attr_reader :deck

  SUIT = %w[♡ ♧ ♢ ♤]
  VALUE = %w[2 3 4 5 6 7 8 9 10 J Q K A]

  def initialize
    @deck = make_deck
  end

  private

  def make_deck
    deck = []
    VALUE.each do |value|
      SUIT.each do |suit|
        deck << Card.new(suit,value)
      end
    end
    deck.shuffle!
  end

end
