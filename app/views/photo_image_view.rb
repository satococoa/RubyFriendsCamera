class PhotoImageView < UIScrollView
  attr_accessor :image_view

  def initWithFrame(frame)
    super
    @image_view = UIImageView.alloc.initWithFrame(frame)
    @image_view.contentMode = UIViewContentModeScaleAspectFit
    @image_view.userInteractionEnabled = true

    self.minimumZoomScale = 1.0
    self.maximumZoomScale = 4.0
    self.delegate = self
    self.image_view = @image_view
    self.addSubview(@image_view)

    self
  end

  def viewForZoomingInScrollView(scroll_view)
    image_view
  end

end