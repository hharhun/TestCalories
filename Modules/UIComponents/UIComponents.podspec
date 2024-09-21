Pod::Spec.new do |spec|
  spec.name         = "UIComponents"
  spec.version      = "0.0.1"
  spec.summary      = "UIComponents"
  spec.description  = <<-DESC
  Design module
                   DESC
  spec.homepage     = "https://google.com"
  spec.license      = "BSD"
  spec.author       = { "R Harhun" => "r.harhun@gmail.com" }
  spec.platform     = :ios, "15.0"
  spec.swift_version = "5.0"
  spec.source       = { :path => "." }
  spec.source_files  = "**/*.{h,m,swift}"

  spec.frameworks = "Foundation"

  spec.dependency "Models"
  spec.dependency "Extensions"
  spec.dependency "Resources"
  spec.dependency "SnapKit"
  spec.dependency "Constants"
  spec.dependency "SnapKit"
  spec.dependency "NVActivityIndicatorView"
end
