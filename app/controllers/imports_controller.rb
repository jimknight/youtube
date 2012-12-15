class ImportsController < ApplicationController

  def new
    @import = Import.new
  end

  def index
    @imports = Import.where(:status => "Pending").order("url ASC")
  end

  def create
    @import = Import.new(params[:import])
    @import.status = "Pending"
    if @import.save
      redirect_to imports_path, :notice => "Saved your youtube url!"
    else
      render :new
    end
  end

  def destroy
    @import = Import.find(params[:id])
    @import.destroy
    redirect_to imports_path, :notice => "Gone!"
  end

end
