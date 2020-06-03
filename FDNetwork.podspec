
Pod::Spec.new do |spec|

  spec.name         = "FDNetwork"
  spec.version      = "0.1"
  spec.summary      = "FineDine Network"

  spec.description  = <<-DESC
FineDine Network library, written in Swift.
                   DESC

  spec.homepage     = "https://github.com/finedine/FDNetwork-iOS"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author    = { "FineDine" => "info@finedinemenu.com" }

  spec.ios.deployment_target = "9.0"
  spec.swift_version = "5.0"


  spec.source       = { :git => "https://github.com/finedine/FDNetwork-iOS.git", :tag => "#{spec.version}" }
  spec.source_files  = "FDNetwork", "FDNetwork/**/*.swift"

  spec.dependency "Alamofire", "4.9.1"

end
