class SubjectsController < ApplicationController
  # index.html
  def index
    @subjects = Subject.all
  end

  # show.html
  def show
    @subject = Subject.find(params[:id])
  end

  # new.html
  def new
  end

  def create
  end 

  # edit.html
  def edit
  end

  def update 
  end

  # delete.html
  def delete
  end

  def destroy
  end
end
