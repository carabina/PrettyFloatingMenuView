Pod::Spec.new do |s|
    s.name         = "PrettyFloatingMenuView"
    s.version      = "0.1"
    s.summary      = "A pretty example for multi buttons menu"
    s.description = <<-DESC
                    A pretty example for multi buttons menu written on swift
                    DESC
    s.homepage     = "https://github.com/nab0y4enko/PrettyFloatingMenuView"
    s.license      = "MIT"
    s.author              = { "Oleksii Naboichenko" => "nab0y4enko@gmail.com" }
    s.social_media_url    = "https://twitter.com/nab0y4enko"
    s.ios.deployment_target = '8.0'
    s.source          = { :git => "https://github.com/nab0y4enko/PrettyFloatingMenuView.git", :tag => "#{s.version}" }
    s.source_files    = "Sources/**/*.swift"
    s.frameworks      = "UIKit", "CoreGraphics", "QuartzCore"
    s.requires_arc    = true
    s.dependency 'PrettyExtensionsKit', '~> 0.1'
    s.dependency 'PrettyCircleView', '~> 0.1'
end
