module Riposte
  module Helper
    def react_to(type)
      Reaction.new(type).tap { |reaction|
        yield reaction if block_given?
      }
    end
  end
end
