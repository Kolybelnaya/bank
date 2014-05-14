class ClientsMailer < ActionMailer::Base
  default from: "noreply@alfacreditbank.com"

  def request_accepted(request)
    @request = request
    mail(to: @request.email, subject: "Оператор одобрил вашу заявку")
  end
end
