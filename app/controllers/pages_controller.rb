require 'open-uri'
class PagesController < ApplicationController
  before_action :authenticate_user!, only: [
    :inside
  ]

  def home
  end
  
  def report
    @q = Transaction.ransack(params[:q])
    @transactions  = @q.result
    @transactions = @transactions.page(params[:page])
    
    #respond_to do |format|
     # format.pdf { 
        render_report(@transactions)
      #}
   # end
    
  end
  
  def inside
    
  end
  
 
  def posts
    @posts = Post.published.page(params[:page]).per(10)
  end

  def show_post
    @post = Post.friendly.find(params[:id])
  rescue
    redirect_to root_path
  end

  
  def email
    @name = params[:name]
    @email = params[:email]
    @message = params[:message]

    if @name.blank?
      flash[:alert] = "Please enter your name before sending your message. Thank you."
      render :contact
    elsif @email.blank? || @email.scan(/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i).size < 1
      flash[:alert] = "You must provide a valid email address before sending your message. Thank you."
      render :contact
    elsif @message.blank? || @message.length < 10
      flash[:alert] = "Your message is empty. Requires at least 10 characters. Nothing to send."
      render :contact
    elsif @message.scan(/<a href=/).size > 0 || @message.scan(/\[url=/).size > 0 || @message.scan(/\[link=/).size > 0 || @message.scan(/http:\/\//).size > 0
      flash[:alert] = "You can't send links. Thank you for your understanding."
      render :contact
    else
      ContactMailer.contact_message(@name,@email,@message).deliver_now
      redirect_to root_path, notice: "Your message was sent. Thank you."
    end
  end

  private
  def open_chart(*params)
  end  
  
  def render_report(transactions)
      report = ThinReports::Report.new layout: File.join(Rails.root, 'app', 'reports', 'test.tlf')
            
    report.start_new_page do
     http://chart.apis.google.com/chart?cht=bhs&chs=200x125&chd=t:10,50,60,100,40&chco=4d89f9&chxt=x,y
      item(:image).src( open('http://chart.apis.google.com/chart?' + URI.encode(['cht=bhs','chs=340x140','chco=4d89f9,c6d9fd','chd=t:10,50,60,80,40|50,60,100,40,20','chds=0,19','chxt=x,y','chxl=1:|Jan|Feb|Mar|Apr|May'].join('&')))
)
      #  item(:image).src(open("http://chart.apis.google.com/chart?cht=p3&chs=450x200&chd=t:2,4,3,1&chl=Phones|Computers|Services|Other&chtt=Company%20Sales&chco=ff0000"))
      end
      send_data report.generate, filename: 'tasks.pdf', 
                                 type: 'application/pdf', 
                                 disposition: 'attachment'
    end
end
