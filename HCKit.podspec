#
#  Be sure to run `pod spec lint HCKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "HCKit"
  s.version      = "0.0.3"
  s.summary      = "A Kit for Hua Chen."

  s.description  = <<-DESC
                   A longer description of HCKit in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  s.homepage     = "https://github.com/huachen206/HCKit"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See http://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #

  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #

  s.author             = { "huachen206" => "huachen206@163.com" }
  # Or just: s.author    = "huachen206"
  # s.authors            = { "huachen206" => "huachen206@163.com" }
  # s.social_media_url   = "http://twitter.com/huachen206"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #

  # s.platform     = :ios
  # s.platform     = :ios, "5.0"

  #  When using multiple platforms
    s.ios.deployment_target = "6.1"
  # s.osx.deployment_target = "10.7"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  s.source       = { :git => "https://github.com/huachen206/HCKit.git", :tag => s.version,:submodules => true }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  s.source_files  = "HCKit/HCKit.h"
  #s.exclude_files = "HCKitDemo"

  s.public_header_files = "HCKit/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # s.resource  = "icon.png"
   s.resources = "HCKit/UIBarButtonItem+Extend.bundle"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  # s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"
	s.ios.dependency  'BlocksKit', '~> 2.2.3'


s.subspec "Utility" do |ss|
  	  ss.source_files = "HCKit/HCUtilityFuc.h","HCKit/HCUtilityMacro.h"
    	ss.ios.deployment_target = "6.0"


end


s.subspec "RequestApi" do |ss|
	ss.dependency "HCKit/Utility"
   	ss.source_files = "HCKit/HCBasicAsyncer.{h,m}", "HCKit/HCRequestBaseApi.{h,m}", "HCKit/HCHTTPRequest.{h,m}", "HCKit/Asyncing.h"

   	ss.ios.dependency  'AFNetworking', '~> 2.3.1'
	ss.ios.dependency  'libextobjc', '~> 0.4'
    ss.ios.deployment_target = "6.0"


end

s.subspec "CommonCategory" do |ss|
   	 ss.public_header_files = "HCKit/CommonCategory.h"

   	 ss.source_files = "HCKit/NSData+Extend.{h,m}","HCKit/NSDate+Extend.{h,m}","HCKit/NSDate+ServerTime.{h,m}","HCKit/NSObject+UserInfo.{h,m}","HCKit/NSString+Extend.{h,m}","HCKit/NSString+HXAddtions.{h,m}","HCKit/UIBarButtonItem+Extend.{h,m}","HCKit/UIDevice+Resolutions.{h,m}","HCKit/UIImage+Extend.{h,m}","HCKit/UIImage+ImageBlur.{h,m}","HCKit/NUILabel+Extend.{h,m}","HCKit/UITableView+Appearance.{h,m}","HCKit/UITextView+Appearance.{h,m}","HCKit/UIView+Extend.{h,m}"
end
s.subspec "HCSQLHelp" do |ss|
  	  ss.source_files = "HCKit/HCBaseDAO.*","HCKit/HCBaseDBHelper.*","HCKit/HCDBManager.*","HCKit/SQLBaseModel.*","HCKit/SQLHelper.*","HCKit/TestSQLBaseModel.*"
	ss.ios.dependency  'FMDB', '~> 2.3'
	ss.ios.dependency  'FMDBHelpers', '~> 0.0.7'

end
s.subspec "Classes" do |ss|
  	  ss.source_files = "HCKit/HCDiskCache.*","HCKit/HCProfileService.*","HCKit/PAUserDiskCache.*","HCKit/PALinkButton.*","HCKit/PAWebViewController.*","HCKit/PAImageProcessHelper.*"
end
s.subspec "BaseViewControllers" do |ss|
   	 ss.source_files = "HCKit/BABasicNavigationController.*","HCKit/BABasicTableViewController.*","HCKit/BABasicViewController.*"
    	ss.frameworks = "UIKit"
	ss.ios.dependency  'HTDelegateProxy', '~> 1.0.1'

end
s.subspec "HUDService" do |ss|
   	 ss.source_files = "HCKit/PABlockingHUD.*","HCKit/PABlockingHUDDelegate.*","HCKit/PABlockingStrokeHUD.*","HCKit/PAHUD.*","HCKit/PAHUDCommon.*","HCKit/PAHUDService.*","HCKit/PAPromptHUD.*","HCKit/PAPromptHUDDelegate.*","HCKit/PASVPromptHUD.*","HCKit/PAStrokeHUDView.*","HCKit/PAPathView.*"
    	ss.ios.dependency  'SVProgressHUD', '~> 1.0'
	ss.ios.dependency  'SIAlertView', '~> 1.3'
   	 ss.ios.deployment_target = "6.1"


end

end
