class UserMailer < ApplicationMailer

    def confirm(user)
        @user = user
        mail(to: user.email, subject: 'votre inscription sur le site' + Rails.application.config.site[:name])
    end

    def password(user)
        @user = user
        mail(to: user.email, subject: 'Reinitialisation de votre mot de pass' + Rails.application.config.site[:name])
    end
end


