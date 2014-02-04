Pod::Spec.new do |s|
  s.name         = "FTAdditions"
  s.version      = "0.1.0"
  s.summary      = "A set of useful categories, classes, and macros for iOS development."
  s.homepage     = "https://github.com/kharmabum/FTAdditions"
  s.license      = "MIT"
  s.author       = { "Juan-Carlos Foust" => "jc@fototropik.com" }
  s.source       = { :git => "https://github.com/kharmabum/FTAdditions.git", :tag => "0.1.0" }
  s.platform     = :ios, "7.0"
  s.source_files = "*.{h,m}", "Categories/*.{h,m}", "Vendor/*.{h,m}", "Util/*.{h,m}"
  s.frameworks   = "UIKit", "CoreGraphics", "QuartzCORE"
  s.requires_arc = true
  s.dependency 'MBProgressHUD'
end
