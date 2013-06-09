class Canal < ActiveRecord::Base
  belongs_to :user_profile
  has_many :favoritos
end
