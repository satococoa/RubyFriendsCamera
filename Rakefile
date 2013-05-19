# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'bundler/setup'
Bundler.require :default

require 'yaml'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'RubyFriendsCamera'
  app.version = '1.0.0'
  app.short_version = '1.0.0'
  app.deployment_target = '5.1'
  app.interface_orientations = [:portrait]
  app.prerendered_icon = true
  app.frameworks += [
    'Twitter',
    'Accelerate',
    'AssetsLibrary',
    'ImageIO',
    'MobileCoreServices',
    'QuartzCore',
    'CoreImage'
  ]
  app.weak_frameworks += [
    'Social'
  ]

  conf_file = './config.yml'
  if File.exists?(conf_file)
    config = YAML::load_file(conf_file)
    app.testflight.sdk        = 'vendor/TestFlightSDK'
    app.testflight.api_token  = config['testflight']['api_token']
    app.testflight.team_token = config['testflight']['team_token']
    app.testflight.notify     = true
    app.testflight.distribution_lists = config['testflight']['distribution_lists']
    app.pixate.user = config['pixate']['user']
    app.pixate.key  = config['pixate']['key']
    app.pixate.framework = 'vendor/PXEngine.framework'
    app.identifier = config['identifier']
    app.info_plist['CFBundleURLTypes'] = [
      { 'CFBundleURLName' => config['identifier'],
        'CFBundleURLSchemes' => ['ruby-friends-camera'] }
    ]

    env = ENV['ENV'] || 'development'
    app.codesign_certificate = config[env]['certificate']
    app.provisioning_profile = config[env]['provisioning']
  end

  app.pods do
    pod 'NanoStore', '~> 2.6.0'
    pod 'NYXImagesKit'
    pod 'NSData+MD5Digest'
    pod 'SVWebViewController'
    pod 'SVProgressHUD'
    pod 'PSTCollectionView'
  end
  app.libs << '-fobjc-arc'

  app.info_plist['UIRequiredDeviceCapabilities'] = [
    'still-camera'
  ]
  app.development do
    app.entitlements['get-task-allow']  = true
  end
  app.release do
    app.entitlements['get-task-allow']  = false
  end
end
