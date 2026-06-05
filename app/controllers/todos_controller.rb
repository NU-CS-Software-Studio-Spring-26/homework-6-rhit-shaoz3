class TodosController < ApplicationController
  before_action :set_todo, only: %i[ show edit update destroy ]

  # GET /todos or /todos.json
  def index
    @todos = Todo.all
    if params[:category].present? && Todo::CATEGORIES.include?(params[:category])
      @todos = @todos.where(category: params[:category])
    end
    @selected_category = params[:category]
  end

  # GET /todos/1 or /todos/1.json
  def show
  end

  # GET /todos/new
  def new
    @todo = Todo.new
  end

  # GET /todos/1/edit
  def edit
  end

  # POST /todos or /todos.json
  def create
    @todo = Todo.new(todo_params)

    respond_to do |format|
      if @todo.save
        format.html { redirect_to @todo, notice: "Todo was successfully created." }
        format.json { render :show, status: :created, location: @todo }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @todo.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /todos/1 or /todos/1.json
  def update
    if category_missing_from_request?
      @todo.errors.add(:category, "must be selected")
      return render_update_errors
    end

    if @todo.update(todo_params)
      respond_to do |format|
        format.html { redirect_to @todo, notice: "Todo was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @todo }
      end
    else
      render_update_errors
    end
  end

  # DELETE /todos/1 or /todos/1.json
  def destroy
    @todo.destroy!

    respond_to do |format|
      format.html { redirect_to todos_path, notice: "Todo was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  def hello
    respond_to do |format|
      format.html { render :hello }
      format.json { render json: "hello world!" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo
      @todo = Todo.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def todo_params
      params.require(:todo).permit(:description, :category)
    end

    def category_missing_from_request?
      todo_params = params[:todo]
      todo_params.nil? || !todo_params.key?(:category)
    end

    def render_update_errors
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @todo.errors, status: :unprocessable_content }
      end
    end
end
