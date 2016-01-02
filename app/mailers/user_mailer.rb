class UserMailer < BaseMandrillMailer
  def welcome(user_id)
    user = User.find(user_id)
    subject = "Wilkommen sie zur spillnich auch kommichten!"
    merge_vars = {
      "FIRST_NAME" => user.first_name,
      "USER_URL" => user_url(user),
    }
    body = mandrill_template("welcome", merge_vars)

    send_mail(user.email, subject, body)
  end
end