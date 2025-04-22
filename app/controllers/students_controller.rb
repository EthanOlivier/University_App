class StudentsController < ApplicationController
  before_action :find_student, only: [ :show, :edit, :update ]
  before_action :require_same_user, only: [ :edit, :update ]
  skip_before_action :require_user, only: [ :new, :create, :show ]

  def index
    @students = Student.all
  end

  def show
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      session[:student_id] = @student.id
      flash[:notice] = "Signed Up Successfully"
      redirect_to @student
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @student.update(student_params)
      flash[:notice] = "Updated Student Profile Successfully"
      redirect_to @student
    else
      render "edit"
    end
  end

  private

  def student_params
    params.require(:student).permit(:name, :email, :password, :password_confirmation)
  end

  def find_student
    @student = Student.find(params[:id])
  end

  def require_same_user
    if current_user != @student
      flash[:alert] = "You may only edit your own profile"
      redirect_to @student
    end
  end

end