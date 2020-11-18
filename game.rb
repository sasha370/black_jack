require_relative 'interface'

class Game

  def initialize
    @interface = Interface.new
    @interface.greeting
    make_players
    @interface.new_game? ? new_game : exit
  end

  def new_game
    @open_cards = false
    @deck = Deck.new
    @bank = 0
    @loser = nil
    make_bets
    make_hands
    deal_cards
    play_game
    show_game_results
    next_game?
  end

  def make_players
    @user = User.new({ name: @interface.get_name })
    @dialer = Dialer.new
  end

  def make_bets
    @bank += @user.make_bet
    @bank += @dialer.make_bet
  end

  def make_hands
    @user_hand = Hand.new
    @dialer_hand = Hand.new
  end

  def deal_cards
    @user_hand.take_cards(@deck.deal_cards)
    @dialer_hand.take_cards(@deck.deal_cards)
  end

  def play_game
    until @open_cards
      user_move
      break if hand_over_scored?(@user_hand) || game_over?
      dialer_move
      break if hand_over_scored?(@dialer_hand) || game_over?
    end
  end

  def user_move
    show_info
    choice = @interface.user_choice_menu(@user_hand.can_take_card?)
    case choice
      when 1
        @user_hand.take_cards(@deck.deal_one_card)
      when 2
        dialer_move
      when 3
        @open_cards = true
      else
        user_move
    end
  end

  def dialer_move
    if @dialer_hand.can_take_card?
      if @dialer.take_more_card?(@dialer_hand.score)
        @dialer_hand.take_cards(@deck.deal_one_card)
      else
        @open_cards = true
      end
    end
  end

  def game_over?
    @open_cards || hand_limit_cards_reached?
  end

  def hand_over_scored?(hand)
    if hand.over_score?
      @loser = hand
      true
    end
  end

  def hand_limit_cards_reached?
    !@user_hand.can_take_card? && !@dialer_hand.can_take_card?
  end

  def next_game?
    if @user.have_money? && @dialer.have_money?
      case @interface.next_game_menu
        when 1
          new_game
        when 2
          @interface.show_user_balance(@user.balance)
          @interface.buy_buy
          exit
        else
          next_game?
      end
    else
      @interface.no_money_message
      exit
    end
  end

  def show_game_results
    @open_cards = true
    show_info
    define_winner
    @interface.show_user_balance(@user.balance)
  end

  def show_info
    @interface.show_cards_on_table({ user: @user,
                                     user_hand: @user_hand,
                                     dialer: @dialer,
                                     dialer_hand: @dialer_hand,
                                     open_cards: @open_cards })
  end

  def define_winner
    if @loser == @user_hand
      @interface.over_scored_message(@user.name)
      user_lose
    elsif @loser == @dialer_hand
      @interface.over_scored_message(@dialer.name)
      user_win
    else
      define_winner_by_score
    end
  end

  def define_winner_by_score
    if @user_hand.score == @dialer_hand.score
      draw
    elsif @user_hand.score > @dialer_hand.score
      user_win
    else
      user_lose
    end
  end

  def game_results
    { user_score: @user_hand.score,
      dialer_score: @dialer_hand.score,
      bank: @bank }
  end

  def user_win
    @interface.user_win_message(game_results)
    @user.take_money(@bank)
  end

  def draw
    @interface.draw_message(@bank)
    @user.take_money(@bank / 2)
    @dialer.take_money(@bank / 2)
  end

  def user_lose
    @interface.user_lose_message(game_results)
    @dialer.take_money(@bank)
  end
end