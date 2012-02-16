module Propr
  autoload :Characters,     "propr/characters"
  autoload :Property,       "propr/property"
  autoload :Random,         "propr/random"
  autoload :Base,           "propr/base"
  autoload :RSpec,          "propr/rspec"
  autoload :RSpecProperty,  "propr/rspec"
  autoload :TestUnit,       "propr/testunit"

  require "propr/util"
  require "propr/types"

  class GuardFailure < StandardError
  end

  class NoMoreTries < StandardError
    # @return [Integer]
    attr_reader :limit

    # @return [Integer]
    attr_reader :tries

    def initialize(limit, tries)
      @limit, @tries = limit, tries
    end

    # @return [String]
    def to_s
      "Exceeded limit #{limit}: #{tries} failed guards"
    end
  end

  def self.RSpec(rand)
    Module.new.tap do |m|
      m.send(:define_method, :property) { raise }
      m.send(:define_singleton_method, :rand) { rand }
      m.send(:define_singleton_method, :included) do |scope|
        scope.send(:define_singleton_method, :property) do |name, options = {}, &body|
          RSpecProperty.new(self, name, options, rand, body)
        end
      end
    end
  end
end
