class Admin::Base < ApplicationController
  before_filter :admin_login_required

  private
  def admin_login_required
    not_found unless current_user && (current_user.email == 'fantastic.ron@gmail.com' || current_user.email == 'mail@imaizu.me' || current_user.email == 'hry-me-so-high.xxakir@docomo.ne.jp')
  end
end