class LoginController < ApplicationController
  

  def login
    @usuario = Usuario.new
  end

  def check
    p = login_params
    existe = Usuario.authenticate_safely(p[:usuario],p[:password])
   

    if existe
      redirect_to "/lista", :usuario => p[:usuario]
    elsif !existe
      redirect_to "/"
    end

    
  end

  def signup
    @usuario = Usuario.new
  end

  def dosignup

    u = Usuario.new(usuario_params)
    
    if (u.valid? and u.new_record?)
      u.save
      redirect_to "/"
    else
      redirect_to "/signup"
    end
  end

  def usuario_params
    params.require(:usuario).permit(:usuario, :password, :alias, :email)
  end

  def login_params
    params.require(:usuario).permit(:usuario, :password)
  end

end
