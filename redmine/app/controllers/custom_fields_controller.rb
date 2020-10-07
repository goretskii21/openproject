class CustomFieldsController < ApplicationController
	layout 'base'		
	before_filter :require_admin
  def index
    list
    render :action => 'list'
  end
  def list
    @custom_field_pages, @custom_fields = paginate :custom_fields, :per_page => 10
  end
  def new
    if request.get?
      @custom_field = CustomField.new
    else
      @custom_field = CustomField.new(params[:custom_field])
      if @custom_field.save
        flash[:notice] = 'CustomField was successfully created.'
        redirect_to :action => 'list'
      end
    end
  end
  def edit
    @custom_field = CustomField.find(params[:id])
    if request.post? and @custom_field.update_attributes(params[:custom_field])
      flash[:notice] = 'CustomField was successfully updated.'
      redirect_to :action => 'list'
    end
  end
  def destroy
    CustomField.find(params[:id]).destroy
    redirect_to :action => 'list'
  rescue
    flash[:notice] = "Unable to delete custom field"
    redirect_to :action => 'list'
  end
end
