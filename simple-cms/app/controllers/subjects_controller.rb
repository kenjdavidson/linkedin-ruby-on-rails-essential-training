class SubjectsController < ApplicationController
  before_action :confirm_logged_in

  # index.html
  def index
    @subjects = Subject.order('position ASC')
  end

  # show.html
  def show
    @subject = Subject.find(params[:id])
  end

  # new.html
  def new
    @subject = Subject.new
  end

  def create    
    @subject = Subject.new(subject_params)
    if @subject.save
      flash[:success] = "Subject #{@subject.name} was created successfully"
      redirect_to subjects_path
    else 
      render :new
    end 
  end 

  # edit.html
  def edit
    @subject = Subject.find(params[:id])
  end

  def update 
    @subject = Subject.find(params[:id])
    if @subject.update(subject_params)
      flash[:success] = "Subject #{@subject.name} was updated successfully"
      redirect_to subjects_path
    else 
      render :edit
    end 
  end

  def destroy
    @subject = Subject.find(params[:id])
    if @subject.destroy 
      flash[:success] = "Subject #{@subject.name} was deleted successfully"
      redirect_to subjects_path 
    else 
      flash[:error] = "Could not delete subject #{@subject.name}"
      redirect_to subjects_path 
    end 
  end

private 

  def subject_params
    params.require(:subject).permit(:name, :position, :visible)
  end 

end
