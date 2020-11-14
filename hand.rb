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

  def deal_one_card
    deal_cards(1)
  end

  def score(cards)
    total = 0
    cards.each do |card|
      total += get_card_value(card)
    end
    total
  end

  protected

  DEFAULT_VALUE = 10
  ACE_VALUE_MIN = 1
  ACE_VALUE_MAX = 11

  private

  def get_card_value(card)
    if %w[J Q K].include? card.value
      DEFAULT_VALUE
    elsif card.value == 'A'
      ACE_VALUE_MIN
    else
      card.value.to_i
    end
  end
end