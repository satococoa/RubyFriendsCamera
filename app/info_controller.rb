class InfoController < UIViewController
  attr_accessor :delegate
  def viewDidLoad
    image = UIImage.imageNamed('Default.png')
    image_view = UIImageView.alloc.initWithImage(image).tap do |iv|
      iv.frame = content_frame
      iv.contentMode = UIViewContentModeScaleAspectFill
      iv.userInteractionEnabled = true
      tap = UITapGestureRecognizer.alloc.initWithTarget(self, action:'close')
      iv.addGestureRecognizer(tap)
    end
    view.addSubview(image_view)
  end

  def close
    @delegate.close_info(self)
  end
end