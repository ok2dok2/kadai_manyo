class TasksController < ApplicationController
  def index
    @task = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path
    end
  end



  private

  def task_params
    params.require(:task).permit(:name, :detail)
  end
end
