module AdminHelper
  def enable_disable_merchant_link(enable, merchant)
    case enable
    when true
      return link_to 'Enable', admin_merchant_path(merchant, enabled: enable), method: :patch, class:'btn btn-primary btn-sm'
    when false
      return link_to 'Disable', admin_merchant_path(merchant, enabled: enable), method: :patch, class:'btn btn-secondary btn-sm'
    end
    fail 'Invalid type given'
  end
end