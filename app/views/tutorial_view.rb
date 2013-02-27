class TutorialView < UIView
  def initWithFrame(rect)
    super.tap do
      self.backgroundColor = UIColor.clearColor
      main_image = UIImage.imageNamed('tutorial-main.png')
      main = UIImageView.alloc.initWithImage(main_image).tap do |iv|
        iv.frame = [[5, (self.bounds.size.height - 254)/2], [310, 254]]
        iv.contentMode = UIViewContentModeScaleAspectFit
        iv.layer.shadowColor = UIColor.blackColor.CGColor
        iv.layer.shadowRadius = 3
        iv.layer.shadowOpacity = 0.8
        iv.layer.shadowOffset = [2, 2]
        iv.clipsToBounds = false
      end
      camera_image = UIImage.imageNamed('tutorial-camera.png')
      camera = UIImageView.alloc.initWithImage(camera_image).tap do |iv|
        iv.frame = [[10, 0], [296, 46]]
        iv.contentMode = UIViewContentModeScaleAspectFit
        iv.layer.shadowColor = UIColor.blackColor.CGColor
        iv.layer.shadowRadius = 3
        iv.layer.shadowOpacity = 0.8
        iv.layer.shadowOffset = [2, 2]
        iv.clipsToBounds = false
      end
      rubyfriends_image = UIImage.imageNamed('tutorial-rubyfriends.png')
      rubyfriends = UIImageView.alloc.initWithImage(rubyfriends_image).tap do |iv|
        iv.frame = [[15, self.bounds.size.height - 52], [252, 52]]
        iv.contentMode = UIViewContentModeScaleAspectFit
        iv.layer.shadowColor = UIColor.blackColor.CGColor
        iv.layer.shadowRadius = 3
        iv.layer.shadowOpacity = 0.8
        iv.layer.shadowOffset = [2, 2]
        iv.clipsToBounds = false
      end
      addSubview(main)
      addSubview(camera)
      addSubview(rubyfriends)
    end
  end
end