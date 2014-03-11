require 'set'

module Structor
  class Node
    attr_reader :name, :required

    def initialize(type, required, &block)
      @type = Type.new(type)
      @required = required
      @stem = block_given?
      @children = Builder.new(&block).nodes if @stem
    end

    def check(structure)
      return false unless @type.check(structure)
      if @stem
        key_set = structure.keys.to_set
        (required_keys <= key_set) && (key_set <= permitted_keys) &&
          structure.all? { |k, v| @children[k].check(v) }
      else
        true
      end
    end

    def permitted_keys
      @children.keys.to_set
    end

    def required_keys
      @children.select { |k, v| v.required }.map(&:first).to_set
    end
  end
end
