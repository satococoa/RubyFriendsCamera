class LoadableImageView < UIImageView
  attr_accessor :loading, :loading_view

  def initWithFrame(rect)
    super
    @loading = false
    @loading_view = UIActivityIndicatorView.alloc.initWithActivityIndicatorStyle(UIActivityIndicatorViewStyleWhite).tap do |lv|
      lv.color = UIColor.blackColor
    end
    self
  end

  def loading=(loading)
    if loading
      self.image = nil
      addSubview(@loading_view)
      @loading_view.startAnimating
    else
      @loading_view.stopAnimating
    end
  end

  def layoutSubviews
    super
    w = 30
    h = 30
    x = (self.frame.size.width/2.0 - w/2)
    y = (self.frame.size.height/2.0 - h/2)
    @loading_view.frame = [[x, y], [w, h]]
  end
end