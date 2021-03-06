class SessionsController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]

  def new
  end
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      if current_user.mentor?
        redirect_to mentor_path(user.id)
      else
        redirect_to user_path(user.id)
      end
    else
      flash[:danger] = 'Connection échouée !'
      render :new
    end
  end
  def destroy
    session.delete(:user_id)
    flash[:notice] = "Déconnecté ! A bientôt"
    redirect_to new_session_path
  end
end
