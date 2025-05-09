class SessionsController < ApplicationController
  skip_before_action :require_user, only: [ :new, :create ]

  def new
  end
  
  def create
    student = Student.find_by(email: params[:session][:email].downcase)
    if student && student.authenticate(params[:session][:password])
      session[:student_id] = student.id
      flash[:notice] = "Logged in successfully"
      redirect_to student
    else
      flash.now[:alert] = "Failed to log in. Email or password were incorrect"
      render "new"
    end
  end

  def destroy
    session[:student_id] = nil
    flash[:notice] = "Logged out successfully"
    redirect_to root_path
  end
end