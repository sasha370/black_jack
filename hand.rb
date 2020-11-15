class Hand
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

  def over_score?(score)
    score > WIN_SCORE
  end

  def score(cards)
    total = 0
    ace_count = 0
    cards.each do |card|
      total += get_card_value(card)
      ace_count += 1 if card.value == 'A'
    end
    total_score_whit_aces(ace_count, total)
  end

  protected

  DEFAULT_VALUE = 10
  ACE_VALUE_MIN = 1
  ACE_VALUE_MAX = 11
  WIN_SCORE = 21

  private

  def get_card_value(card)
    if %w[J Q K].include? card.value
      DEFAULT_VALUE
    elsif card.value == 'A'
      return 0
    else
      card.value.to_i
    end
  end

  def  total_score_whit_aces(ace_count, total)
    ace_count.times do
      if (total + ACE_VALUE_MAX ) <= 21
        total += ACE_VALUE_MAX
      else
        total += ACE_VALUE_MIN
      end
    end
    total
  end
end