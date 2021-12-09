class FollowingController < ApplicationController
    def show
        @title = "Following"
        @user = User.find_by(id: params[:user_id])
        @users = @user.following().paginate(page: params[:page])
        render "users/show_follow"
    end
end
