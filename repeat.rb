# Parameter to be optimised is the requested recall rate

# Forgetting index is the proportion of elements that are not remembered at repetitions. 

INITIAL_EASE_FACTOR = 2.5 # ease factor for initial items

VEASY = 5
EASY = 4
MEDIUM = 3
HARD = 2
VHARD = 1

module Repetitions
  def next_rep(iteration, last_rep, ease_factor)
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

q = [VHARD,HARD,HARD,EASY,EASY,EASY,EASY]

last_ef = INITIAL_EASE_FACTOR

q.each { |i|
  last_ef = EaseFactor.update_function(i, last_ef)
  Repetitions.next_rep()
  puts last_ef
}
