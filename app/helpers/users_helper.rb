module UsersHelper
  def update_without_password(user, params)
  	user.update_attribute(:name, params[:name])&&user.update_attribute(:phone, params[:phone])&&user.update_attribute(:description, params[:description])
  end
end