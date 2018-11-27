module Arrow
  class Functor
    def self.fmap(&_f)
      raise NotImplementedError, "this functor doesn't implement fmap"
    end
  end
end
