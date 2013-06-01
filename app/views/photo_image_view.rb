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
      double_tap = UITapGestureRecognizer.new.tap do |dtap|
        dtap.numberOfTapsRequired = 2
        dtap.addTarget(self, action:'double_tapped')
      end
      iv.addGestureRecognizer(double_tap)
      tap = UITapGestureRecognizer.new.tap do |tap|
        tap.addTarget(self, action:'tapped')
      end
      iv.addGestureRecognizer(tap)
    end
    self.addSubview(@image_view)

    self
  end

  def tapped
    App.notification_center.post('PhotoImageViewTapped')
  end

  def double_tapped
    App.notification_center.post('PhotoImageViewDoubleTapped')
  end

  def viewForZoomingInScrollView(scroll_view)
    @image_view
  end

  def image=(img)
    @image_view.image = img
  end

  def toggle_zoom
    if self.zoomScale < maximumZoomScale
      self.setZoomScale(maximumZoomScale, animated:true)
    else
      self.setZoomScale(minimumZoomScale, animated:true)
    end
  end

end