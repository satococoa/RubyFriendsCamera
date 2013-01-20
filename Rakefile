# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'
require 'bundler/setup'
Bundler.require :default

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'RubyFriendsCamera'
  app.frameworks += [
    'Social',
    'Accelerate',
    'AssetsLibrary',
    'ImageIO',
    'MobileCoreServices',
    'QuartzCore',
    'CoreImage'
  ]

  app.pods do
    pod 'NanoStore', '~> 2.5.3'
    pod 'NYXImagesKit', :podspec => 'NYXImagesKit.podspec'
    pod 'NSData+MD5Digest'
  end
end
