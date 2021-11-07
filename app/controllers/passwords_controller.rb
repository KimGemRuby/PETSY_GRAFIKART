class PasswordsController < ApplicationController

    skip_before_action :only_signed_in
    before_action :only_signed_out

    def new

    end

    def create
        user_params = params.require(:user)
        @user = User.find_by_email(user_params[:email])
        if @user
            @user.regenerate_recover_password
            UserMailer.password(@user).deliver_now
            redirect_to new_session_path, success: 'Un email vous a ete envoye'
        else
            redirect_to new_password_path, danger: 'Aucun utilisateur ne correspond a cet email'
        end
    end

    def edit
        @user =User.find(params[:id])
        if @user.recover != params[:token]
            redirect_to new_passord_path, danger: 'token Invalide'
        end
    end
    
    def update
        user_params = params.require(:user).permit(:password, :password_confirmation, :recover_password)
        @user = User.find(params[:id])
        if @user.recover_password === user_params[:recover_password]
            @user.assign_attributes(user_params)
            if @user.valid?
               @user.save
               seesion[:auth] = @user.to_session
               redirect_to profil_path, success: 'Vote mot de passe a bien ete modifie'
            else
                render :edit
            end
            redirect_to new_password_path, danger: 'Token invalide'
        end
    end

    def user_params
        params.require(:user).permit(:password, :password_confirmation, :recover_password)
    end
end