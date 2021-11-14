module Admin

    class ApplicationController < ::ApplicationController

        #layout 'admin'
        before_filter :only_admin

        private

        def only_admin
            if !user_signed_in? ||current_user.role != 'admin'
                redirect_to new_user_path, danger: 'You are not authorized to access this page.'
            end
        end
        
        
    end
end


