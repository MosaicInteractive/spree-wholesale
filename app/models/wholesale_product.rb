class WholesaleProduct < ActiveRecord::Base
  belongs_to :user
  belongs_to :variant
  
  def self.get(user_id, variant_id)
	  WholesaleProduct.find_by_user_id_and_variant_id(user_id, variant_id)
	end
	
end
