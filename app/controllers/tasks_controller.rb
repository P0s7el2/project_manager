# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tasks, only: %i[show edit update destroy]
  before_action :set_project, only: %i[create]
  after_action :attach_task, only: %i[create]

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def show; end

  def create
    @task = Task.new(title: params[:task][:title], description: params[:task][:description], user_id: params[:task][:user_id])

    if @task.save
      redirect_to @task
    else
      render :new
    end
  end

  def edit; end

  def update
    if @task.update(title: params[:task][:title], description: params[:task][:description], user_id: params[:task][:user_id])
      redirect_to @task
    else
      render :new
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path
  end

private

  def set_project
    if params[:task][:project_id].nil?
      @project = Project.find(params[:task][:project_id])
    end
  end

  def attach_task
    if params[:task][:project_id].nil?
      @project.tasks << @task
    end
  end

  def set_tasks
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :project_id, :user_id)
  end

end