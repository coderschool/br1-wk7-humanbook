module NavbarHelper
  def badge_nav_link(name, path, badge_count = "", options = {})
    options[:class] ||= ""
    options[:class] << " navbar-item js-messages-count"

    link_to path, options do
      badge_nav_link_content(badge_count)
    end
  end

  def badge_messages_count(user)
    badge_nav_link icon("comments-o"), messages_path, user.unseen_messages_count
  end

  def badge_nav_link_content(badge_count)
    name = icon("comments-o")
    if badge_count.to_i > 0
      content_tag(:span, name, class: "badge is-badge-danger", :"data-badge" => badge_count)
    else
      name
    end
  end
end
