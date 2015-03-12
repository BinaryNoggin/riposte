module Riposte
  class Reaction
    attr_accessor :type, :params
    private :type=, :params=
    protected :params, :type

    def initialize(type, *params)
      self.type = type
      self.params = params
    end

    def method_missing(name, *)
      if name == type
        yield(*params) if block_given?
      end
    end

    def respond_to_missing?(*)
      true
    end

    def ==(other)
      [self.class, self.type, self.params] == [other.class, other.type, other.params]
    end
  end
end
