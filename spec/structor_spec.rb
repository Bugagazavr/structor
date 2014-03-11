require 'spec_helper'

describe Structor do
  it 'creates a structure definition' do
    structure = Structor.define do
      requires :node_1, :boolean
      optional :node_2, :string
      requires :node_3 do
        requires :node_4, :array
        optional :node_5, :number
      end
    end
  end

  it 'checks a data structure' do
    data = {a: 1, b: true}
    structure = Structor.define do
      requires :a, :number
      requires :b, :boolean
    end
    expect(structure.check(data)).to be_true
  end

  it 'returns false if data structure is invalid' do
    data = {a: 1, b: 1}
    structure = Structor.define do
      requires :a, :number
      requires :b, :boolean
    end
    expect(structure.check(data)).to be_false
  end
end
