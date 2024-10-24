require 'rspec'
require_relative 'price_service'

RSpec.describe PriceService do
  subject(:call) { PriceService.new(product: product, user: user).call }

  let(:product) { { id: 1, base_price: 100, tax_percentage: 0 } }
  let(:user) { { id: 1, birthday_month: 5 } }

  describe '#call' do
    it 'calculates the total price' do
      PriceService.new(product: product, user: user)
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

    context 'when it is the user\'s birthday month' do
      subject(:call) { PriceService.new(product:, user:).call }
      let(:product) { { base_price: 100, tax_percentage: 10 } }
      let(:user) { { id: 1, birthday_month: Date.today.month } }

      it 'applies 10% birthday discount' do
        expect(call).to eq(99.0)
      end
    end

    context 'when both category and birthday discounts apply' do
      subject(:call) { PriceService.new(product:, user:).call }
      let(:product) { { base_price: 100, tax_percentage: 10, category: 'beverages' } }
      let(:user) { { id: 1, birthday_month: Date.today.month } }

      it 'applies both discounts' do
        expect(call).to eq(94.05)
      end
    end

    context 'when product has no tax percentage' do
      subject(:call) { PriceService.new(product:, user:).call }
      let(:product) { { base_price: 100, category: 'beverages' } }
      let(:user) { { id: 1, birthday_month: 6 } }

      it 'calculates the final price without tax' do
        expect(call).to eq(95.0)
      end
    end
  end
end
