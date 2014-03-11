require 'spec_helper'

describe Structor::Builder do
  it 'provides DSL to define structure' do
    builder = Structor::Builder.new do
      requires :node_1, :boolean
      optional :node_2, :string
      requires :node_3 do
        requires :node_4, :array
        optional :node_5, :number
      end
    end
    expect(builder.nodes.size).to eq 3
  end
end
