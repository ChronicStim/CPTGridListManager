#
# Be sure to run `pod lib lint CPTGridListManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CPTGridListManager'
  s.version          = '0.1.2'
  s.summary          = 'Provides both List & Grid UICollectionViewLayouts AND ability to animate from one layout type to the other.'

  s.description      = 'There are many situations where you want to use a UICollectionView to display a set of data using alternating List and Grid format layouts. The List layout is like a traditional UITableView where each element is presented as a full width row, while the Grid layout displays multiple cell elements per row. The combination of these two layouts allows you to present data or options within a UI in either a verbose (List) or compact (Grid) format. The challenge has been to effectively manage the transition between these UICollectionViewLayouts. That is where CPTGridListManager comes in. This framework provides the necessary Grid & List layouts, Transition layout, and Transition Manager to enable a smooth animation between these two formats. It even provides an animated button that can be used to trigger the layout change. Supplementary views (section headers & footers) are also supported by the animation engine. CPTGridListManager is written in Objective-C and is based on the work of another project, DisplaySwitcher by Yalantis, which was written in Swift.'

  s.homepage         = 'https://github.com/ChronicStim/CPTGridListManager'
  s.screenshots      = 'http://d2n9hatzxce9g4.cloudfront.net/wp-content/uploads/DemoVideoFor_CPTGridListManager.gif?x87524'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = 'ChronicStim'
  s.source           = { :git => 'https://github.com/ChronicStim/CPTGridListManager.git', :tag => s.version.to_s }

  s.platform			= :ios
  s.ios.deployment_target = '8.0'

  s.source_files = 'CPTGridListManager/Classes/**/*'
  s.requires_arc     = true
  
end
