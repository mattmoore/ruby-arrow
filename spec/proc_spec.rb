require 'arrow/proc'

RSpec.describe Proc do
  describe '* compose' do
    it 'composes them and calls the composed function' do
      first = ->(x) { x.first }
      last  = ->(x) { x.last }
      composed = last * first * last
      expect(composed.([1, [[2, 3], 4]])).to eq(3)
    end
  end
end
