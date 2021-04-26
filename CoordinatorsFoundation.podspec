Pod::Spec.new do |s|
  s.name             = 'CoordinatorsFoundation'
  s.version          = '0.3.1'
  s.summary          = 'Base for Coordinators pattern in Swift'

  s.description      = <<-DESC
CoordinatorsFoundation makes easier to build your project using the coordinator pattern.
This is lightweight framework containing base for this pattern.
                       DESC

  s.homepage         = 'https://github.com/railwaymen/CoordinatorsFoundation'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Bartłomiej Świerad' => 'bartlomiej.swierad@railwaymen.org' }
  s.source           = { :git => 'https://github.com/railwaymen/CoordinatorsFoundation.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.4'
  s.source_files = 'Sources/**/*'
  s.frameworks = 'UIKit'
  s.swift_versions = '5.2'
end
