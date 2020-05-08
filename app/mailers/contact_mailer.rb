class ContactMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.contact_mail.subject
  #
  default to: 'iSports@gmail.com' # 送信先アドレス

  def received_email(contact)
    @contact = contact
    mail(subject: 'iSportsお問い合わせフォームよりよりメッセージが届きました') do |format|
      format.text
    end
  end

end
