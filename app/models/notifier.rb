class Notifier < ActionMailer::Base
  

  def job_posted(recipient, company, sent_at = Time.now)
    subject    "#{AppConfig.site_name} - Thanks for Posting"
    recipients recipient
    from       AppConfig.from_email
    sent_on    sent_at
    content_type "multipart/alternative"
    
    part :content_type => "text/plain",
      :body =>  render_message("job_posted", :company => company)

  end

  def somebody_applied(recipient, name, message, filename, id, sent_at = Time.now)
    subject    "#{AppConfig.site_name} - New Job Applicant"
    recipients recipient
    from       AppConfig.from_email
    sent_on    sent_at
    content_type "multipart/alternative"
    
    part :content_type => "text/plain",
      :body =>  render_message("somebody_applied", :name => name, :message => message, :filename => filename, :id => id)

  end
  
  def email_from_page(from_email, name, message, page_title, sent_at = Time.now)
    recipients AppConfig.from_email
    from       "#{name}<#{from_email}>"
    sent_on    sent_at
    subject    "Email from page: '#{page_title}'"
    body       message
  end
end
