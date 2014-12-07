class Blog < ActiveRecord::Base
    attr_accessible :user_id, :post_id
    belongs_to :user
end
