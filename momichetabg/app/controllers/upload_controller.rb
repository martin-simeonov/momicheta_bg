class UploadController < ApplicationController
  def index
  end

  def create
	  @user = User.create( user_params )
	end

private
	def picture_params
	  params.require(:picture).permit(:avatar)
	end

end
