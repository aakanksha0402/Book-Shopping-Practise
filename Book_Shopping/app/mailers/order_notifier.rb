class OrderNotifier < ActionMailer::Base
  default from: "vishalfornarola@gmail.com"

  def received(email)
      mail(to: email, subject: "Confirmation Email") do |format|
      format.html {render 'received'}
      format.text { render 'received', content_type: 'text/plain' }
    end
  end

  def shipped(order)
    @order = order
    mail to: order.email, subject: "Hello there"
  end
end
