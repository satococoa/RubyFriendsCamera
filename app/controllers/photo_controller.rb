class PhotoController < UIViewController
  include Share

  attr_accessor :photo
  def init
    super
    self.hidesBottomBarWhenPushed = true
    self
  end

  def viewDidLoad
    super
    view.styleId = 'photo'
    action_button = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemAction, target:self, action:'action_tapped')
    delete_button = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemTrash, target:self, action:'delete_tapped')
    navigationItem.rightBarButtonItems = [action_button, delete_button]

    @image_view = PhotoImageView.alloc.initWithFrame(App.bounds)
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
    @image_view.image = @photo.image
    setup_label
    register_tap_observers
  end

  def viewWillDissapear(animated)
    unregister_tap_observers
  end

  def dealloc
    unregister_tap_observers
    super
  end

  def register_tap_observers
    @tap_observer = App.notification_center.observe('PhotoImageViewTapped') do |notif|
      performSelector('toggle_navigation_bar', withObject:nil, afterDelay:0.2)
    end
    @double_tap_observer = App.notification_center.observe('PhotoImageViewDoubleTapped') do |notif|
      NSObject.cancelPreviousPerformRequestsWithTarget(self)
      @image_view.toggle_zoom
    end
  end

  def unregister_tap_observers
    App.notification_center.unobserve(@tap_observer)
    App.notification_center.unobserve(@double_tap_observer)
  end

  def setup_label
    @label.frame = [[0, App.bounds.size.height - 20 - 30], [content_frame.size.width, 30]]
    @label.text = @photo.created_at.strftime('%Y/%m/%d %H:%M ')
  end

  def action_tapped
    action_sheet = UIActionSheet.alloc.initWithTitle('Share', delegate:self, cancelButtonTitle:'Cancel', destructiveButtonTitle:nil, otherButtonTitles:'Twitter', 'Save to album', nil)
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
      when 1 # save to album
        @photo.image.saveToPhotosAlbum
        SVProgressHUD.showSuccessWithStatus('Saved!')
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
    @photo.delete
    navigationController.viewControllers[0].reload
    navigationController.popViewControllerAnimated(true)
  end

  def open_share(type)
    controller = share_controller(:twitter) do |c|
      c.setInitialText(AppDelegate::HASHTAG + ' ')
      c.addImage(@photo.image)
      c.completionHandler = lambda {|result|
        dismissModalViewControllerAnimated(true)
      }
      c
    end
    presentModalViewController(controller, animated:true)
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