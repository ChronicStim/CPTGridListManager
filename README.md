# CPTGridListManager

[![CI Status](https://img.shields.io/travis/support@chronicstimulation.com/CPTGridListManager.svg?style=flat)](https://travis-ci.org/support@chronicstimulation.com/CPTGridListManager)
[![Version](https://img.shields.io/cocoapods/v/CPTGridListManager.svg?style=flat)](https://cocoapods.org/pods/CPTGridListManager)
[![License](https://img.shields.io/cocoapods/l/CPTGridListManager.svg?style=flat)](https://cocoapods.org/pods/CPTGridListManager)
[![Platform](https://img.shields.io/cocoapods/p/CPTGridListManager.svg?style=flat)](https://cocoapods.org/pods/CPTGridListManager)

In iOS programming, there are situations where you want to display a set of data using alternating List and Grid format layouts. The List layout is like a traditional UITableView where each element is presented as a full width row, while the Grid layout displays multiple cell elements per row using the common UICollectionView style. The combination of these two display types lets you present data or options within a UI in a verbose (List) or compact (Grid) format. The challenge has been to effectively manage the transition between these display styles. 

That is where CPTGridListManager comes in. This framework provides custom UICollectionViewLayout Grid & List style layouts, UICollectionViewTransitionLayout, and a CPTGridListTransitionManager to enable smooth animation switching between these two formats. 

![Screenshot]
(http://d2n9hatzxce9g4.cloudfront.net/wp-content/uploads/DemoVideoFor_CPTGridListManager.gif?x87524)

The framework even provides an animated button that can be used to trigger the layout change animation. Supplementary views (section headers & footers) are also supported by the animation engine. 

CPTGridListManager is written in Objective-C and builds on the work of another project, [DisplaySwitcher by Yalantis](https://github.com/Yalantis/DisplaySwitcher), which was written in Swift.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

* iOS 8.0+
* Xcode 10+
* Obj-C

## Installation

CPTGridListManager is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
use_frameworks!
pod 'CPTGridListManager'
```

## Usage

### Import CPTGridListManager

```ruby
#import <CPTGridListManager/CPTGridListManager.h>
```

### CPTGridListLayout Classes

Within the UIViewController that is managing your UICollectionView, create two layouts (one for Grid, one for List format). See the included demo project for information regarding the usage of the initialization parameters for the CPTGridListLayout class.

```ruby
    _gridLayout = [[CPTGridListLayout alloc] initCPTGridListLayoutWithActiveLayoutStaticCellHeight:_gridLayoutStaticCellHeight nextLayoutStaticCellHeight:_listLayoutStaticCellHeight layoutState:grid cellPadding:CGPointMake(2, 2) gridLayoutCountOfColumns:5 desiredGridCellWtoHAspectRatio:1.0f];

    _listLayout = [[CPTGridListLayout alloc] initCPTGridListLayoutWithActiveLayoutStaticCellHeight:_listLayoutStaticCellHeight nextLayoutStaticCellHeight:_gridLayoutStaticCellHeight layoutState:list cellPadding:CGPointMake(2, 2) gridLayoutCountOfColumns:1 desiredGridCellWtoHAspectRatio:0.0f];
```

Inform the UICollectionView which layout should be used as the initial active layout

```ruby
    self.layoutState = list;
    self.collectionView.collectionViewLayout = self.listLayout;
```

### CPTGridListTransitionManager Class

The transition manager class will drive the seamless animation between your two layouts. You define the manager in your UIViewController in response to a User driven event (e.g. button tap) or system trigger. The manager needs to be initialized and then you can begin the animation.

```ruby
-(IBAction)buttonTapped:(id)sender;
{
    if (!self.isTransitionAvailable) {
        return;
    }
    
    CPTGridListTransitionManager *transitionManager = nil;
    LayoutState previousState = self.layoutState; // which will also be the nextLayoutState for the animatedButton
    
    switch (self.layoutState) {
        case list: {
            
            self.layoutState = grid;
            transitionManager = [[CPTGridListTransitionManager alloc] initWithDuration:_animationDuration collectionView:self.collectionView destinationLayout:self.gridLayout layoutState:self.layoutState];
        }   break;
        case grid: {
            
            self.layoutState = list;
            transitionManager = [[CPTGridListTransitionManager alloc] initWithDuration:_animationDuration collectionView:self.collectionView destinationLayout:self.listLayout layoutState:self.layoutState];
        }   break;
        default:
            break;
    }
    
    if (transitionManager) {
        
        [transitionManager startInteractiveTransition];
        [self.rotationButton buttonSelectedDisplayNextLayoutState:previousState animate:YES];
    }
}
```

The isTransitionAvailable BOOL flag in the above code is defined to avoid triggering the transition process while the user is actively dragging the collectionView. However, the transition will animate just fine while the collectionView is actively scrolling/decelerating. You can control the flag state with the code below in your UIViewController.

```ruby
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
{
    _isTransitionAvailable = NO;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
{
    _isTransitionAvailable = YES;
}

```

### CPTGridListTransitionLayout Class

A transition layout is used by the transition manager during the animation process to present the interim state of the collectionView. You need to override the following UICollectionViewDelegate method:

```ruby
-(UICollectionViewTransitionLayout *)collectionView:(UICollectionView *)collectionView transitionLayoutForOldLayout:(UICollectionViewLayout *)fromLayout newLayout:(UICollectionViewLayout *)toLayout;
{
    CPTGridListTransitionLayout *customTransitionLayout = [[CPTGridListTransitionLayout alloc] initWithCurrentLayout:fromLayout nextLayout:toLayout];
    return customTransitionLayout;
}

```

### CPTGridListAnimatedButton Class

You can use this class to create a UIButton or UIBarButtonItem with an animated state indicator linked to the collectionView animation. Place the button within the viewController's storyboard or xib file and link it to an IBOutlet in the UIViewController subclass. The class is IBInspectable for the lineColor property, so you can set that inside IB if you wish.

In the demo project, the animated button has been added to a UIBarButtonItem view with constraints to maintain a 1:1 aspect ratio to ensure the icon animation works as intended.

You can see the call to the rotationButton in the -(IBAction)buttonTapped:(id)sender; method above. This call triggers the button to update its icon to the next available layout state.

### CPTGridListProtocols.h for UICollectionViewCells & UICollectionReusableViews

The protocol header includes two protocols (one for cells, one for reusable views), each with a single method. The methods are called whenever the elements needs to be displayed. This includes during the animation phases, where you can redefine the NSLayoutConstraints for the element as the animation progresses by using the transitionProgress (floatValue from 0.0 - 1.0) to interpolate between the final List and Grid layout modes. See the demo project for examples of how this is used. 


## Author

[ChronicStim](https://github.com/ChronicStim/CPTGridListManager), <support@chronicstimulation.com>

## License

The MIT License (MIT)

Copyright (c) 2019 ChronicStim

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
