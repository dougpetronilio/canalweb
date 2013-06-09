class UserProfile < ActiveRecord::Base
  belongs_to :user
  has_many :canals
  has_many :favoritos
  has_attached_file :foto, :styles => { :small => "100x100", :icone => "64x64" },
                           :url => "/assets/user_profiles/:id/:style/:basename.:extension",
                           :path => ":rails_root/public/assets/user_profiles/:id/:style/:basename.:extension"

  validates_attachment_size :foto, :less_then => 5.megabytes
  validates_attachment_content_type :foto, :content_type => ['image/jpeg', 'image/png']

  def idade
    return if nascimento.nil?
    hoje = Date.today
    if hoje.month >= nascimento.month and hoje.day >= nascimento.day
      hoje.year - nascimento.year
    else
      hoje.year - nascimento.year - 1
    end
  end

  def nome_completo

    if nome != nil and sobrenome != nil
      nome+" "+sobrenome
    elsif nome != nil
      nome
    else
      ""
    end

  end
end
