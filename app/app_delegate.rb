class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(App.bounds)
    photos_controller = PhotosController.alloc.initWithCollectionViewLayout(PhotosLayout.new)
    navigation_controller = UINavigationController.alloc.initWithRootViewController(photos_controller)
    @window.rootViewController = navigation_controller
    @window.makeKeyAndVisible
    true
  end
end
