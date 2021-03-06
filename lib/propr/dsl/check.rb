module Propr
  module Dsl

    class Check

      # Generates a monadic action, to be run with Random.eval
      def self.wrap(block, m = Propr::Random)
        new(block, m).instance_exec(&block)
      end

      def initialize(block, m)
        @context, @m =
          Kernel.eval("self", block.binding), m
      end

      def bind(f, &g)
        @m.bind(f, &g)
      end

      def unit(value)
        @m.unit(value)
      end

      def guard(*conditions)
        @m.guard(*conditions)
      end

      def join(value)
        @m.join(value)
      end

      def sequence(actions)
        @m.sequence(actions)
      end

      def scale(*args)
        @m.scale(*args)
      end

    private

      def method_missing(name, *args, &block)
        @context.__send__(name, *args, &block)
      end

    end

  end
end
