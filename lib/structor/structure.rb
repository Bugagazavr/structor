module Structor
  class Structure
    def initialize(&block)
      @root = Node.new(:root, &block)
    end

    def check(structure)
    end
  end
end
