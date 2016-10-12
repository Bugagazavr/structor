require 'spec_helper'

describe Structor::Type do
  it 'checks type' do
    expect(Structor::Type.new(Array).check([])).to be_truthy
    expect(Structor::Type.new(Fixnum).check(1)).to be_truthy
    expect(Structor::Type.new(Hash).check([])).to be_falsey
    expect(Structor::Type.new(TrueClass).check(false)).to be_falsey
  end

  it 'maps symbol to type' do
    expect(Structor::Type.new(:string).check('test')).to be_truthy
    expect(Structor::Type.new(:hash).check({})).to be_truthy
    expect(Structor::Type.new(:array).check([])).to be_truthy
    expect(Structor::Type.new(:number).check(42)).to be_truthy
    expect(Structor::Type.new(:number).check(-1.01)).to be_truthy
    expect(Structor::Type.new(:boolean).check(true)).to be_truthy
    expect(Structor::Type.new(:boolean).check(false)).to be_truthy
  end

  it 'checks for multiple types' do
    expect(Structor::Type.new([Array, :hash]).check([])).to be_truthy
    expect(Structor::Type.new([Array, :hash]).check({})).to be_truthy
    expect(Structor::Type.new([TrueClass, FalseClass]).check(true)).to be_truthy
    expect(Structor::Type.new([TrueClass, FalseClass]).check(false)).to be_truthy
  end
end
