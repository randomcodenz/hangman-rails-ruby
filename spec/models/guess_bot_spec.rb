require 'rails_helper'

describe GuessBot do
  describe '#calculate_guesses' do
    # No idea how to test this other than using worked examples
    it 'when the word is "e" 1 guess is required' do
      expect(GuessBot.calculate_guesses('e')).to eq ['e']
    end

    it 'when the word is "z" 26 guesses are required' do
      expect(GuessBot.calculate_guesses('z')).to eq LetterFrequencyAnalysis.letters_by_frequency
    end

    # e, t (from letters_by_frequency)
    # h, o (from letters following_letters_by_frequency)
    it 'when the word is "to" 4 guesses are required' do
      expect(GuessBot.calculate_guesses('to')).to eq ['e', 't', 'h', 'o']
    end

    # e, t (from letters_by_frequency)
    # s, n, a, i (from letters following_letters_by_frequency)
    # NOTE: This will be solved faster using letters_by_frequency only! 
    it 'when the word is "it" 6 guesses are required' do
      expect(GuessBot.calculate_guesses('it')).to eq ['e', 't', 's', 'n', 'a', 'i']
    end
  end

end
