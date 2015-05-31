class Admin::Base < ApplicationController
  before_filter :admin_login_required

  private
  def admin_login_required
    not_found unless current_user && (current_user.email == 'fantastic.ron@gmail.com' || current_user.email == 'mail@imaizu.me' || current_user.email == 'rika_horiguchi1029@yahoo.co.jp')
  end
end