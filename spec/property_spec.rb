require 'spec_helper'

describe Propr::Dsl::Property do
  describe '::wrap' do
    let(:f4){ lambda { |a, b, c, d| true } }
    let(:p){ Propr::Dsl::Property.wrap(f4) }

    it 'should wrap blocks with arity 4' do
      p.call(true, true, true, true)
    end
  end
end
