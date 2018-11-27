class Proc
  def self.compose(f, g)
    -> (*args) { f[g[*args]] }
  end

  def *(g)
    Proc.compose(self, g)
  end
end
