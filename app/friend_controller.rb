class FriendController < UIViewController
  attr_accessor :friend
  def init
    super
    self.hidesBottomBarWhenPushed = true
    self
  end

  def viewDidLoad
    super
    view.styleId = 'friend'
    action_button = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemAction, target:self, action:'action_tapped')
    delete_button = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemTrash, target:self, action:'delete_tapped')
    navigationItem.rightBarButtonItems = [action_button, delete_button]

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
    navigationController.navigationBar.translucent = true
    setup_image_frame
    setup_label
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

  def action_tapped
    action_sheet = UIActionSheet.alloc.initWithTitle('Share', delegate:self, cancelButtonTitle:'Cancel', destructiveButtonTitle:nil, otherButtonTitles:'Twitter', 'Facebook', 'Save to album', nil)
    action_sheet.tag = 1
    action_sheet.showInView(view)
  end

  def delete_tapped
    action_sheet = UIActionSheet.alloc.initWithTitle('Are you sure to delete?', delegate:self, cancelButtonTitle:'Cancel', destructiveButtonTitle:'OK', otherButtonTitles:nil)
    action_sheet.tag = 2
    action_sheet.showInView(view)
  end

  def actionSheet(action_sheet, clickedButtonAtIndex:button_index)
    if action_sheet.tag == 1
      case button_index
      when 0 # twitter
        open_share(:twitter)
      when 1 # facebook
        open_share(:facebook)
      when 2 # save to album
        @friend.image.saveToPhotosAlbum
      when action_sheet.cancelButtonIndex
        return
      end
    else
      case button_index
      when 0
        delete
      when action_sheet.cancelButtonIndex
        return
      end
    end
  end

  private
  def delete
    @friend.delete
    navigationController.viewControllers[0].reload
    navigationController.popViewControllerAnimated(true)
  end

  def open_share(type)
    case type
    when :twitter
      service_type = SLServiceTypeTwitter
    when :facebook
      service_type = SLServiceTypeFacebook
    end
    if SLComposeViewController.isAvailableForServiceType(service_type)
      controller = SLComposeViewController.composeViewControllerForServiceType(service_type).tap do |t|
        t.setInitialText(AppDelegate::HASHTAG + ' ')
        t.addImage(@friend.image)
        t.completionHandler = lambda {|result|
          dismissModalViewControllerAnimated(true)
        }
      end
      presentModalViewController(controller, animated:true)
    else
      App.alert("Posting #{type} is not available.")
    end
  end

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