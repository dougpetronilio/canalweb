class User < ActiveRecord::Base
  has_one :user_profile

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  after_create :cria_profile

  def cria_profile
    puts "#"*50
    puts "entrou em cria_profile"
    puts "#"*50
    if self.user_profile.nil?
      puts "#"*50
      puts "e nil criando profile"
      puts "#"*50
      @user_profile = self.create_user_profile()
    end
  end


end
