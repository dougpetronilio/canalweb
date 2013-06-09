module AmigosHelper
  def status_amizade(usuario, amigo)
    relacionamento = Amigo.find_by_user_profile_id_and_amigo_id(usuario, amigo)
    return "#{amigo.nome} nao e seu amigo." if relacionamento.nil?
    case relacionamento.status
    when 'requisicao'
      "#{amigo.nome} gostaria de ser seu amigo."
    when 'pendente'
      "Voce pediu para ser amigo do #{amigo.nome}"
    when 'aceito'
      "#{amigo.nome} e seu amigo"
    end
  end
end
