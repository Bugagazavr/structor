module Structor
  class Builder
    attr_accessor :nodes

    def initialize(&block)
      @nodes = []
      instance_eval(&block)
    end

    def requires(name, type = :hash, &block)
      @nodes.push(Node.new(name, type, true, &block))
    end

    def optional(name, type = :hash, &block)
      @nodes.push(Node.new(name, type, false, &block))
    end
  end
end
