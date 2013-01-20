class FriendCell < UICollectionViewCell
  def friend=(friend)
    image = UIImage.imageWithData(friend.image)
    image_view = UIImageView.alloc.initWithImage(image).tap do |iv|
      p contentView.bounds.size
      iv.frame = contentView.bounds
      iv.center = contentView.center
      iv.contentMode = UIViewContentModeScaleAspectFit
    end
    contentView.addSubview(image_view)
  end
end