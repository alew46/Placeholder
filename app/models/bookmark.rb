class Bookmark < ActiveRecord::Base
  belongs_to :topic

  has_many :likes, dependent: :destroy

  before_save :normalize_url
  after_create :set_image_url


  def set_image_url
    begin
      object = LinkThumbnailer.generate(url)
      Rails.logger.info "#{object.images.first.inspect}"
      update_attribute(:image_url, object.images.first.to_s)
    rescue
      Rails.logger.warn "Bad image url for bookmark #{self.id}"
    end
  end

  def normalize_url
    self.url = "http://#{self.url}" if URI.parse(self.url).scheme.nil?
    self.url = self.url
  end

  def pretty_url
    host = URI.parse(url).host.downcase
    host.start_with?('www.') ? host[4..-1] : host
  end
end
