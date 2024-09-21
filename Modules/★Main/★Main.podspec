Pod::Spec.new do |spec|
  spec.name         = "★Main"
  spec.version      = "0.0.1"
  spec.summary      = "Main"
  spec.description  = <<-DESC
  Extensions module
                   DESC
  spec.homepage     = "https://google.com"
  spec.license      = "BSD"
  spec.author       = { "R Harhun" => "r.harhun@gmail.com" }
  spec.platform     = :ios, "15.0"
  spec.swift_version = "5.0"
  spec.source       = { :path => "." }
  spec.source_files  = "**/*.{h,m,swift}"

  spec.frameworks = "Foundation"

  spec.dependency "Core"
  spec.dependency "Models"
  spec.dependency "Extensions"
  spec.dependency "Resources"
  spec.dependency "Constants"
  spec.dependency "SnapKit"
  spec.dependency "UseCases"
end
