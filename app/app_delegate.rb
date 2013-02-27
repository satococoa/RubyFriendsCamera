class AppDelegate
  HASHTAG = '#RubyFriends'

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    NanoStore.shared_store = NanoStore.store(:file, App.documents_path + '/nano.db')

    @window = UIWindow.alloc.initWithFrame(App.bounds)
    photos_controller = PhotosController.alloc.initWithCollectionViewLayout(UICollectionViewFlowLayout.new)
    navigation_controller = UINavigationController.alloc.initWithRootViewController(photos_controller)
    @window.rootViewController = navigation_controller
    @window.makeKeyAndVisible

    true
  end
end
