class Card
  attr_reader :suit, :value
  SUIT = %w[♡ ♧ ♢ ♤]
  VALUE = %w[2 3 4 5 6 7 8 9 10 J Q K A]

  def initialize(suit,value)
    @suit = suit
    @value = value
  end
end