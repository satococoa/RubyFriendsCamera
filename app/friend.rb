class Friend < NanoStore::Model
  attribute :image_path
  attribute :image_orientation
  attribute :thumbnail_path
  attribute :created_at

  def delete
    path = NSString.pathWithComponents([App.documents_path, self.image_path])
    error_ptr = Pointer.new(:object)
    NSFileManager.defaultManager.removeItemAtPath(path, error:error_ptr)
    p error_ptr[0] unless error_ptr[0].nil?
    path = NSString.pathWithComponents([App.documents_path, self.thumbnail_path])
    error_ptr = Pointer.new(:object)
    NSFileManager.defaultManager.removeItemAtPath(path, error:error_ptr)
    p error_ptr[0] unless error_ptr[0].nil?
    super
  end

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

  def self.save_with_image(image)
    Dispatch::Queue.concurrent.async {
      image_path = UIImagePNGRepresentation(image).MD5HexDigest + '.png'
      path = NSString.pathWithComponents([App.documents_path, image_path])
      image.saveToPath(path, type:NYXImageTypePNG, backgroundFillColor:nil)

      thumbnail = image.scaleToFitSize([256, 256])
      thumbnail_path = UIImagePNGRepresentation(thumbnail).MD5HexDigest + '.png'
      path = NSString.pathWithComponents([App.documents_path, thumbnail_path])
      thumbnail.saveToPath(path, type:NYXImageTypePNG, backgroundFillColor:nil)

      friend = self.create(
        :image_path => image_path,
        :image_orientation => image.imageOrientation,
        :thumbnail_path => thumbnail_path,
        :created_at => Time.now
      )
      Dispatch::Queue.main.async {
        App.notification_center.post('FriendDidCreate', self, {friend: friend})
      }
    }
  end
end