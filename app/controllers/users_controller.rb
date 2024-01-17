class UsersController < ApplicationController
    before_action :filter_user, except: %i[create index]
    before_action :authorize_request, except: [:create]
    before_action :check_type_user, except: [:create]
  
    
    def index
      @users = User.all
      json_response(@users)
    end
    
    def show
      render json: @user, status: :ok
    end
  
    def create
      @user = User.new(user_params)
      @user.company = Company.find(params[:user][:company_id])
      if @user.save
        json_response(@user, :created)
      else
        render json: { errors: @user.errors.full_messages },
               status: :unprocessable_entity
      end
    end
  
    def update
      unless @user.update(user_params)
        render json: { errors: @user.errors.full_messages },
               status: :unprocessable_entity
      end
    end
  
    def destroy
      @user.destroy
    end
  
    private

    def json_response(object, status = :ok)
      render json: object, status: status
    end

    def user_params
      params.require(:user).permit(:email, :name, :password, :company_id, :username, :type_user)
    end

    #Filter
  
    def filter_user
      @user = User.find_by_username!(params[:_username])
      rescue ActiveRecord::RecordNotFound
        render json: { errors: 'User not found' }, status: :not_found
    end
    
end
