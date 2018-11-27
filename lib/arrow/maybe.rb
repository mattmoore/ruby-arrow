require 'arrow/monad'

module Arrow
  class Maybe < Monad
    attr_accessor :value
    
    def self.lift(value)
      return Nothing.new if value.nil?
      Just.new(value)
    rescue
      Nothing.new
    end

    def ==(other)
      value == other.value
    end

    def *(other)
      self >-> f do
        f = f.to_proc
        other >-> val do
          Maybe.lift(f.arity > 1 ? f.curry.(val) : f.(val))
        end
      end
    rescue
      Nothing.new
    end
  end

  class Just < Maybe
    def initialize(value)
      @value = value
    end

    def fmap(&f)
      Maybe.lift(f.(@value))
    rescue
      Nothing.new
    end

    def >(f)
      f.(@value)
    rescue
      Nothing.new
    end

    def or(other=nil, &other_f)
      self
    end

    def to_s
      "Just(#{@value.inspect})"
    end
    alias inspect to_s
  end

  class Nothing < Maybe
    def fmap(&f)
      self
    end

    def >(f)
      self
    end

    def or(other = self, &other_f)
      return other_f.() if other_f
      other
    end

    def to_s
      'Nothing'
    end
    alias inspect to_s
  end
end

Maybe   = Arrow::Maybe.method(:lift)
Just    = Arrow::Just.method(:lift)
Nothing = Arrow::Nothing.method(:lift)

def Maybe(v)
  Maybe.(v)
end

def Nothing()
  Nothing.(nil)
end

def Just(v)
  Just.(v)
end
