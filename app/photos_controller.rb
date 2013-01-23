class PhotosController < UICollectionViewController
  def viewDidLoad
    super
    navigationItem.title = 'RubyFriends'
    camera_button = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemCamera, target:self, action:'camera_tapped')
    navigationItem.rightBarButtonItem = camera_button
    open_twitter_button = UIBarButtonItem.alloc.initWithTitle('T', style:UIBarButtonItemStyleBordered, target:self, action:'open_twitter')
    open_rubyfriends_button = UIBarButtonItem.alloc.initWithTitle('RF', style:UIBarButtonItemStyleBordered, target:self, action:'open_rubyfriends')
    self.toolbarItems = [open_twitter_button, open_rubyfriends_button]
    collectionView.registerClass(FriendCell, forCellWithReuseIdentifier:'friend_cell')
    collectionView.backgroundColor = UIColor.underPageBackgroundColor
    @friends = Friend.find({}, {:sort => {:created_at => :desc}})
    navigationController.toolbarHidden = false
  end

  def viewWillAppear(animated)
    navigationController.tap do |nav|
      # nav.toolbarHidden = false
      nav.navigationBar.translucent = false
    end
  end

  def viewDidAppear(animated)
    if @image
      open_tweet(@image)
      @image = nil
    end
  end

  def numberOfSectionsInCollectionView(collection_view)
    1
  end

  def collectionView(collection_view, numberOfItemsInSection:section)
    @friends.count
  end

  def collectionView(collection_view, cellForItemAtIndexPath:index_path)
    cell = collection_view.dequeueReusableCellWithReuseIdentifier('friend_cell', forIndexPath:index_path)
    friend = @friends[index_path.row]
    cell.friend = friend
    cell.tag = index_path.row
    tap = UITapGestureRecognizer.alloc.initWithTarget(self, action:'image_tapped:')
    cell.addGestureRecognizer(tap)
    cell
  end

  def image_tapped(target)
    index = target.view.tag
    friend = @friends[index]
    @friend_controller ||= FriendController.new
    @friend_controller.friend = friend
    navigationController.pushViewController(@friend_controller, animated:true)
  end

  private
  def reload
    @friends = Friend.find({}, {:sort => {:created_at => :desc}})
    collectionView.reloadData
  end

  def open_twitter
    App.open_url('https://mobile.twitter.com/search?q=%23RubyFriends')
  end

  def open_rubyfriends
    App.open_url('http://rubyfriends.com')
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
    BW::Device.camera.rear.picture({media_types: [:image]}, self) do |result|
      @image = result[:original_image]
    end
  end

  def open_album
    BW::Device.camera.any.picture({media_types: [:image]}, self) do |result|
      @image = result[:original_image]
    end
  end

  def open_tweet(image)
    if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter)
      tweet_controller = SLComposeViewController.composeViewControllerForServiceType(SLServiceTypeTwitter).tap do |t|
        t.setInitialText(AppDelegate::HASHTAG)
        t.addImage(image)
        t.completionHandler = lambda {|result|
          # TODO: 成功時だけ保存するように戻す
          # if result == SLComposeViewControllerResultDone
          #   save_friend(image)
          # end
          Dispatch::Queue.concurrent.async {
            save_friend(image)
          }
          dismissModalViewControllerAnimated(true)
        }
      end
      presentModalViewController(tweet_controller, animated:true)
    else
      App.alert('Posting twitter is not available.')
    end
  end

  # TODO: モデルに移動する
  def save_friend(image)
    image_path = UIImagePNGRepresentation(image).MD5HexDigest + '.png'
    path = NSString.pathWithComponents([App.documents_path, image_path])
    image.saveToPath(path, type:NYXImageTypePNG, backgroundFillColor:nil)

    thumbnail = image.scaleToFitSize([256, 256])
    thumbnail_path = UIImagePNGRepresentation(thumbnail).MD5HexDigest + '.png'
    path = NSString.pathWithComponents([App.documents_path, thumbnail_path])
    thumbnail.saveToPath(path, type:NYXImageTypePNG, backgroundFillColor:nil)

    Friend.create(
      :image_path => image_path,
      :image_orientation => image.imageOrientation,
      :thumbnail_path => thumbnail_path,
      :created_at => Time.now
    )
    reload
  end
end