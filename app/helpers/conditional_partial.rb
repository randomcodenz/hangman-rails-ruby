class ConditionalPartial
  def ConditionalPartial.new(partial, object=nil)
    if object.nil?
      SkipPartial.new(partial, object)
    else
      RenderPartial.new(partial, object)
    end
  end

   private

  class SkipPartial
    def initialize(partial, object)
      @partial = partial
      @object = object
    end

    def render_if(should_render)
      if should_render
        RenderPartial.new(@partial, @object)
      else
        self
      end
    end

    def render_unless(skip_render)
      render_if(!skip_render)
    end

    # TemplateRenderer will :respond_to? this so we can abuse that and return nil
    def render
    end

    # PartialRenderer will :respond_to? this to switch into collection rendering
    # mode so abuse that and return an empty array
    def to_ary
      []
    end
  end

  class RenderPartial
    extend Forwardable

    attr_reader :object

    # This object will be create as a local with the same name as the
    # partial so forward all calls to the object
    def initialize(partial, object)
      @partial = partial
      @object = object
      delegate_to = delegated_methods
      (class << self; self; end).class_eval do
        def_delegators :'@object', *delegate_to
      end
    end

    def render_if(should_render)
      if should_render
        self
      else
        SkipPartial.new(@partial, @object)
      end
    end

    def render_unless(skip_render)
      render_if(!skip_render)
    end

    # Renderers use this to determine the partial to render
    def to_partial_path
      @partial
    end

    private

    # PartialTemplateRenderer uses respond_to? :to_ary to switch into collection rendering
    # mode (which we don't want) so exclude it from the set of forwarded methods
    # If you want collection rendering - you don't need ConditionalPartial ;)
    def delegated_methods
      @object.public_methods(false).reject { |method| method == :to_ary }
    end
  end
end
