Pod::Spec.new do |spec|
  spec.name         = "Resources"
  spec.version      = "0.0.1"
  spec.summary      = "Resources"
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
  spec.resources = ["**/*.{xcassets,strings}"]
  spec.frameworks = "Foundation", "UIKit"
  spec.dependency 'R.swift'
  
  # RSwift
  
  generated_file_path = "Sources/R.generated.swift"
  spec.prepare_command =
  <<-CMD
  touch "#{generated_file_path}"
  CMD
  
  r_swift_script = '"${PODS_ROOT}/R.swift/rswift" generate --access-level public "${PODS_TARGET_SRCROOT}/Sources/R.generated.swift"'
  spec.script_phases = [
  {
    :name => 'R.swift',
    :script => r_swift_script,
    :execution_position => :before_compile,
    :input_files => ['$TEMP_DIR/rswift-lastrun'],
    :output_files => ['${PODS_TARGET_SRCROOT}/Sources/R.generated.swift']
  }
  ]
end
