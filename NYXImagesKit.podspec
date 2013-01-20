Pod::Spec.new do |s|
  s.name     = 'NYXImagesKit'
  s.version  = '2.1.3'
  s.platform = :ios
  s.license  = 'Simplified BSD license'
  s.summary  = 'A set of efficient categories for UIImage class. It allows filtering, resizing, masking, rotating, enhancing... and more.'
  s.homepage = 'https://github.com/Nyx0uf/NYXImagesKit'
  s.author   = 'Benjamin Godard'
  s.source   = { :git => 'https://github.com/Nyx0uf/NYXImagesKit.git', :ref => '68e3e85b9812d6dcd16b8f6d683a2e3089b8037f' }
  s.source_files = 'Categories', 'Classes', 'Helper'
  s.frameworks = 'Accelerate', 'AssetsLibrary', 'ImageIO', 'MobileCoreServices', 'QuartzCore', 'CoreImage'
  s.requires_arc = true
end
