module ApplicationHelper
  def active_nav_class(controller_name, tab)
    controller_name =~ /#{Regexp.quote(tab)}/i ? 'active' : nil
  end

  def error_message_on(model, field)
    ''.html_safe.tap do |error|
      unless model.errors[field].blank?
        error << content_tag(:span, "#{model.errors[field].first}", class: 'help-inline')
      end
    end
  end
end
