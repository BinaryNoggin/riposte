require "riposte/reaction"

module Riposte
  module Helper
    def react_to(type, *params)
      Reaction.new(type, *params).tap { |reaction|
        yield reaction if block_given?
      }
    end
  end
end
