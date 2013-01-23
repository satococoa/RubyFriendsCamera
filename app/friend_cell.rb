class FriendCell < UICollectionViewCell
  def initWithFrame(rect)
    super
    @image_view ||= LoadableImageView.new.tap do |iv|
      iv.contentMode = UIViewContentModeScaleAspectFit
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

  def friend=(friend)
    if friend.thumbnail.nil?
      @image_view.loading = true
    else
      @image_view.loading = false
      @image_view.image = friend.thumbnail
    end
  end
end