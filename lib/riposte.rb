require "riposte/version"

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

    module Helper
      def react_to(type, with: ->() {})
        with.call Reaction.new(type)
      end
    end
  end
end
