module Structor
  class Type
    def initialize(specification)
      @specification = Array(specification)
        .map { |type| TYPE_MAP[type] || type }
        .flatten
    end

    TYPE_MAP = {
      string: String,
      number: Numeric,
      array: Array,
      hash: Hash,
      boolean: [TrueClass, FalseClass]
    }

    def check(value)
      @specification.any? { |type| value.is_a?(type) }
    end
  end
end
