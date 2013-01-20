class PhotosLayout < UICollectionViewFlowLayout
  def prepareLayout
    self.itemSize = CGSizeMake(128, 128)
    self.minimumLineSpacing = 20
    self.minimumInteritemSpacing = 20
  end
end