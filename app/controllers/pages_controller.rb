class PagesController < ApplicationController

  before_action :forbid_login_user, {only: [:top]}
  def about
  end

  def top
   @genre = Genre.all
  end
end
