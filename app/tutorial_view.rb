class TutorialView < UIView
  def initWithFrame(rect)
    super.tap do
      self.styleId = 'tutorial'
      image = UIImage.imageNamed('tutorial.png')
      image_view = UIImageView.alloc.initWithImage(image).tap do |iv|
        iv.frame = [[5, 5], [self.bounds.size.width - 10, self.bounds.size.height - 10]]
        iv.contentMode = UIViewContentModeScaleAspectFit
        iv.layer.shadowColor = UIColor.blackColor.CGColor
        iv.layer.shadowRadius = 3
        iv.layer.shadowOpacity = 0.8
        iv.layer.shadowOffset = [2, 2]
        iv.clipsToBounds = false
      end
      addSubview(image_view)
    end
  end
end