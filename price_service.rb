class PriceService
  attr_reader \
    :product,
    :user

  def initialize(product:, user:)
    @product = product
    @user = user
  end

  def call
    final_price
  end

  private

  def base_price
    product[:base_price]
  end

  def final_price
    base_price + tax_amount
  end

  def tax_amount
    base_price * (tax_percentage / 100.0)
  end

  def tax_percentage
    product.fetch(:tax_percentage, 0)
  end
end
