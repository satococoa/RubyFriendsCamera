class Friend < NanoStore::Model
  attribute :image_path
  attribute :image_orientation
  attribute :created_at

  def image
    @image ||= begin
      raw_image = UIImage.imageWithContentsOfFile(self.image_path)
      UIImage.imageWithCGImage(raw_image.CGImage,
        scale:1.0, orientation:self.image_orientation)
    end
  end
end