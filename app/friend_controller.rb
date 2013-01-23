class FriendController < UIViewController
  attr_accessor :friend
  def init
    super
    self.hidesBottomBarWhenPushed = true
    self
  end

  def viewDidLoad
    super
    view.backgroundColor = UIColor.underPageBackgroundColor

    @image_view = UIImageView.new.tap do |iv|
      iv.frame = CGRectZero
      iv.contentMode = UIViewContentModeScaleAspectFit
      iv.userInteractionEnabled = true
      tap = UITapGestureRecognizer.alloc.initWithTarget(self, action:'toggle_navigation_bar')
      iv.addGestureRecognizer(tap)
    end
    view.addSubview(@image_view)

    @label = UILabel.new.tap do |l|
      l.textAlignment = UITextAlignmentRight
      l.alpha = 0.8
      l.textColor = UIColor.whiteColor
      l.font = UIFont.boldSystemFontOfSize(14)
      l.backgroundColor = UIColor.blackColor
    end
    view.addSubview(@label)
  end

  def viewWillAppear(animated)
    setup_image_frame
    setup_label
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

  def setup_label
    @label.frame = [[0, App.bounds.size.height - 20 - 30], [content_frame.size.width, 30]]
    @label.text = @friend.created_at.strftime('%Y/%m/%d %H:%M ')
  end

  private
  def toggle_navigation_bar
    hidden = !navigationController.navigationBarHidden?
    navigationController.setNavigationBarHidden(hidden, animated:true)
    UIView.animateWithDuration(0.3,
      animations:lambda {
        y = @label.frame.origin.y + (hidden ? @label.frame.size.height : -@label.frame.size.height)
        @label.frame = [[0, y], @label.frame.size]
      }
    )
  end
end