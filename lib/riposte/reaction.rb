module Riposte
  class Reaction
    attr_accessor :type

    def initialize(type)
      self.type = type
    end

    def method_missing(name, *)
      if name == type
        yield if block_given?
      end
    end

    def respond_to_missing?(*)
      true
    end

    def ==(other)
      [self.class, self.type] == [other.class, other.type]
    end
  end
end
