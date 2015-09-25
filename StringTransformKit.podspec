Pod::Spec.new do |s|
  s.name                      = 'StringTransformKit'
  s.version                   = '0.1.2'
  s.source                    = { :git => 'https://github.com/hoppenichu/StringTransformKit.git', :tag => s.version }

  s.summary                   = 'String Transformation Extensions'
  s.homepage                  = 'https://github.com/hoppenichu/StringTransformKit'
  s.license                   = { :type => 'MIT', :file => 'LICENSE' }
  s.author                    = { 'Takeru Chuganji' => 'takeru@hoppenichu.com' }

  s.ios.deployment_target     = '8.0'
  s.osx.deployment_target     = '10.10'
  s.watchos.deployment_target = '2.0'
  s.requires_arc              = true
  s.source_files              = 'StringTransformKit/*.swift'
end
