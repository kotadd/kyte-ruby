class PagesController < ApplicationController

  before_action :forbid_login_user, {only: [:top]}
  def about   
	@user = User.new
  end

  def top
    @genre = Genre.all
	@user = User.new
  end
end
