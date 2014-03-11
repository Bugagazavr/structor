# Structor

A simple DSL to define nested data structure schema and perform validations generating verbose error messages.

## Usage


    structure = Structor.define do
      requires :node_1, :boolean             # TrueClass or FalseClass
      requires 'node_2', :string
      optional :node_3, :array
      requires :node_4 do
        requires :node_5 do
          requires :node_6, [String, Fixnum] # can be both String and Fixnum
          optional 7, [Hash, Array]
        end
      end
      optional :node_8, [:hash, Object] do   # inner structure will be checked if node_8 is a Hash
        requires :node_9, :string            # will not cause error if node_8 is missing
      end
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
