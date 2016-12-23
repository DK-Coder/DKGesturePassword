Pod::Spec.new do |s|

  s.name         = "DKGesturePassword"
  s.version      = "1.0"
  s.summary      = "手势密码"
  s.homepage     = "https://github.com/DK-Coder/DKGesturePassword"

  s.license      = "MIT"

  s.author       = { "DK-Coder" => "kb01020304@qq.com" }

  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/DK-Coder/DKGesturePassword.git", :tag => "#{s.version}" }

  s.source_files  = "DKGesturePassword/DKGesturePasswordView/*"

  # s.resource  = "icon.png"
  # s.resources = "Resources.bundle/*.png"

  s.requires_arc = true

end
