class Dialer < Player

  def post_initialize(args)
    @name = 'Dialer'
  end

  def take_card?
    if @hand.score < 17 && can_take_card?
      true
    else
      self.flag_pass = true
      false
    end
  end
end