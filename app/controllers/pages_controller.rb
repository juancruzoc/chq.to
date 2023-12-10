class PagesController < ApplicationController
  def home
    if user_signed_in?
      @short_links = ShortLink.where('user_id': current_user.id)
    end
  end
end
