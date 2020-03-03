# frozen_string_literal: true

require 'faraday'
require 'json'

module Ynar
  class Api
    attr_reader :token

    def initialize(config)
      @token = config.personal_access_token
      @connection = Faraday.new(
        url: 'https://api.youneedabudget.com',
        headers: {
          'Authorization': "Bearer #{token}",
          'Content-Type': 'application/json'
        }
      )
    end

    def budgets
      fetch('v1/budgets', 'budgets')
    end

    def accounts(budget_id)
      fetch("v1/budgets/#{budget_id}/accounts", 'accounts')
    end

    def transactions(budget_id, account_id, since_date)
      date_string = since_date.strftime('%Y-%m-%d')
      fetch(
        "v1/budgets/#{budget_id}/accounts/#{account_id}/transactions?since_date=#{date_string}",
        'transactions'
      )
    end

    private

    def fetch(url, body_key)
      response = @connection.get(url)
      JSON.parse(response.body)['data'][body_key]
    end
  end
end
