require 'rails_helper'

describe GamesHelper, type: :helper do
  describe '#render_masked_word' do
    let(:word) { 'Powershop' }

    context "when no letters are guessed" do
      let(:game) { Game.new( { :word => word, :initial_lives => 5} ) }

      it 'renders all of the nils as underscores' do
        expect(helper.render_masked_word(game)).to eq word.chars.map { '_' }.join(' ')
      end
    end
  end
end
