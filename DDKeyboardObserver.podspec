Pod::Spec.new do |s|
s.name     = 'DDKeyboardObserver'
s.version  = '0.1'
s.license  = 'MIT'
s.summary  = 'a fast kit handle the keyboard cover issue'
s.homepage = 'https://github.com/openboy2012/DDKeyboardObserver'
s.author   = { 'DeJohn Dong' => 'dongjia_9251@126.com' }
s.source   = { :git => 'https://github.com/openboy2012/DDKeyboardObserver.git',:tag=>s.version.to_s}
s.ios.deployment_target = '6.0'
s.public_header_files = 'DDKeyboardObserver/KeyboardObserver/*.h'
s.source_files = 'DDKeyboardObserver/KeyboardObserver/*.{h,m}'
s.requires_arc = true
end
