class SessionsController < ApplicationController
  def new
  end

  def create
    # cherche s'il existe un utilisateur en base avec l’e-mail
    user = User.find_by(email: params[:email])

    # on vérifie si l'utilisateur existe bien ET si on arrive à l'authentifier (méthode bcrypt) avec le mot de passe 
    if user && user.authenticate(params[:password])
      log_in(user)
      remember(user)
      flash.now[:success] = 'Bienvenue'
      redirect_to '/'

    else
      flash.now[:danger] = 'Connexion impossible, vérifiez votre mot de passe'
      render 'new'
    end
  end

  def destroy
    log_out(current_user)
    flash.now[:success] = 'Vous êtes maintenant déconnecté'
    redirect_to '/'
  end
end
