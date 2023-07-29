module ApplicationHelper
  def image_path_exists?(path)
    File.exist?(Rails.root.join('app', 'assets', 'images', path))
  end
end
