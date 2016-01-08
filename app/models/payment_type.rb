class PaymentType < ActiveRecord::Base
has_many :orders

all_p_t = PaymentType.all.each {|c| c.payment_type }

end
