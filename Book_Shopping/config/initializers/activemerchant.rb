if Rails.env == "development"
  ActiveMerchant::Billing::FirstdataE4Gateway.wiredump_device = File.open(Rails.root.join("log","active_merchant.log"), "a+")
  ActiveMerchant::Billing::FirstdataE4Gateway.wiredump_device.sync = true
  ActiveMerchant::Billing::Base.mode = :test

  login = "IB0566-48"
  password="w89f1665ojgnd5wz5wf32fsv38zifg9b"
elsif Rails.env == "production"
  login = 'IB0566-48'
  password='w89f1665ojgnd5wz5wf32fsv38zifg9b'
end

GATEWAY = ActiveMerchant::Billing::FirstdataE4Gateway.new({
      login: login,
      password: password
})
