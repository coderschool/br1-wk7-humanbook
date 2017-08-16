module ApplicationHelper
  def class_for flash_type
    { success: 'is-primary', error: 'is-danger', notice: 'is-warning'}[flash_type.to_sym]
  end

  def flash_messages(opts = {})
    flash.map do |msg_type, message|
      content_tag(:div, class: "notification #{class_for(msg_type)}") do
        (message + content_tag(:button, 'x'.html_safe, class: 'delete')).html_safe
      end
    end.join.html_safe
  end

  def icon(icon_name, text = nil, options = {class: "icon"})
    if text.present?
      content_tag(:span, fa_icon(icon_name), options) + content_tag(:span, text)
    else
      content_tag(:span, fa_icon(icon_name), options)
    end
  end
end
