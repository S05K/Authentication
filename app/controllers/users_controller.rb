class UsersController < ApplicationController
    skip_before_action :authenticate_request, only: [:create]
    before_action :set_user, only: [:show, :destroy]

    def index 
        @users=User.all
        render json: @users
    end

    def show
        byebug
        if params[:id].to_i == @current_user.id
         render json: @user
        else 
            render json:{message: "not found"} 
        end

    end

    # def book_information
    #     if @current_user
    #       book = @current_user.books
    #       render json: {data: book}
    #     end
    # end

    def create
        # byebug
        @user = User.new(user_params)
        if @user.save
            render json: @user
        else
            render json: "Something is wrong"
        end
    end

    def update
         @user = User.find(params[:id])
      if  @user.update(user_params)
        render json: "User is updated"
      else 
        render json: "Something is wrong"
     end
    end

    def destroy
       if @user.destroy
        render json: "User is deleted"
       else
        render json: "Something is wrong"
    end
    end

    private
    def user_params
        params.require(:user).permit(:name, :username, :email, :password, :password_confirmation)
      end
      

    def set_user
        @user = User.find( params[:id])
    end
end
