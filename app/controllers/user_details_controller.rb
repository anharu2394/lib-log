class UserDetailsController < ApplicationController
  def new
    @user_detail = UserDetail.new

  end

  def create
    UserDetail.create(create_params)
  end

  def edit
    @user_detail = UserDetail.find(params[:id])

  end

  def update
    user_detail = UserDetail.find(params[:id])
      user_detail.update(create_params)
  end
   private
  def create_params
    return params.require(:user_detail).permit(:profile,:age,:gender).merge(user_id: current_user.id)
  end
end
