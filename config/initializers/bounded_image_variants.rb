# Resized cat photos are made in the web request, the first time one is shown.
# A small file can hold a huge picture (an "image bomb") that would keep a Puma
# thread busy decoding it, so the picture's size is read from its header first
# and anything too large is refused instead of resized.
module BoundedImageVariants
  # About 8,000 x 6,000; phone photos are well under this.
  MAX_PIXELS = 50_000_000

  def self.max_pixels = MAX_PIXELS

  # libvips reads only the header here; the gem loads on first use.
  def self.vips?
    return @vips if defined?(@vips)

    @vips = begin
      require "vips"
      true
    rescue LoadError
      false
    end
  end

  def self.check!(path)
    return unless vips?

    image = ::Vips::Image.new_from_file(path.to_s, access: :sequential)
    pages = image.get_typeof("n-pages").zero? ? 1 : image.get("n-pages").to_i.clamp(1, nil)
    return if image.width.to_i * image.height.to_i * pages <= max_pixels

    raise ActiveStorage::InvariableError, "picture too large to resize (#{image.width}x#{image.height}x#{pages})"
  rescue ::Vips::Error
    raise ActiveStorage::InvariableError, "unreadable picture"
  end

  module Transform
    def transform(file, &block)
      BoundedImageVariants.check!(file.path) if file.respond_to?(:path)
      super
    end
  end

  # A refused picture is a 422 for the image request, not a server error.
  module RefusedPicture
    extend ActiveSupport::Concern

    included do
      rescue_from(ActiveStorage::InvariableError) { head :unprocessable_entity }
    end
  end
end

Rails.application.config.to_prepare do
  ActiveStorage::Variation.prepend BoundedImageVariants::Transform unless ActiveStorage::Variation < BoundedImageVariants::Transform
  ActiveStorage::Representations::BaseController.include BoundedImageVariants::RefusedPicture
end
