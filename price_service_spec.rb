require 'rspec'
require_relative 'price_service'

RSpec.describe PriceService do
  subject(:call) { PriceService.new(product: product, user: user).call }

  let(:product) { { id: 1, base_price: 100, tax_percentage: 0 } }
  let(:user) { { id: 1, birthday_month: 5 } }
  describe '#call' do
    it 'calculates the total price' do
      service = PriceService.new(product: product, user: user)
      expect(call).to eq(100.0)
    end

    context 'when product has tax' do
      let(:product) { { id: 1, base_price: 100, tax_percentage: 10 } }

      it 'ignores the taxes' do
        expect(call).to eq(110.0)
      end
    end

    context 'when product is in food or beverages category' do
      subject(:call) { PriceService.new(product:, user:).call }
      let(:product) { { base_price: 100, tax_percentage: 10, category: 'food' } }
      let(:user) { { id: 1, birthday_month: 2 } }

      it 'applies 5% category discount' do
        expect(call).to eq(104.5)
      end
    end
  end
end
