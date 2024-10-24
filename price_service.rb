require 'date'

class PriceService
  attr_reader \
    :product,
    :user

  CATEGORY_DISCOUNT = 0.05
  BIRTHDAY_DISCOUNT = 0.10

  def initialize(product:, user:)
    @product = product
    @user = user
  end

  def call
    final_price = calculate_final_price
    apply_discounts(final_price)
  end

  private

  def base_price
    product[:base_price]
  end

  def calculate_final_price
    base_price + tax_amount
  end

  def tax_amount
    base_price * (tax_percentage / 100.0)
  end

  def tax_percentage
    product.fetch(:tax_percentage, 0)
  end

  def apply_discounts(price)
    price -= price * CATEGORY_DISCOUNT if eligible_for_category_discount?
    price -= price * BIRTHDAY_DISCOUNT if birthday_month?
    price
  end

  def eligible_for_category_discount?
    %w[food beverages].include?(product[:category])
  end

  def birthday_month?
    Date.today.month == user[:birthday_month]
  end
end
