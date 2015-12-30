class UsersController < ApplicationController

  def new 
    @user = User.new
  end

  def create
    passed = user_params
    @name = passed[:name]
    @mobile = passed[:mobile]
    @email = passed[:email]
    @password = passed[:password]
    @gender = passed[:gender]
    @checkbox = params[:checkboxes]

    if(@checkbox == "1")
      @user = User.create_with_password(@name,@mobile,@email,@gender,@password)
      if @user.id != nil
        session[:signed] = true
        session[:email] = @user.email
        session[:name] = @user.name
        redirect_to '/home'
      else
        render :action => 'new'
      end
    else
      redirect_to '/signup'
    end
  end
    
  def user_params
  	params.require(:user).permit(:name,:mobile,:email,:gender,:password)
  end

end
