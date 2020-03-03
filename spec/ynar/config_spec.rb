# frozen_string_literal: true

RSpec.describe Ynar::Config do
  describe '.new' do
    subject { described_class.new(File.expand_path('../support/config.yaml', __dir__)) }

    its(:personal_access_token) { is_expected.to eq('some_token') }
  end
end
