require 'rspec'
require_relative 'price_service'

RSpec.describe PriceService do
  subject(:call_service) { described_class.new(product:, user:).call }
  let(:user) { { id: 1, birthday_month: user_birthday_month } }
  let(:user_birthday_month) { 5 }

  describe '#call' do
    context 'when product has a tax percentage' do
      let(:product) { { id: 1, base_price: 100, tax_percentage: 10 } }

      it 'calculates the total price with tax' do
        expect(call_service).to eq(110.0)
      end
    end

    context 'when product is in food or beverages category' do
      let(:product) { { base_price: 100, tax_percentage: 10, category: } }
      let(:category) { 'food' }

      it 'applies 5% category discount' do
        expect(call_service).to eq(104.5)
      end

      context 'when category is beverages' do
        let(:category) { 'beverages' }

        it 'applies 5% category discount for beverages' do
          expect(call_service).to eq(104.5)
        end
      end
    end

    context 'when it is the user\'s birthday month' do
      let(:product) { { base_price: 100, tax_percentage: 10 } }
      let(:user_birthday_month) { Date.today.month }

      it 'applies 10% birthday discount' do
        expect(call_service).to eq(99.0)
      end
    end

    context 'when both category and birthday discounts apply' do
      let(:product) { { base_price: 100, tax_percentage: 10, category: 'beverages' } }
      let(:user_birthday_month) { Date.today.month }

      it 'applies both discounts' do
        expect(call_service).to eq(94.05)
      end
    end

    context 'when product has no tax percentage' do
      let(:product) { { base_price: 100, category: 'beverages' } }

      it 'calculates the final price without tax and applies the category discount' do
        expect(call_service).to eq(95.0)
      end
    end

    context 'when no discounts apply' do
      let(:product) { { base_price: 100 } }

      it 'calculates the final price without tax and without discounts' do
        expect(call_service).to eq(100.0)
      end
    end
  end
end
