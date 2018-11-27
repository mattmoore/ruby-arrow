require 'arrow/functor'

module Arrow
  class Monad < Functor
    def >(_other)
      raise NotImplementedError, "this monad doesn't implement >->"
    end

    def >>(other)
      self > other
    end
  end
end
