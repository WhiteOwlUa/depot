class User < ActiveRecord::Base
  after_destroy :ensure_an_admin_remains  
  has_secure_password
  def ensure_an_admin_remains
  #	if User.count.zero?
  #		raise "Последний пользователь не может быть удален"
  #	end
  end
end
