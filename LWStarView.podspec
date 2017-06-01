

Pod::Spec.new do |s|

  

  s.name         = "LWStarView"
  s.version      = "0.0.1"
  s.summary      = "This is a star rating control"
  s.description  = <<-DESC 
                  support decimal
                   DESC
  s.homepage     = "https://github.com/David408477192/LWStarView"
  s.license      = "MIT "
  s.platform     = :ios, "7.0"
  s.author             = { "LiWei" => "18092863291@163.com" }
  s.source       = { :git => "https://github.com/David408477192/LWStarView.git", :tag => s.version }
  s.source_files  = "LWStarView", "LWStarView/LWStarView/**/*.{h,m}"

end
