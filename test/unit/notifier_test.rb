require 'test/test_helper'
require 'notifier'

class NotifierTest < Test::Unit::TestCase 

  def setup
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []

  end

  def test_job_posted
    
    recipient = "#{AppConfig.from_email}"
    company = 'jobberRails'
    response = Notifier.deliver_job_posted(recipient,company)
    
    assert_equal "#{AppConfig.site_name} - Thanks for Posting", response.subject
    assert_match "Hello jobberRails!,\n\nThank you for posting a new job opening. \n\nWe'll be in touch when somebody applies.", response.body
    assert_equal "jobberrails@gmail.com", response.to[0]
  end

  def test_somebody_applied
   
    recipient = "#{AppConfig.from_email}"
    company = 'jobberRails'
    message = "New Job Applicant"
    filename = "filename"
    id = "3"
    sent_at = Time.now
    response = Notifier.deliver_somebody_applied(recipient,name,message,filename,id,sent_at)
   
    assert_equal "#{AppConfig.site_name} - New Job Applicant", response.subject
    assert_equal "jobberrails@gmail.com", response.to[0]
    assert response.body =~ /New Job Applicant/

  end
  
  def test_email_from_page
    from = "john@smith.ue"
    name = "John Smith"
    page_title = "Contact us"
    body = "Hi, there!"
    
    response = Notifier.deliver_email_from_page(from, name, body, page_title)

    assert_equal "Email from page: '#{page_title}'", response.subject
    assert_equal body, response.body
  end
   
  private
  def read_fixture(action)
    IO.readlines("#{action}")
  end
   
   
end

