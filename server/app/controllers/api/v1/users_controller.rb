# rails g controller api/v1/users --no-assets --no-helper --skip-template-engine
class Api::V1::UsersController < Api::ApplicationController
    def create
        user=User.new params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
        if user.save
            render(json: {id: user.id})
        else
            render(
                json: {errors: user.errors},
                status: 422
            )
        end
    end
end

