class TasksController < ApplicationController
  def index
    if params[:sort_expired]
      @tasks = Task.all.order(date: "ASC").page(params[:page])
    elsif params[:sort]
      @tasks = Task.all.order(id: "DESC").page(params[:page])
    elsif params[:sort_priority]
      @tasks = Task.all.order(id: "DESC").page(params[:page])
    else
    @tasks = Task.all.page(params[:page])
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice] = 'タスクを作成しました。'
      redirect_to tasks_path
    else
      render "new"
      # flash[:alret] = 'タスクの作成に失敗しました。'
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path, notice:'タスクを更新しました。'
    else
      redirect_to edit_task_path
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def destroy
    @task = Task.find(params[:id])
    if @task.destroy
      redirect_to tasks_path, notice:'削除しました'
    else
      redirect_to tasks_path, notice:'削除できませんでした'
    end
  end

  def search
    @tasks = Task.key_search(params[:keyword])
    if params[:search].present?
      @tasks = @tasks.select_search(params[:search])
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :detail, :date, :status, :priority)
  end
end
