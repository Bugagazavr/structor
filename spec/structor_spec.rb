require 'spec_helper'

describe Structor do
  let(:structure) do
    Structor.define do
      requires :node_1, :boolean
      requires 'node_2', :string
      optional :node_3, :array
      requires :node_4 do
        requires :node_5 do
          requires :node_6, [String, Fixnum]
          optional 7, [Hash, Array]
        end
      end
      optional :node_8, [:hash, Object] do
        requires :node_9, :string
      end

      optional :node_11, [:hash, Object] do
        requires :node_12
      end
    end
  end

  let(:valid_data_1) do
    { node_1: false,
      'node_2' => 'ok',
      node_3: [1, 2, 3],
      node_4: { node_5: {
        node_6: 100,
        7 => []
      }},
      node_8: { node_9: 'ok' }}
  end

  let(:valid_data_2) do
    { node_1: true,
      'node_2' => '',
      node_4: { node_5: {
        node_6: '' }},
        node_8: :symbol,
      node_11: {}}
  end

  let(:invalid_data_1) do
    { node_1: 1,
      node_2: 'ok',
      node_3: {},
      node_4: { node_5: 'str' },
      node_8: { node_9: 'ok',
                node_10: 'extra' }}
  end

  it 'check valid data structures' do
    expect(structure.check(valid_data_1)).to be_truthy
    expect(structure.check(valid_data_2)).to be_truthy
  end

  it 'returns errors for invalid data' do
    expect(structure.check(invalid_data_1)).to be_falsey
    expect(structure.errors).to eq([
      'missing keys: ["node_2"]',
      'excess keys: [:node_2]',
      ':node_1 => invalid type: expected TrueClass|FalseClass, got Fixnum',
      ':node_3 => invalid type: expected Array, got Hash',
      ':node_4 => :node_5 => invalid type: expected Hash, got String',
      ':node_8 => excess keys: [:node_10]'])
  end

  it 'clears errors from previous check' do
    structure.check(invalid_data_1)
    expect(structure.check(valid_data_1)).to be_truthy
    expect(structure.errors).to be_empty
  end
end
