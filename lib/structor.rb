require "structor/version"

require 'structor/builder'
require 'structor/node'
require 'structor/structure'
require 'structor/type'

module Structor
  def self.define(&block)
    Structure.new(&block)
  end
end
