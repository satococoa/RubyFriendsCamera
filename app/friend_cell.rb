class FriendCell < UICollectionViewCell
  def initWithFrame(rect)
    super
    @image_view ||= UIImageView.new.tap do |iv|
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
    @image_view.image = friend.image
  end
end