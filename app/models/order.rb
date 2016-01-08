#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
class Order < ActiveRecord::Base
PAYMENT_TYPES = []
#PAYMENT_TYPES = PaymentType.each {|c| c.payment_type }
PaymentType.where("locale = '#{I18n.locale.to_s}'").find_each do |ptype|
  PAYMENT_TYPES << ptype.payment_type
end

  has_many :line_items, dependent: :destroy
  # ...
  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: PAYMENT_TYPES

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end	
  end
end
