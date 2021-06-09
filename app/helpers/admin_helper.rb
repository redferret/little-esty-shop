module AdminHelper
  def enable_disable_merchant_link(type, merchant)
    case type
    when 'enable'
      return link_to 'Enable', admin_merchant_path(merchant, enabled: true), method: :patch, class:'btn btn-primary btn-sm'
    when 'disable'
      return link_to 'Disable', admin_merchant_path(merchant, enabled: false), method: :patch, class:'btn btn-secondary btn-sm'
    end
    fail 'Invalid type given'
  end
end