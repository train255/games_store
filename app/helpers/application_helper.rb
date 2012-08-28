module ApplicationHelper
  def devise_mapping
    Devise.mappings[:user]
  end
  
  def resource
    User.new
  end
  
  def resource_name
    devise_mapping.name
  end

  def resource_class
    devise_mapping.to
  end
  
  def sortable_link(sort_by, current_direction, path)
    if params['sort_by'] == sort_by && current_direction == 'asc'
      link_to "#{sort_by.humanize} &uarr;".html_safe, "#{path}?sort_by=#{sort_by}&direction=desc"
    elsif params['sort_by'] == sort_by && current_direction == 'desc'
      link_to "#{sort_by.humanize} &darr;".html_safe, "#{path}?sort_by=#{sort_by}&direction=asc"
    else
      link_to "#{sort_by.humanize}".html_safe, "#{path}?sort_by=#{sort_by}&direction=desc"
    end
  end
end
