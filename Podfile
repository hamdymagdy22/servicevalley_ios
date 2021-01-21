# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
source 'https://github.com/CocoaPods/Specs.git'
target 'Service Valley' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

pod 'ImageSlideshow', '~> 1.6'
pod 'GoogleMaps'
pod 'GooglePlaces'
pod "GooglePlacesSearchController"
pod 'GooglePlacePicker'
pod 'Alamofire'
pod 'SwiftyJSON'
pod 'Cosmos', '~> 17.0'
pod 'KImageView'
pod 'FBSDKLoginKit'
pod 'Alamofire'
pod 'SwiftyJSON'
pod 'PasswordTextField'
pod 'FacebookCore'
pod 'FacebookLogin'
pod 'FacebookShare'
pod'Firebase'
pod 'Firebase/Core'
pod 'Firebase/Auth'
pod 'LZViewPager', '~> 1.1.0'
pod "SBCardPopup"

pod 'GoogleSignIn'
    pod 'iOSDropDown'
pod "ImageSlideshow/AFURL"
pod 'AsyncTimer', '~> 2.2'
pod 'SDWebImage'

 pod 'OneSignal', '>= 2.6.2', '< 3.0'


end

  target 'OneSignalNotificationServiceExtension' do
 # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  pod 'OneSignal', '>= 2.6.2', '< 3.0'

end

post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
end

