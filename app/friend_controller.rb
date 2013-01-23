class FriendController < UIViewController
  attr_accessor :friend
  def init
    super
    self.hidesBottomBarWhenPushed = true
    self
  end

  def viewDidLoad
    super
    @image_view = UIImageView.new.tap do |iv|
      iv.frame = CGRectZero
      iv.contentMode = UIViewContentModeScaleAspectFit
      iv.userInteractionEnabled = true
      tap = UITapGestureRecognizer.alloc.initWithTarget(self, action:'toggle_navigation_bar')
      iv.addGestureRecognizer(tap)
    end
    view.addSubview(@image_view)
    view.backgroundColor = UIColor.underPageBackgroundColor
  end

  def viewWillAppear(animated)
    setup_image_frame
    navigationController.navigationBar.translucent = true
  end

  def setup_image_frame
    image_size = @friend.image.size
    frame_size = CGSizeMake(App.bounds.size.width, App.bounds.size.height - 20)
    if image_size.height > frame_size.height
      height = frame_size.height
      width = height / image_size.height * image_size.width
      if width > frame_size.width
        width = frame_size.width
        height = width / image_size.width * image_size.height
      end
    elsif image_size.width > frame_size.width
      width = frame_size.width
      height = width / image_size.width * image_size.height
    else
      height = image_size.height
      width = image_size.width
    end
    x = (frame_size.width - width) / 2
    y = (frame_size.height - height) / 2
    @image_view.frame = [[x, y], [width, height]]
    @image_view.image = @friend.image
  end

  private
  def toggle_navigation_bar
    navigationController.setNavigationBarHidden(!navigationController.navigationBarHidden?, animated:true)
  end
end