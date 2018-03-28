# Parameter to be optimised is the requested recall rate

# Forgetting index is the proportion of elements that are not remembered at repetitions. 

INITIAL_EASE_FACTOR = 2.5 # ease factor for initial items

VEASY = 5
EASY = 4
MEDIUM = 3
HARD = 2
VHARD = 1

module Repetitions
  def self.next_rep(iteration, last_rep, ease_factor)
    return 1 if iteration == 1
    return 6 if iteration == 2
    return last_rep*ease_factor
  end
end

module EaseFactor
  def update(ef, q)
  
  end
  def self.update_function(q, ef)
    ef - 0.8 + 0.28 * q - 0.02 * q * q
  end
end

class Card
  def initialize()
    @ef = INITIAL_EASE_FACTOR
    @reps = 1
    @next_rep = Repetitions.next_rep(@reps, 0, @ef)
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
card.review(HARD)
card.review(HARD)
card.review(VHARD)
card.review(VEASY)
card.review(MEDIUM)
