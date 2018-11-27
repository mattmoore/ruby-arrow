require 'arrow/maybe'

RSpec.describe Arrow::Maybe do
  let(:error_function) { -> (x) { raise "Throwing error on purpose" } }

  describe 'lift' do
    context 'when a non-nil value is available' do
      let(:monad) { Maybe(1) }
      it 'returns the Just functor' do
        expect(monad).to eq(Just(1))
      end
    end

    context 'when a value is not present' do
      let(:monad) { Maybe(nil) }
      it 'returns the Nothing functor' do
        expect(monad).to eq(Nothing())
      end
    end
  end

  describe '== identity function' do
    context 'when equal' do
      it 'returns true' do
        expect(Maybe(1) == Maybe(1)).to be(true)
      end
    end

    context 'when not equal' do
      it 'returns false' do
        expect(Maybe(1) == Maybe(2)).to be(false)
      end
    end
  end

  describe 'fmap' do
    context 'when fmap succeeds' do
      let(:times_two) { -> x { x * 2 } }
      let(:result) { Maybe(1).fmap(&times_two) }
      it 'applies a function to the functor' do
        expect(result).to eq(Just(2))
      end
    end

    context 'when fmap encounters an error' do
      let(:result) { Maybe(1).fmap(&error_function) }
      it 'returns Nothing functor' do
        expect(result).to eq(Nothing())
      end
    end
  end

  describe '* infix fmap' do
    context 'when fmap succeeds' do
      let(:add) { -> x, y { x + y } }
      let(:result) { Maybe(add) * Maybe(1) * Maybe(1) }
      it 'applies a function to the functor' do
        expect(result).to eq(Just(2))
      end
    end

    context 'when fmap encounters a failure' do
      let(:result) { Maybe(error_function) * Maybe(1) * Maybe(1) }
      it 'returns Nothing functor' do
        expect(result).to eq(Nothing())
      end
    end
  end

  describe 'unwrapping' do
    let(:inc) { -> x { x + 1 } }
    let(:result) do
      Maybe(1) >> -> x { Maybe(inc[x]) >> -> x { Maybe(inc[x]) } }
    end
    it 'returns the final value' do
      expect(result).to eq(Just(3))
    end
  end
end
