require 'date'

class PriceService
  attr_reader \
    :product,
    :user

  CATEGORY_DISCOUNT_RATE = 0.05
  BIRTHDAY_DISCOUNT_RATE = 0.10

  def initialize(product:, user:)
    @product = product
    @user = user
  end

  def call
    apply_discounts(calculate_final_price)
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
    price -= price * category_discount if eligible_for_category_discount?
    price -= price * birthday_discount if eligible_for_birthday_discount?
    price
  end

  def eligible_for_category_discount?
    %w[food beverages].include?(product[:category])
  end

  def eligible_for_birthday_discount?
    Date.today.month == user[:birthday_month]
  end

  def category_discount
    CATEGORY_DISCOUNT_RATE
  end

  def birthday_discount
    BIRTHDAY_DISCOUNT_RATE
  end
end
