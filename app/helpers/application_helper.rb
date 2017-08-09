module ApplicationHelper
  def class_for flash_type
    { success: 'is-primary', error: 'is-danger', notice: 'is-warning'}[flash_type.to_sym]
  end

  def flash_messages(opts = {})
    flash.map do |msg_type, message|
      content_tag(:div, class: "message #{class_for(msg_type)}") do
        content_tag(:div, class: "message-header") do
          (message + content_tag(:button, 'x'.html_safe, class: 'delete')).html_safe
        end
      end
    end.join.html_safe
  end
end
