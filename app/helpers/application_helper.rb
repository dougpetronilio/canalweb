module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def swf_object(swf, id, width, height, flash_version, background_color, params = {}, vars = {}, create_div = false)

    create_div ? output = "<div id='#{id}'> este site requer <a href='http://www.abode.com/shockwave/download/download.cdi?P1_Prod_Version=ShockwabeFlash&promoid=BIOW' target='_blank'>Flash Player</a></div><script type='text/javascript'>" : output = "<script type='text/javascript'>"

    output << "var so = new SWFObject('#{swf}', '#{id}', '#{width}', '#{height}', '#{flash_version}', '#{background_color}');"

    params.each {|key, value| output << "so.addParam('#{key}', '#{value}');"}
    vars.each {|key, value| output << "so.addVariable('#{key}', '#{value}');"}

    output << "so.write('#{id}');"
    output << "</script>"

  end

  def meus_amigos
    amigos = Amigo.all(:conditions => ["user_profile_id = ?", current_user.user_profile.id])
    return amigos
  end
end
