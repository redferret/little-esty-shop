module ItemHelper
  def enable_disable_link(enable, merchant, item)
    case enable
    when true
      link_to 'Enable', merchant_item_path(merchant, item, status: true), method: :patch, class:'btn btn-primary btn-sm'
    when false
      link_to 'Disable', merchant_item_path(merchant, item, status: false), method: :patch, class:'btn btn-secondary btn-sm'
    end
  end
end