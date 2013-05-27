module Share
  @@service_types = {
    twitter: SLServiceTypeTwitter,
    facebook: SLServiceTypeFacebook
  }

  def tweet_available?
    if defined?(SLComposeViewController)
      SLComposeViewController.isAvailableForServiceType(@@service_types[:twitter])
    else
      TWTweetComposeViewController.canSendTweet
    end
  end

  def facebook_available?
    return false unless defined?(SLComposeViewController)
    SLComposeViewController.isAvailableForServiceType(@@service_types[:facebook])
  end

  def share_controller(service_type, &block)
    if defined?(SLComposeViewController)
      block.call(SLComposeViewController.composeViewControllerForServiceType(@@service_types[service_type]))
    elsif service_type == :twitter
      block.call(TWTweetComposeViewController.new)
    end
  end
end