class AppDelegate
  HASHTAG = '#RubyFriends'

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    NanoStore.shared_store = NanoStore.store(:file, App.documents_path + '/nano.db')

    @window = UIWindow.alloc.initWithFrame(App.bounds)
    photos_controller = PhotosController.alloc.initWithCollectionViewLayout(PhotosLayout.new)
    navigation_controller = UINavigationController.alloc.initWithRootViewController(photos_controller).tap do |nav|
      nav.navigationBar.tintColor = '#9F1D2F'.to_color
      nav.toolbar.tintColor = '#9F1D2F'.to_color
    end
    @window.rootViewController = navigation_controller
    @window.makeKeyAndVisible

    true
  end
end
