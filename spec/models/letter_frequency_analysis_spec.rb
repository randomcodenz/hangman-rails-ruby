require 'rails_helper'

describe LetterFrequencyAnalysis do
  describe '#letters_by_frequency' do
    it 'returns the most frequent letter first' do
      expect(LetterFrequencyAnalysis.letters_by_frequency.first).to eq 'e'
    end

    it 'returns the least frequent letter last' do
      expect(LetterFrequencyAnalysis.letters_by_frequency.last).to eq 'z'
    end
  end

  describe '#letter_ranking_map' do
    it 'the most frequent letter has rank 1' do
      expect(LetterFrequencyAnalysis.letter_ranking_map['e']).to eq 1
    end

    it 'the least frequent letter has rank 26' do
      expect(LetterFrequencyAnalysis.letter_ranking_map['z']).to eq 26
    end
  end

  describe '#following_letters_by_frequency' do
    it 'returns the most frequent letter that follows first' do
      expect(LetterFrequencyAnalysis.following_letters_by_frequency('e').first).to eq 'r'
    end

    it 'returns the least frequent letter that follows last' do
      expect(LetterFrequencyAnalysis.following_letters_by_frequency('z').last).to eq 'i'
    end

    it 'is not case sensitive' do
      expect(LetterFrequencyAnalysis.following_letters_by_frequency('e')).to eq LetterFrequencyAnalysis.following_letters_by_frequency('E')
    end

    it 'returns [] if value is more than one character' do
      expect(LetterFrequencyAnalysis.following_letters_by_frequency('ee')).to be_empty
    end

    it 'returns [] if value is not a letter' do
      expect(LetterFrequencyAnalysis.following_letters_by_frequency('!')).to be_empty
    end
  end

  describe '#preceeding_letters_by_frequency' do
    it 'returns the most frequent letter that preceedes first' do
      expect(LetterFrequencyAnalysis.preceeding_letters_by_frequency('e').first).to eq 'h'
    end

    it 'returns the least frequent letter that preceedes last' do
      expect(LetterFrequencyAnalysis.preceeding_letters_by_frequency('z').last).to eq 'o'
    end

    it 'is not case sensitive' do
      expect(LetterFrequencyAnalysis.preceeding_letters_by_frequency('e')).to eq LetterFrequencyAnalysis.preceeding_letters_by_frequency('E')
    end

    it 'returns [] if value is more than one character' do
      expect(LetterFrequencyAnalysis.preceeding_letters_by_frequency('ee')).to be_empty
    end

    it 'returns [] if value is not a letter' do
      expect(LetterFrequencyAnalysis.preceeding_letters_by_frequency('!')).to be_empty
    end
  end
end
