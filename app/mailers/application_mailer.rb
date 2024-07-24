# frozen_string_literal: true

# ApplicationMailer serves as the base class for all mailers in the application.
# It provides default configurations for outgoing emails, including the default
# sender email address and the layout to be used for email templates.
#
# The `default from` setting specifies the default sender email address for all
# emails sent by the application's mailers. The `layout` specifies the layout template
# that will be applied to all email views.
class ApplicationMailer < ActionMailer::Base
  # Default sender email address for all emails sent by this mailer.
  default from: "from@example.com"

  # Layout to be used for email views. This layout will wrap the content of all emails.
  layout "mailer"
end
