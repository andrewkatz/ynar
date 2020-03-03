# frozen_string_literal: true

RSpec.describe Ynar::Transaction do
  describe '.from_csv' do
    let(:row) { CSV.read('spec/support/fixtures/transactions.csv', headers: true).first }
    subject { described_class.from_csv(row) }

    it { is_expected.to be_a(described_class) }
    its(:date) { is_expected.to eq(Date.new(2020, 3, 2)) }
    its(:amount) { is_expected.to eq(Money.new(-1000)) }
    its(:source) { is_expected.to eq(:csv) }
    its(:raw) { is_expected.to eq(row) }
  end

  describe '.from_ynab' do
    let(:transaction) do
      {
        'id' => '7bc6e414-c441-40ad-b309-9cc4456ad6a2',
        'date' => '2019-02-24',
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
      }
    end
    subject { described_class.from_ynab(transaction) }

    it { is_expected.to be_a(described_class) }
    its(:date) { is_expected.to eq(Date.new(2019, 2, 25)) }
    its(:amount) { is_expected.to eq(Money.new(-8019)) }
    its(:source) { is_expected.to eq(:ynab) }
    its(:raw) { is_expected.to eq(transaction) }
  end

  describe '#match_key' do
    let(:transaction) do
      transaction = described_class.new
      transaction.date = Date.new(2020, 3, 2)
      transaction.amount = Money.new(-350)
      transaction
    end
    subject { transaction.match_key }

    it { is_expected.to eq('2020/03/02/-350') }
  end
end
