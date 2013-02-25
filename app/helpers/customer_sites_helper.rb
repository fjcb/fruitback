module CustomerSitesHelper

  def widget_url(site)
    s = root_url
    s.slice! /https?:\/\//
    "#{s}customer_site/#{site.id}/widget.js"
  end

end
