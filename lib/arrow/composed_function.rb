module Arrow
  class ComposedFunction
    def self.comp(f, g)
      -> (*args) { f[g[*args]] }
    end

    def initialize(functions=[])
      @functions = functions
    end

    def fn(*args, &block)
      f = -> arguments, receiver {
        block.(receiver, *arguments)
      }.curry[args]
      ComposedFunction.new(@functions + [f])
    end

    def method_missing(method, *args, &block)
      f = -> arguments, receiver {
        receiver.send(method, *arguments, &block)
      }.curry[args]
      ComposedFunction.new(@functions + [f])
    end

    def call(*args)
      if @functions.any?
        @functions.reduce { |f, g| ComposedFunction.comp(f, g) }.(*args)
      else
        args.first
      end
    end

    def to_ary
      @functions.to_ary
    end
  end
end

F = Arrow::ComposedFunction.new
