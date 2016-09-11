require 'rails_helper'

describe Word, type: :model do
  context 'when validating a word' do
    subject { Word.new(:word => 'xyzzy', :difficulty => 10) }

    it { is_expected.to validate_presence_of(:word) }

    it { is_expected.to validate_presence_of(:difficulty) }

    it { is_expected.to validate_numericality_of(:difficulty).only_integer.is_greater_than(0) }

    it { is_expected.to validate_uniqueness_of(:word).case_insensitive }
  end
end
