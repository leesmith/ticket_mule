# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def nice_date date
    # 31 Jan 2009 12:00 pm
    h date.strftime("%d %b %Y %I:%M %p")
  end

  def listing_date date
    # 2009-01-31 12:00 pm
    h date.strftime("%Y-%m-%d %I:%M %p")
  end

  # Show flash messages
  def show_flash
    [:success, :error, :warning].collect do |key|
      content_tag(:div, content_tag(:p, flash[key]), :class => "flash f-#{key}") unless flash[key].blank?
    end.join
  end

  # Generate application tabs, signifying current tab
  def tab_for(tab, link, label=nil)
    content_tag(:li, link_to(content_tag(:span, label || tab.to_s.titleize), link, :class => ("active" if @current_tab == tab)))
  end

  # Return application url_root
  def app_root
    ActionController::Base.relative_url_root
  end

  def user_avatar(user)
    img_url = root_url + "images/avatar.gif"
    image_tag user.gravatar(50, img_url), :alt => "", :class => "profile-avatar"
  end
end
