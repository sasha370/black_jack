class User < Player
  attr_accessor  :open_cards

  def initialize(name)
    super
    @open_cards = false
  end

  end