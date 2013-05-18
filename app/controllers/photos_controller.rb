class PhotosController < PSTCollectionViewController
  def viewDidLoad
    super
    navigationItem.title = 'RubyFriends'

    camera_button = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemCamera, target:self, action:'camera_tapped')
    navigationItem.rightBarButtonItem = camera_button
    
    open_rubyfriends_button = UIBarButtonItem.alloc.initWithImage(UIImage.imageNamed('icon-ruby.png'), style:UIBarButtonItemStyleBordered, target:self, action:'open_rubyfriends')
    spacer = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemFlexibleSpace, target:nil, action:nil)
    info = UIButton.buttonWithType(UIButtonTypeInfoLight).tap do |b|
      b.addTarget(self, action:'open_info', forControlEvents:UIControlEventTouchUpInside)
    end
    info_button = UIBarButtonItem.alloc.initWithCustomView(info)
    self.toolbarItems = [open_rubyfriends_button, spacer, info_button]

    self.collectionView.styleId = 'photos'
    self.collectionView.registerClass(PhotoCell, forCellWithReuseIdentifier:'photo_cell')

    self.collectionView.collectionViewLayout.tap do |l|
      l.itemSize = CGSizeMake(128, 128)
      l.minimumLineSpacing = 20
      l.minimumInteritemSpacing = 20
      l.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20)
    end
    
    reload
    navigationController.toolbarHidden = false
  end

  def viewWillAppear(animated)
    navigationController.navigationBar.translucent = false
    @add_photo_observer = App.notification_center.observe('PhotoDidCreate', Photo) do |notif|
      reload
    end
  end

  def viewWillDisappear(animated)
    App.notification_center.unobserve(@add_photo_observer)
  end

  def viewDidAppear(animated)
    # TODO: 本来は撮影後 or 写真選択後にこの処理を行いたい。
    # BubbleWrap の #picture メソッドの仕様により、これで回避
    if @image
      open_tweet(@image)
      @saving_image = @image
      Dispatch::Queue.concurrent.async {
        @photos = [Photo.new] + @photos
        path = NSIndexPath.indexPathForRow(0, inSection:0)
        Dispatch::Queue.main.async {
          @tutorial.removeFromSuperview unless @tutorial.nil?
          collectionView.insertItemsAtIndexPaths([path])
          Photo.save_with_image(@saving_image)
        }
      }
      @image = nil
    end
  end

  def numberOfSectionsInCollectionView(collection_view)
    1
  end

  def collectionView(collection_view, numberOfItemsInSection:section)
    @photos.count
  end

  def collectionView(collection_view, cellForItemAtIndexPath:index_path)
    cell = collection_view.dequeueReusableCellWithReuseIdentifier('photo_cell', forIndexPath:index_path)
    photo = @photos[index_path.row]
    cell.photo = photo
    cell.tag = @photos.count - index_path.row
    tap = UITapGestureRecognizer.alloc.initWithTarget(self, action:'image_tapped:')
    cell.addGestureRecognizer(tap)
    cell
  end

  def image_tapped(target)
    index = target.view.tag
    photo = @photos[-index]
    if !photo.image.nil?
      @photo_controller ||= PhotoController.new
      @photo_controller.photo = photo
      navigationController.pushViewController(@photo_controller, animated:true)
    end
  end

  def reload
    @photos = Photo.find({}, {:sort => {:created_at => :desc}})
    if @photos.count == 0
      tutorial_frame = [[0, 0], [content_frame.size.width, content_frame.size.height-44]]
      @tutorial ||= TutorialView.alloc.initWithFrame(tutorial_frame)
      collectionView.addSubview(@tutorial)
    end
    collectionView.reloadData
  end

  def open_rubyfriends
    open_browser('http://rubyfriends.com')
  end

  def open_browser(url)
    browser = SVModalWebViewController.alloc.initWithAddress(url)
    browser.navigationBar.styleId = 'browser-navigation-bar'
    browser.toolbar.styleId = 'browser-toolbar'
    presentViewController(browser, animated:true, completion:lambda{})
  end

  def open_info
    controller = InfoController.new
    controller.delegate = self
    presentModalViewController(controller, animated:true)
  end

  def close_info(info)
    info.delegate = nil
    dismissModalViewControllerAnimated(true)
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

  private
  def take_picture
    BW::Device.camera.rear.picture({media_types: [:image]}, self) do |result|
      @image = result[:original_image]
      @image.saveToPhotosAlbum
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
        t.setInitialText(AppDelegate::HASHTAG + ' ')
        t.addImage(image)
        t.completionHandler = lambda {|result|
          dismissModalViewControllerAnimated(true)
        }
      end
      presentModalViewController(tweet_controller, animated:true)
    else
      App.alert('Posting twitter is not available.')
    end
  end
end