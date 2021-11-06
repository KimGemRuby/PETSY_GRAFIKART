class UsersController < ApplicationController

    skip_before_action :only_signed_in, only: [:new, :create, :confirm]
    before_action :only_signed_out, only: [:new, :create, :confirm]

    def new
        @user = User.new
    end

    def create
        user_params = params.require(:user).permit(:username, :email, :password, :password_confirmation)
            @user = User.new(user_params)
            if @user.valid?
                @user.save
                UserMailer.confirm(@user).deliver_now
                redirect_to new_user_path success: 'votre compte a bien ete creee, vous devriez recevoir un email de confimation'
                #render 'new'
             else 
                render 'new'
             end
    end

    def confirm
        @user = User.find(params[:id])
        if @user.confirmation_token == params[:token]
            @user.update_attribute(confirmed: true, confirmation_token: nil)
            @user.save(validate: false)
            session[:auth] = @user.to_session
            redirect_to profil_path, success: 'votre compte a bien ete confirme'
        else
            redirect_to new_user_path, danger: 'le token n est pas valide'
        end
    end

    def edit
        @user = current_user
    end

    def update
        @user = current_user
        user_params = params.require(:user).permit(:username, :firstname, :lastname, :avatar_file, :email)
        puts user_params[:avatar].inspect
        if @user.update(user_params)
            redirect_to profil_path, success: 'votre compte a bien ete mis a jour'
        else
            render 'edit'
        end
    end

   


    
end