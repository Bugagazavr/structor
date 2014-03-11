module Structor
  class Node
    attr_reader :required

    def initialize(name, type, required, &block)
      @name = name.to_s
      @type = Type.new(type)
      @required = required
      @children = Builder.new(&block).nodes
    end
  end
end
