class PhotoImageView < UIScrollView
  attr_accessor :image

  def initWithFrame(frame)
    super
    self.minimumZoomScale = 1.0
    self.maximumZoomScale = 4.0
    self.delegate = self

    @image_view = UIImageView.alloc.initWithFrame(frame).tap do |iv|
      iv.contentMode = UIViewContentModeScaleAspectFit
      iv.userInteractionEnabled = true
    end
    self.addSubview(@image_view)

    self
  end

  def viewForZoomingInScrollView(scroll_view)
    @image_view
  end

  def image=(img)
    @image_view.image = img
  end

end