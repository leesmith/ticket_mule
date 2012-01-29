module ApplicationHelper
  def active_nav_class(controller_name, tab)
    controller_name =~ /#{Regexp.quote(tab)}/i ? 'active' : nil
  end
end
