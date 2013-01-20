class Friend < NanoStore::Model
  attribute :image_path
  attribute :image_orientation
  attribute :thumbnail_path
  attribute :created_at

  def image
    @image ||= begin
      path = NSString.pathWithComponents([App.documents_path, self.image_path])
      raw_image = UIImage.imageWithContentsOfFile(path)
      UIImage.imageWithCGImage(raw_image.CGImage,
        scale:1.0, orientation:self.image_orientation)
    end
  end

  def thumbnail
    @thumbnail ||= begin
      path = NSString.pathWithComponents([App.documents_path, self.thumbnail_path])
      UIImage.imageWithContentsOfFile(path)
    end
  end
end