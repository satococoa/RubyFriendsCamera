class PhotosLayout < UICollectionViewFlowLayout
  def prepareLayout
    self.itemSize = CGSizeMake(128, 128)
    self.minimumLineSpacing = 20
    self.minimumInteritemSpacing = 20
    self.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20)
  end
end