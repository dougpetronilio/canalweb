class Favorito < ActiveRecord::Base
  belongs_to :user_profile
  belongs_to :canal
end
