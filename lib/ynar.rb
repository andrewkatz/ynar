# frozen_string_literal: true

require 'csv'
require 'money'

require 'ynar/version'
require 'ynar/config'
require 'ynar/api'
require 'ynar/transaction'

Money.default_currency = Money::Currency.new('USD')
Money.rounding_mode = BigDecimal::ROUND_HALF_UP

module Ynar
  class Error < StandardError; end
end
