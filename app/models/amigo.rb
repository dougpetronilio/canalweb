class Amigo < ActiveRecord::Base
  belongs_to :user_profile
  belongs_to :amigo, :class_name => "UserProfile", :foreign_key => "amigo_id"

  validates_presence_of :user_profile_id, :amigo_id

  def self.amizade?(usuario, amigo)
    not find_by_user_profile_id_and_amigo_id(usuario, amigo).nil?
  end

  def self.requisicao(usuario, amigo)
    unless usuario == amigo or Amigo.amizade?(usuario, amigo)
      transaction do
        create(:user_profile => usuario, :amigo => amigo, :status => "pendente")
        create(:user_profile => amigo, :amigo => usuario, :status => "pedido")
      end
    end
  end

  def self.rejeita(usuario, amigo)
    transaction do
      destroy(find_by_user_profile_id_and_amigo_id(usuario, amigo))
      destroy(find_by_user_profile_id_and_amigo_id(amigo, usuario))
    end
  end

  def self.aceita(usuario, amigo)
    transaction do
      request = find_by_user_profile_id_and_amigo_id(usuario, amigo)
      request.status = "aceito"
      request.save!
      request_amigo = find_by_user_profile_id_and_amigo_id(amigo, usuario)
      request_amigo.status = "aceito"
      request_amigo.save!
    end
  end

end
