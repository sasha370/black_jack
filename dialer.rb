class Dialer < Player

  def initialize(name = 'Dialer')
    super(name)
  end

  def make_choice(score, hand)
    if score < 17
      self.take_cards(hand.deal_one_card)
    else
      self.flag_pass = true
    end
  end

end