class PhotoCell < UICollectionViewCell
  def initWithFrame(rect)
    super
    @image_view ||= LoadableImageView.new.tap do |iv|
      iv.contentMode = UIViewContentModeScaleAspectFit
      iv.layer.shadowColor = UIColor.blackColor.CGColor
      iv.layer.shadowRadius = 3
      iv.layer.shadowOpacity = 0.8
      iv.layer.shadowOffset = [2, 2]
      iv.clipsToBounds = false
    end
    contentView.addSubview(@image_view)
    self
  end

  def layoutSubviews
    @image_view.tap do |iv|
      iv.frame = contentView.bounds
      iv.center = contentView.center
    end
  end

  def photo=(photo)
    if photo.thumbnail.nil?
      @image_view.loading = true
    else
      @image_view.loading = false
      @image_view.image = photo.thumbnail
    end
  end
end