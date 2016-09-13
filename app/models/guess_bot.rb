class GuessBot
  class << self
    def calculate_guesses(word)
      # Loop through single letters in order of frequency until we get a match
      # TODO: Loop through bigrams trying letters in order of frequency
      letters_guessed = word.chars.map { |letter| [letter.downcase, false] }.to_h
      letters_guessed.default = false

      guess_candidates = LetterFrequencyAnalysis.letters_by_frequency
      guess_attempts = []

      until word_guessed?(letters_guessed) || possibles_exhausted(guess_attempts)
        guess_candidates = reject_previous_attempts(guess_candidates, guess_attempts)
        attempts = next_guesses(guess_candidates, letters_guessed)

        correct_guesses = attempts & letters_guessed.keys
        correct_guesses.each { |guess| letters_guessed[guess] = true }

        # Stop unbounded loop exection - we should always get more attempts in each loop
        loop_check = guess_attempts.length
        guess_attempts.concat(attempts).uniq!
        raise "No additional attempts found" if loop_check == guess_attempts.length
      end

      guess_attempts
    end

    private

    def word_guessed?(letters_guessed)
      letters_guessed.all? { |letter, guessed| guessed }
    end

    def possibles_exhausted(guess_attempts)
      possibles = ('a'..'z').to_a - guess_attempts
      possibles.empty?
    end

    def reject_previous_attempts(guess_candidates, guess_attempts)
      guess_candidates.reject { |candidate| guess_attempts.include?(candidate) }
    end

    def next_guesses(guess_candidates, letters_guessed)
      first_correct_guess = guess_candidates.find_index do |letter|
        !letters_guessed[letter] && letters_guessed.keys.include?(letter)
      end

      if first_correct_guess.nil?
        first_correct_guess = guess_candidates.length
      else
        first_correct_guess += 1
      end

      guess_candidates.slice(0, first_correct_guess)
    end
  end
end
