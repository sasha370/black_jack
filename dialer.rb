class Dialer < Player

  def initialize(name = 'Dialer')
    super(name)
  end

  def take_card?
    if self.score < 17 && can_take_card?
      true
    else
      self.flag_pass = true
      false
    end
  end
end