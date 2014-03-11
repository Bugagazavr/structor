require "structor/version"

require 'structor/type'
require 'structor/builder'
require 'structor/node'

module Structor
  def self.define(&block)
    Node.new(:hash, true, &block)
  end
end
