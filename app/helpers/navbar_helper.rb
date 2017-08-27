module NavbarHelper
  def badge_nav_link(name, path, badge_count = "")
    if badge_count.to_i == 0
      link_to name, path, class: "navbar-item"
    else
      link_to name, path, class: "navbar-item badge is-badge-danger", 'data-badge' => badge_count
    end
  end
end
