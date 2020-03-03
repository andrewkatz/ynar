# frozen_string_literal: true

module Ynar
  class Transaction
    attr_accessor :date, :amount, :source, :raw

    class << self
      def from_csv(row)
        transaction = new
        transaction.raw = row
        # TODO: Make CSV fields configurable
        transaction.date = Date.strptime(row['Posting Date'], '%m/%d/%Y')
        transaction.amount = Money.from_amount(row['Amount'].to_f)
        transaction.source = :csv
        transaction
      end

      def from_ynab(ynab_transaction)
        transaction = new
        transaction.raw = ynab_transaction
        date_string = /:(\d\d\d\d-\d\d-\d\d):/.match(ynab_transaction['import_id'])[1]
        transaction.date = Date.strptime(date_string, '%Y-%m-%d')
        transaction.amount = Money.new(ynab_transaction['amount'] / 10)
        transaction.source = :ynab
        transaction
      end
    end

    def match_key
      [date.strftime('%Y/%m/%d'), amount.cents].join('/')
    end
  end
end
