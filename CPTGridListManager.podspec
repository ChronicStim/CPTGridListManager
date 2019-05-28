#
# Be sure to run `pod lib lint CPTGridListManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CPTGridListManager'
  s.version          = '0.1.0'
  s.summary          = 'CPTGridListManager provides UICollectionViewLayouts for both List & Grid type display of cell data, AND the ability to animate the transition process from one layout type to the other. This framework is written in Objective-C and supports variable sizing UICollectionViews and UICollectionReusableViews in the layouts.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = 'There are many situations where you want to use a UICollectionView to display a set of data using alternating List and Grid format layouts. The List layout is like a traditional UITableView where each element is presented as a full width row, while the Grid layout displays multiple cell elements per row. The combination of these two layouts allows you to present data or options within a UI in either a verbose (List) or compact (Grid) format. The challenge has been to effectively manage the transition between these UICollectionViewLayouts. That is where CPTGridListManager comes in. This framework provides the necessary Grid & List layouts, Transition layout, and Transition Manager to enable a smooth animation between these two formats. It even provides an animated button that can be used to trigger the layout change. Supplementary views (section headers & footers) are also supported by the animation engine. CPTGridListManager is written in Objective-C and is based on the work of another project, DisplaySwitcher by Yalantis, which was written in Swift.'

  s.homepage         = 'https://github.com/support@chronicstimulation.com/CPTGridListManager'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'support@chronicstimulation.com' => 'support@chronicstimulation.com' }
  s.source           = { :git => 'https://github.com/support@chronicstimulation.com/CPTGridListManager.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'CPTGridListManager/Classes/**/*'
  
  # s.resource_bundles = {
  #   'CPTGridListManager' => ['CPTGridListManager/Assets/*.png']
  # }

  s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
