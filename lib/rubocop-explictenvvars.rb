# frozen_string_literal: true

require 'rubocop'

require_relative 'rubocop/explictenvvars'
require_relative 'rubocop/explictenvvars/version'
require_relative 'rubocop/explictenvvars/inject'

RuboCop::Explictenvvars::Inject.defaults!

require_relative 'rubocop/cop/explictenvvars_cops'
