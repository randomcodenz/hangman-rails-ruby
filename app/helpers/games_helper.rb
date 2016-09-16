module GamesHelper
  def render_masked_word(masked_letters)
    masked_letters
      .map { |masked_letter| render_letter(masked_letter) }
      .join(' ')
  end

  def guess_attempt(guess_attempt)
    if guess_attempt.nil?
      MaybeTemplate.new()
    else
      MaybeTemplate.new('guess_attempt', guess_attempt)
    end
  end

  def guess_result(guess_correct, guess_attempt)
    if guess_correct.nil?
      MaybeTemplate.new()
    else
      guess_result_template = guess_correct ? 'guess_correct' : 'guess_incorrect'
      {:partial => guess_result_template, :locals => { :guess_attempt => guess_attempt } }
    end
  end

  def incorrect_guesses(incorrect_guesses)
    if incorrect_guesses.any?
      MaybeTemplate.new('incorrect_guesses', incorrect_guesses)
    else
      MaybeTemplate.new()
    end
  end

  def game_over(game)
    if game.game_over?
      template = game.game_won? ? 'game_won' : 'game_lost'
      { :partial => MaybeTemplate.new(template), :locals => { :word => game.word } }
    else
      MaybeTemplate.new()
    end
  end

  def game_in_progress(game)
    if game.game_over?
      MaybeTemplate.new()
    else
      { :partial => MaybeTemplate.new('game_in_progress'), :locals => { :game => game } }
    end
  end

  private

  def render_letter(masked_letter)
    masked_letter.nil? ? '_' : masked_letter
  end

  # TODO: Needs better names - could probably use the outer class as an eigenclass
  # TODO: to hold a method for creating the desired instance (None | Some)
  # TODO: None is more like SkipRendering and Some is more like DoRendering
  class MaybeTemplate
  	def MaybeTemplate.new(*args)
  		if args.empty?
  			None.new()
  		else
  			Some.new(*args)
  		end
  	end

	   private

  	class None
      # TemplateRenderer will :respond_to? this so we can abuse that and return nil
      def render
      end

      # PartialRenderer will :respond_to? this to switch into collection rendering
      # mode so abuse that and return an empty array
      def to_ary
        []
  		end
  	end

  	class Some
      extend Forwardable

      # This object will be create as a local with the same name as the
      # template so forward all calls to the object
      def initialize(template, object=nil)
  			@template = template
        @object = object
        delegate_to = delegated_methods
        (class << self; self; end).class_eval do
          def_delegators :'@object', *delegate_to
        end
  		end

      # Renderers use this to determine the partial to render
      def to_partial_path
  			@template
  		end

      private

      # PartialTemplateRenderer uses respond_to? :to_ary to switch into collection rendering
      # mode (which we don't want) so exclude it from the set of forwarded methods
      # If you want collection rendering - you don't need MaybeTemplate ;)
      def delegated_methods
        @object.public_methods(false).reject { |method| method == :to_ary }
      end
  	end
  end
end
