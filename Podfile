post_install do |installer_representation|
  installer_representation.project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['CLANG_WARN_DIRECT_OBJC_ISA_USAGE'] = 'YES'
    end
  end
end

platform :ios, "7.0"
target "NCMBTodo" do
  pod 'NCMB-iOS-SDK', :podspec => 'https://gist.githubusercontent.com/moongift/b437832368e379528612/raw/71afc6a6766f57793c9f0bcd6f52991bcf86757d/NCMB.podspec'
end

target "NCMBTodoTests" do

end
