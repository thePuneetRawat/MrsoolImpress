Pod::Spec.new do |s|

  s.name         = "MrsoolImpress"
  s.version      = "1.0.0"
  s.summary      = "A tool to analyze impression events for UIView in iOS (exposure of UIView)."

  s.description  = <<-DESC
  					This is a library to analyze impression events for UIView in iOS (exposure of UIView).
                   DESC

  s.homepage     = "https://github.com/thePuneetRawat/MrsoolImpress"

  s.license      = "MIT"

  s.author       = { "Puneet Rawat" => "rawat.puneet91@gmail.com" }

  s.platform     = :ios, "11.0"
  
  s.swift_versions = "5"

  s.source       = { :git => "https://github.com/thePuneetRawat/MrsoolImpress.git", :tag => "#{s.version}" }

  s.source_files  = "ImpressionKit/**/*.{swift}"

  s.dependency "EasySwiftHook", "~> 3.3"

end
