# frozen_string_literal: true

module RuboCop
  module Cop
    module Security
      # TODO: Write cop description and example of bad / good code. For every
      # `SupportedStyle` and unique configuration, there needs to be examples.
      # Examples must have valid Ruby syntax. Do not use upticks.
      #
      # @safety
      #   Delete this section if the cop is not unsafe (`Safe: false` or
      #   `SafeAutoCorrect: false`), or use it to explain how the cop is
      #   unsafe.
      #
      # @example EnforcedStyle: bar (default)
      #   # Description of the `bar` style.
      #
      #   # bad
      #   bad_bar_method
      #
      #   # bad
      #   bad_bar_method(args)
      #
      #   # good
      #   good_bar_method
      #
      #   # good
      #   good_bar_method(args)
      #
      # @example EnforcedStyle: foo
      #   # Description of the `foo` style.
      #
      #   # bad
      #   bad_foo_method
      #
      #   # bad
      #   bad_foo_method(args)
      #
      #   # good
      #   good_foo_method
      #
      #   # good
      #   good_foo_method(args)
      #
      class ExplicitEnvVars < Base
        # TODO: Implement the cop in here.
        #
        # In many cases, you can use a node matcher for matching node pattern.
        # See https://github.com/rubocop/rubocop-ast/blob/master/lib/rubocop/ast/node_pattern.rb
        #
        # For example
        MSG = "Set ENV variables explicity."

        def_node_matcher :fetching_with_string_default?, <<~PATTERN
          (send (const $... :ENV) :fetch (str $...) (str $...))
        PATTERN

        def_node_matcher :fetching_with_block_default?, <<~PATTERN
          (block (send (const $... :ENV) :fetch (str $...)) (args) (str $...))
        PATTERN

        def_node_matcher :brackets_with_or?, <<~PATTERN
          (or (send (const $... :ENV) :[] (str $...)) (str $...))
        PATTERN

        def on_send(node)
          # require 'pry'; binding.pry
          return unless fetching_with_string_default?(node) || brackets_with_or?(node.parent) || fetching_with_block_default?(node.parent)

          add_offense(node)
        end
      end
    end
  end
end
