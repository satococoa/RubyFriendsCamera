Pod::Spec.new do |s|
  s.name     = 'NYXImagesKit'
  s.version  = '2.1.3'
  s.platform = :ios
  s.license  = 'Simplified BSD license'
  s.summary  = 'A set of efficient categories for UIImage class. It allows filtering, resizing, masking, rotating, enhancing... and more.'
  s.homepage = 'https://github.com/Nyx0uf/NYXImagesKit'
  s.author   = 'Benjamin Godard'
  s.source   = { :git => 'https://github.com/Nyx0uf/NYXImagesKit.git', :ref => 'a210a18c9d179ed91e0d5ff99b3520fc45a838d4' }
  s.source_files = 'Categories', 'Classes', 'Helper'
  s.frameworks = 'Accelerate', 'AssetsLibrary', 'ImageIO', 'MobileCoreServices', 'QuartzCore', 'CoreImage'
  s.requires_arc = true
end
