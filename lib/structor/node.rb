require 'set'

module Structor
  class Node
    attr_reader :required

    def initialize(type, required, &block)
      @type = Type.new(type)
      @required = required
      @children = block_given? ? Builder.new(&block).nodes : []
      @errors = []
    end

    def check(structure)
      clear_errors

      if @type.check(structure)
        if @children.any? && structure.is_a?(Hash)
          key_set = structure.keys.to_set

          unless required_keys <= key_set
            @errors << "missing keys: #{(required_keys - key_set).to_a}"
          end

          unless key_set <= permitted_keys
            @errors << "excess keys: #{(key_set - permitted_keys).to_a}"
          end

          structure.each { |k, v| @children[k] && @children[k].check(v) }
        end
      else
        @errors << "invalid type: expected #{@type.describe}, "\
          "got #{structure.class.name}"
      end

      errors.empty?
    end

    def errors
      @errors + @children.map do |key, node|
        node.errors.map { |e| "#{key.inspect} => #{e}" }
      end.flatten
    end

    def clear_errors
      @errors.clear
      @children.each { |k, v| v.clear_errors }
    end

    private

    def permitted_keys
      @permitted_keys ||= @children.keys.to_set
    end

    def required_keys
      @required_keys ||=
        @children.select { |k, v| v.required }.map(&:first).to_set
    end
  end
end
