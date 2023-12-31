class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
#  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
#    @tasks = Task.all #自分のタスクだけ表示
    @tasks = current_user.tasks.order(id: :desc)
  end

  def show
   #  @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
#    @task = Task.new(task_params)
    if @task.save
      flash[:success] = 'Task が正常に登録されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task が登録されませんでした'
      render :new
    end
  end

  def edit
  #   @task = Task.find(params[:id])
  end

  def update
  #   @task = Task.find(params[:id])

    if @task.update(task_params)
      flash[:success] = 'task は正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'task は更新されませんでした'
      render :edit
    end
  end

  def destroy
  #   @task = Task.find(params[:id])
    @task.destroy
    flash[:success] = 'task は正常に削除されました'
    redirect_to tasks_url
  end
  
  private
  
#  def set_task
#    @task = Task.find(params[:id])
#  end

  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
  
end
