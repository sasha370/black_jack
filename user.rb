class User < Player

  def post_initialize(args)
    @name = args[:name]
  end
end