class Friend < NanoStore::Model
  attribute :image_path
  attribute :image_orientation
  attribute :thumbnail_path
  attribute :created_at

  def image
    @image ||= begin
      if img_path = self.image_path
        path = NSString.pathWithComponents([App.documents_path, img_path])
        raw_image = UIImage.imageWithContentsOfFile(path)
        UIImage.imageWithCGImage(raw_image.CGImage,
          scale:1.0, orientation:self.image_orientation)
      else
        nil
      end
    end
  end

  def thumbnail
    @thumbnail ||= begin
      if thumb_path = self.thumbnail_path
        path = NSString.pathWithComponents([App.documents_path, thumb_path])
        UIImage.imageWithContentsOfFile(path)
      else
        nil
      end
    end
  end
end