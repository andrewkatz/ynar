# frozen_string_literal: true

require 'sinatra/base'

class FakeYnab < Sinatra::Base
  get '/v1/budgets' do
    json_response 200, 'budgets.json'
  end

  get '/v1/budgets/:budget_id/accounts' do
    json_response 200, 'accounts.json'
  end

  get '/v1/budgets/:budget_id/accounts/:account_id/transactions' do
    json_response 200, 'transactions.json'
  end

  private

  def json_response(response_code, file_name)
    content_type :json
    status response_code
    File.open(File.dirname(__FILE__) + '/fixtures/' + file_name, 'rb').read
  end
end
