class OrderNotifier < ActionMailer::Base
  default from: "vishalfornarola@gmail.com"

  def received(order)
    @order = order
    mail(to: order.email, subject: "Hello there") do |format|
      # format.text { render 'received', content_type: 'text/plain' }
      format.html
    end
  end

  def shipped(order)
    @order = order
    mail to: order.email, subject: "Hello there"
  end
end
