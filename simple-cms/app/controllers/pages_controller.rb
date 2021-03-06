class PagesController < ApplicationController
  before_action :confirm_logged_in, :get_subject

  # new.html
  def new
    @page = Page.new
    @page.subject = @subject
  end

  def create
    @page = Page.new(page_params)
    @page.subject = @subject
    if @page.save
      flash[:success] = "Page #{@page.name} was created successfully"
      redirect_to subject_path(@subject)
    else
      render :new 
    end
  end 

  # edit.html
  def edit
    @page = Page.find(params[:id])
  end

  def update 
    @page = Page.find(params[:id])
    if @page.update(page_params)
      flash[:success] = "Page #{@page.name} was updated successfully"
      redirect_to subject_path(@subject)
    else 
      render :edit
    end 
  end

  def destroy
    @page = Page.find(params[:id])    
    @page.destroy
    flash[:success] = "Page #{@page.name} was deleted successfully"
    redirect_to subject_path(@subject)
  end

private

  def get_subject
    @subject = Subject.find(params[:subject_id])
  end

  def page_params
    params.require(:page).permit(:name, :position, :permalink, :visible, :content)
  end 
end
