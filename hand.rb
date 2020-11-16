class Hand
  attr_accessor :cards, :score

  def initialize
    @cards = []
    @score = 0
  end

  def take_cards(cards)
    @cards.concat(cards)
    @score = self.score
  end

  def over_score?
    @score > WIN_SCORE
  end

  def score
    total = 0
    ace_count = 0
    @cards.each do |card|
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