require 'bcrypt'

class Usuario < ActiveRecord::Base

    validates :usuario  , null: false, uniqueness: true 
    validates :password , null: false 
    validates :alias    , null: false, uniqueness: true 
    validates :email    , null: false, uniqueness: true

    has_secure_password

    #def password
    #  @password ||= BCrypt::Password.new(password_hash)
    #end

    # def password=(new_password)
      # puts "ME llamaaaaaaron"
      # @password = BCrypt::Password.create(new_password)
      # puts "Este es el password que paso #{@password}"
      # self.password = @password
    # end

    def passwordMatches?(pass)
      @user = User.new(params[:user])
      @user.password_digest == BCrypt::Password.create(pass)
    end

    def authenticate_safely(usuario, password)
        where("usuario = ? AND password = ?", usuario, password).first
    end 

    def create
      @user = User.new(params[:user])
      @user.password = BCrypt::Password.create(params[:password])
      @user.save!
    end

    def forgot_password
      @user = User.find_by_email(params[:email])
      random_password = Array.new(10).map { (65 + rand(58)).chr }.join
      @user.password = random_password
      @user.save!
      Mailer.create_and_deliver_password_change(@user, random_password)
    end

    
end
