require 'arrow/composed_function'

RSpec.describe Arrow::ComposedFunction do
  describe 'one function' do
    it 'calls the function' do
      f = F . first
      result = f.([1])
      expect(result).to eq(1)
    end
  end

  describe 'two functions' do
    it 'composes them and calls the composed function' do
      first = ->(x) { x.first }
      last  = ->(x) { x.last }
      f = F . fn(&first) . fn(&last)
      result = f.([1, [2, 3]])
      expect(result).to eq(2)
    end
  end
end
