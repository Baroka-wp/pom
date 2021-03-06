class UsersController < ApplicationController
  before_action :set_user, only:[:show, :edit, :destroy, :update]
  skip_before_action :login_required, only: [:new, :create]

  def index
  end
  def show
    if params[:urgence]
      @tasks = current_user.tasks.order(deadline: :DESC).page params[:page]
    elsif params[:low]
      @tasks = current_user.tasks.where(priority: :low).page params[:page]
    elsif params[:medium]
      @tasks = current_user.tasks.where(priority: :medium).page params[:page]
    elsif params[:high]
      @tasks = current_user.tasks.where(priority: :high).page params[:page]
    elsif params[:task_name] && params[:statut]
      if params[:task_name]==''
        @tasks = current_user.tasks.where(statut:params[:statut]).page params[:page]
      else
        #@tasks = Task.all.where(task_name: params[:task_name])
        @tasks = current_user.tasks.where("task_name LIKE ?
                                or description LIKE ?",
                                "%#{params[:task_name]}%",
                                "%#{params[:task_name]}%").page params[:page]

      end
    else
      @tasks = current_user.tasks.order(created_at: :DESC).page params[:page]
    end
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = t('controller.user.create_success')

      redirect_to new_session_path
    else
      render :new
    end
  end
  def edit
  end
  def update
    if @user.update(user_params)
      flash[:success] = t('controller.user.update_success')
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end
  def destroy
    @user.destroy
    flash[:danger] = t('controller.user.destroy_success')
    redirect_to tasks_path
  end

  ######## MENTOR CONTROLLER #######
  def mentor
    @tasks = Task.all.page params[:page]
  end

  private
  def user_params
    params.require(:user).permit(:name,
                                 :email,
                                 :telephone,
                                 :bio,
                                 :password,
                                 :password_confirmation
                               )
  end
  def set_user
    @user = User.find(params[:id])
  end
end
