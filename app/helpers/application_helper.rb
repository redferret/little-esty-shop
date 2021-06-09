module ApplicationHelper
  def flash_class(level)
    case level
    when 'notice'
      return "class='alert alert-info'".html_safe
    when 'success'
      return "class='alert alert-success'".html_safe
    when 'alert'
      return "class='alert alert-danger'".html_safe
    end
  end

  def project_repo_name
    PROJECT_REPO['name']
  end

  def project_repo_path
    PROJECT_REPO['html_url']
  end
end
