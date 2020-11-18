class Dialer < Player

  def post_initialize(args)
    @name = 'Dialer'
  end

  def take_more_card?(score)
    if score < 17
      true
    else
      false
    end
  end
end