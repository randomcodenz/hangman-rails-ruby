require 'rails_helper'
require 'spec_helper'

describe ConditionalPartial do
  let(:template) { 'template' }

  subject(:partial) { ConditionalPartial.new(template, object) }

  context 'when created with an object that is not nil' do
    let(:object) { 5 }

    it 'creates a ConditionalPartial::RenderPartial instance' do
      expect(partial).to be_a ConditionalPartial::RenderPartial
    end
  end

  context 'when created with a nil object' do
    let(:object) { nil }

    it 'creates a ConditionalPartial:SkipPartial instance' do
      expect(partial).to be_a ConditionalPartial::SkipPartial
    end
  end

  describe ConditionalPartial::SkipPartial do
    let(:template) { 'some_partial' }
    let(:object) { nil }

    subject(:skip_partial) { ConditionalPartial.new(template, object) }

    describe '#render_if' do
      it 'returns a ConditionalPartial::RenderPartial instance if should_render is true' do
        expect(skip_partial.render_if(true)).to be_a ConditionalPartial::RenderPartial
      end

      it 'returns self if should_render is false' do
        expect(skip_partial.render_if(false)).to be skip_partial
      end
    end

    describe '#render_unless' do
      it 'returns self if skip_render is true' do
        expect(skip_partial.render_unless(true)).to be skip_partial
      end

      it 'returns a ConditionalPartial::RenderPartial instance if skip_render is false' do
        expect(skip_partial.render_unless(false)).to  be_a ConditionalPartial::RenderPartial
      end
    end

    describe '#render' do
      it 'does nothing' do
        expect(skip_partial.render).to be_nil
      end
    end

    describe '#to_ary' do
      it 'returns an empy array' do
        expect(skip_partial.to_ary).to be_empty
      end
    end
  end

  describe ConditionalPartial::RenderPartial do
    let(:template) { 'some_partial' }
    let(:object) { 5 }

    subject(:render_partial) { ConditionalPartial.new(template, object) }

    it 'delegates all public methods of object except to_ary to object'
    #TODO: How to test this? Can assert on public_methods contents but that does not
    #TODO: ensure they are delegated - should we only assert the interface?

    describe '#render_if' do
      it 'returns self if should_render is true' do
        expect(render_partial.render_if(true)).to be render_partial
      end

      it 'returns a ConditionalPartial::SkipPartial instance if should_render is false' do
        expect(render_partial.render_if(false)).to be_a ConditionalPartial::SkipPartial
      end
    end

    describe '#render_unless' do
      it 'returns a ConditionalPartial::SkipPartial instance if skip_render is true' do
        expect(render_partial.render_unless(true)).to be_a ConditionalPartial::SkipPartial
      end

      it 'returns self if skip_render is false' do
        expect(render_partial.render_unless(false)).to be render_partial
      end
    end

    describe '#object' do
      it 'returns the object passed to the constructor' do
        expect(render_partial.object).to be object
      end
    end

    describe '#to_partial_path' do
      it 'returns the partial passed to the constructor' do
        expect(render_partial.to_partial_path).to be template
      end
    end
  end
end
