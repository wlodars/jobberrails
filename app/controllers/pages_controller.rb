class PagesController < ApplicationController
  
  # GET /pages/1
  def show
    @page = Page.find_by_url params[:id]
    if @page.has_form
      @contact = Contact.new
    end
  end
  
  def send_message
    @page = Page.find_by_url params[:id]    
    @contact = Contact.new(params[:contact])
    
    @contact = nil if @contact.send_mail(@page.title)
    respond_to do |format|
      format.html { redirect_to @page }
      format.js # send_message.js.rjs
    end
  end
end
