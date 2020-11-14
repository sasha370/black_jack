require_relative 'deck'
class Hand
  # - создать колоду
  # - раздать по 2 карты ( удалить из колоды)
  # - добавить по 1 карте ( удалить из колоды)
  # - посчитать очки
  # - проверить на выигрыш
  # - поменять флаг, если перебор
  # - проверить на флаг PASS
  # -
  attr_reader :cards

  def initialize
    deck = Deck.new
    @cards = deck.cards
  end

  def deal_cards(count = 2)
    @cards.sample(count)
  end
end