class PagesController < ApplicationController

  before_action :forbid_login_user, {only: [:top]}
  def about
  end

  def contact
  end

  def top
  end
end
