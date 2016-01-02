class InvitationMailer < MandrillMailer::MessageMailer
  default from: 'support@example.com'

  def invite(invitation)
    # in this example `invitation.invitees` is an Array
    invitees = invitation.invitees.map { |invitee| { email: invitee.email, name: invitee.name } }

    # no need to set up template and template_content attributes, set up the html and text directly
    mandrill_mail subject: I18n.t('invitation_mailer.invite.subject'),
                  to: invitees,
                  # to: invitation.email,
                  # to: { email: invitation.email, name: 'Honored Guest' },
                  text: "Example text content",
                  html: "<p>Example HTML content</p>",
                  # when you need to see the content of individual emails sent to users
                  view_content_link: true,
                  vars: {
                    'OWNER_NAME' => invitation.owner_name,
                    'PROJECT_NAME' => invitation.project_name
                  },
                  important: true,
                  inline_css: true,
                  attachments: [
                    {
                      content: File.read(File.expand_path('assets/offer.pdf')),
                      name: 'offer.pdf',
                      type: 'application/pdf'
                    }
                  ],
                  recipient_vars: invitation.invitees.map do |invitee| # invitation.invitees is an Array
                    { invitee.email =>
                      {
                        'INVITEE_NAME' => invitee.name,
                        'INVITATION_URL' => new_invitation_url(invitee.email, secret: invitee.secret_code)
                      }
                    }
                  end
  end
end
