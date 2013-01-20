class Friend < NanoStore::Model
  attribute :image_path
  attribute :created_at

  def image
    @image ||= UIImage.imageWithContentsOfFile(self.image_path)
  end
end