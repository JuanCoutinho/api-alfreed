module BannersHelper
  def banner_by_id(banner_id)
    Banner.find_by(id: banner_id)
  end
end
