class PhotosController < UICollectionViewController
    def viewDidLoad
    super
    navigationItem.title = 'RubyFriends'
    navigationController.toolbarHidden = false
    camera_button = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemCamera, target:self, action:'camera_tapped')
    navigationItem.rightBarButtonItem = camera_button
    collectionView.backgroundColor = UIColor.underPageBackgroundColor
  end

  def camera_tapped
    action_sheet = UIActionSheet.alloc.initWithTitle('Add RubyFriends', delegate:self, cancelButtonTitle:'Cancel', destructiveButtonTitle:nil, otherButtonTitles:'Take Photo', 'Choose from Album', nil)
    action_sheet.showFromToolbar(navigationController.toolbar)
  end

  def actionSheet(action_sheet, clickedButtonAtIndex:button_index)
    case button_index
    when 0 # take photo
      take_picture
    when 1 # choose from album
      open_album
    when action_sheet.cancelButtonIndex
      return
    end
  end

  def take_picture
    BW::Device.camera.rear.picture(media_types: [:image]) do |result|
      image = result[:original_image]
      open_tweet(image)
    end
  end

  def open_album
    BW::Device.camera.any.picture(media_types: [:image]) do |result|
      image = result[:original_image]
      p AppDelegate::HASHTAG
      open_tweet(image)
    end
  end

  def open_tweet(image)
    p image, AppDelegate::HASHTAG
  end
end