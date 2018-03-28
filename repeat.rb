require 'pp'

INITIAL_EASE_FACTOR = 2.5 # ease factor for initial items

VEASY = 5
EASY = 4
MEDIUM = 3
HARD = 2
VHARD = 1

ONE_DAY = 1
SIX_DAYS = 6

module Repetitions
  def self.next_rep(iteration, last_interval, ease_factor)

    case iteration
      when 1
        return ONE_DAY
      when 6
        return SIX_DAYS
      else
        return last_interval*ease_factor
    end

  end
end

module EaseFactor
  # Magic numbers, anyway to clarify the significance of the numbers in this formula?
  def self.update_function(q, ef)
    ef - 0.8 + 0.28 * q - 0.02 * q * q
  end
end

class Card
  def initialize()
    @ef = INITIAL_EASE_FACTOR
    @reps = 0
    @next_rep = 0
  end
  def review(score)
    @reps += 1
    @ef = EaseFactor.update_function(score, @ef)
    @next_rep = Repetitions.next_rep(@reps, @next_rep, @ef)
    @next_rep
  end
end

scores = [1,2,3,2,3]

ease_factor = INITIAL_EASE_FACTOR
last_rep = 0

card = Card.new
pp [EASY,EASY,VEASY, MEDIUM, EASY, VEASY,HARD,HARD].map { |q|
  card.review(q)
}
