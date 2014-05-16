module ApplicationHelper
  def nav_item(name, path)
    content_tag('li', class: (current_page?(path) ? 'active-nav-item' : nil)) do
      link_to(name, path)
    end
  end
end