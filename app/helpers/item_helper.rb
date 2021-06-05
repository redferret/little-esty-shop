module ItemHelper
  def enable_disable_link(type, merchant, item)
    case type
    when 'enable'
      link_to 'Enable', merchant_item_path(merchant, item, status: true), method: :patch, class:'btn btn-primary btn-sm'
    when 'disable'
      link_to 'Disable', merchant_item_path(merchant, item, status: false), method: :patch, class:'btn btn-secondary btn-sm'
    end
  end
end