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
end
