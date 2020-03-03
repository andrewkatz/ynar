# frozen_string_literal: true

RSpec.describe Ynar::Api do
  let(:config) { Ynar::Config.new(File.expand_path('../support/config.yaml', __dir__)) }

  describe '.new' do
    subject { described_class.new(config) }

    its(:token) { should eq 'some_token' }
  end

  describe '#budgets' do
    subject { described_class.new(config).budgets }

    its(:size) { should eq 1 }
    its([0]) do
      should eq({
                  'id' => '0d33673e-985e-428e-9efa-00a3abff7f34',
                  'name' => 'My Budget',
                  'last_modified_on' => '2020-03-01T17:06:19+00:00',
                  'first_month' => '2019-02-01',
                  'last_month' => '2020-03-01',
                  'date_format' => {
                    'format' => 'MM/DD/YYYY'
                  },
                  'currency_format' => {
                    'iso_code' => 'USD',
                    'example_format' => '123,456.78',
                    'decimal_digits' => 2,
                    'decimal_separator' => '.',
                    'symbol_first' => true,
                    'group_separator' => ',',
                    'currency_symbol' => '$',
                    'display_symbol' => true
                  }
                })
    end
  end

  describe '#accounts' do
    subject { described_class.new(config).accounts('some_budget_id') }

    its(:size) { should eq 6 }
    its([0]) do
      should eq({
                  'id' => 'c33faf1c-ed49-4f06-9d2a-904065ae0261',
                  'name' => 'Chase Checking',
                  'type' => 'checking',
                  'on_budget' => true,
                  'closed' => false,
                  'note' => nil,
                  'balance' => 75_870_190,
                  'cleared_balance' => 75_870_190,
                  'uncleared_balance' => 0,
                  'transfer_payee_id' => '76dc8d6f-3c40-4379-bc2f-855f941594d5',
                  'deleted' => false
                })
    end
  end

  describe '#transactions' do
    subject do
      described_class.new(config).transactions('budget_id', 'account_id', Date.new(2020, 1, 1))
    end

    its(:size) { should eq 1 }
    its([0]) do
      should eq({
                  'id' => '7bc6e414-c441-40ad-b309-9cc4456ad6a2',
                  'date' => '2019-02-25',
                  'amount' => -80_190,
                  'memo' => '',
                  'cleared' => 'cleared',
                  'approved' => true,
                  'flag_color' => nil,
                  'account_id' => 'c33faf1c-ed49-4f06-9d2a-904065ae0261',
                  'account_name' => 'Chase Checking',
                  'payee_id' => 'ee940059-3681-417f-bbbb-cc2f6e847a5c',
                  'payee_name' => 'Pavilions Store Thousand Oaks CA',
                  'category_id' => 'c234e866-7034-403e-8678-4dea922a51fa',
                  'category_name' => 'Groceries',
                  'transfer_account_id' => nil,
                  'transfer_transaction_id' => nil,
                  'matched_transaction_id' => nil,
                  'import_id' => 'YNAB:-80190:2019-02-25:1',
                  'deleted' => false,
                  'subtransactions' => []
                })
    end
  end
end
