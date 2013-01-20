class PhotosController < UICollectionViewController
  def viewDidLoad
    super
    navigationItem.title = 'RubyFriends'
    collectionView.backgroundColor = UIColor.whiteColor # TODO: CSS で指定する
  end
end