class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy, :tasks, :task_add, :task_remove]

  # GET /projects
  def index
    @projects = Project.all
  end

  # GET /projects/1
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
    associated_ids = TasksProject.where(project_id: @project.id).select(:task_id)
    @projects = Project.where.not(id: associated_ids)
  end

  # POST /projects
  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to @project, notice: 'Project was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /projects/1
  def update
    if @project.update(project_params)
      redirect_to @project, notice: 'Project was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /projects/1
  def destroy
    @project.destroy
    redirect_to projects_url, notice: 'Project was successfully destroyed.'
  end

  # GET /projects/1/tasks
  def tasks
    @tasks = @project.tasks
  end

  # POST /students/1/course_add?course_id=2
  # (note no real query string, just
  # convenient notation for parameters)
  def task_add
    @task = Task.find(params[:task])
    if @project.attached?(@task)
      flash[:error] = 'Task was already added?'
    else
      @project.tasks << @task
      flash[:notice] = 'Task added?'
    end
    redirect_to action: "tasks", id: @project
  end

  def task_remove
    task_ids = params[:tasks]
    if task_ids.any?
      task_ids.each do |task_id|
        task = Task.find(task_id)
        if @project.attached?(task)
          logger.info "Removing project from task #{task.id}"
          @project.tasks.delete(task)
          flash[:notice] = 'Task was successfully deleted'
        end
      end
    end
    redirect_to action: "tasks", id: @project
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def project_params
    params.require(:project).permit(:name, :summery, task_ids: [])
  end
end
