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


    data1 = { node_1: false,
	      'node_2' => 'ok',
	      node_3: [1, 2, 3],
	      node_4: { node_5: {
		node_6: 100,
		7 => [] }},
	      node_8: { node_9: 'ok' }}

    structure.check(data1) #=> true
    structure.errors #=> []

    data2 = { node_1: 1,
	      node_2: 'ok',
	      node_3: {},
	      node_4: { node_5: 'str' },
	      node_8: { node_9: 'ok',
			node_10: 'extra' }}

    structure.check(data2) #=> false

    structure.errors #=> [
       'missing keys: ["node_2"]',
       'excess keys: [:node_2]',
       ':node_1 => invalid type: expected TrueClass|FalseClass, got Fixnum',
       ':node_3 => invalid type: expected Array, got Hash',
       ':node_4 => :node_5 => invalid type: expected Hash, got String',
       ':node_8 => excess keys: [:node_10]'
    ]

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
