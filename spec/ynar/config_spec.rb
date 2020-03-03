# frozen_string_literal: true

RSpec.describe Ynar::Config do
  describe '.new' do
    subject { described_class.new('spec/support/config.yaml') }

    its(:personal_access_token) { is_expected.to eq('some_token') }
  end
end
