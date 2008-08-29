class Contact < ActiveRecord::BaseWithoutTable
  column :name, :string
  column :email, :string
  column :message, :text
  
  validates_presence_of :name, :email, :message
  validates_as_email_address :email
  
  def send_mail(page_title)
    valid? && Notifier.deliver_email_from_page(self.email, self.name, 
      self.message, page_title) ? true : false
  end
end
