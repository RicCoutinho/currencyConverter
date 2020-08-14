require 'rails_helper'
require 'json'
require './app/services/exchange_service'

describe ExchangeService do
  let(:source_currency) { 'USD' }
  let(:target_currecy) { 'BRL' }
  let(:exchange_value) { 3.45 }
  let(:api_return) do
    {
      currency: [
        currency: "#{source_currency}/#{target_currecy}",
        value: exchange_value,
        date: Time.now,
        type: 'Original'
      ]
    }
  end

  before do
    allow(RestClient).to receive(:get) { OpenStruct.new(body: api_return.to_json) }
  end

  describe '.call' do
    context 'when amount is given'
    it 'returns amount * exchange_value' do
      amount = rand(0..9999)
      service_exchange = ExchangeService.new('USD', 'BRL', amount).call
      expect_exchange = amount * exchange_value

      expect(service_exchange).to eq(expect_exchange)
    end
  end
end
