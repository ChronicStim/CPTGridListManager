//
//  CPTGridListTransitionManager.h
//  CPTGridListTransitionManager
//
//  Created by Bob Kutschke on 5/19/19.
//  Copyright © 2019 Chronic Stimulation, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPTGridListLayout.h"

@interface CPTGridListTransitionManager : NSObject

/**
 Initializes and returns the Transition Manager that will oversee the layout animations.

 @param duration The overall duration of the animation in NSTimeInterval units.
 @param collectionView The UICollectionView object which is hosting the layouts.
 @param destinationLayout The CPTGridListLayout which you are animating into.
 @param layoutState LayoutState which the manager will be animating towards.
 @return Returns a CPTGridListTransitionManager that is ready to begin the interactive transition animation.
 */
-(instancetype)initWithDuration:(NSTimeInterval)duration collectionView:(UICollectionView *)collectionView destinationLayout:(CPTGridListLayout *)destinationLayout layoutState:(LayoutState)layoutState;

/**
 Begins the transition process from the current collectionView layout to the new layout based on the parameters provided in the initialization of the Transition Manager. This method should be called from your UIViewController in response to a TouchUpInside event on, or coincident with (see Main.storyboard of demo project for example), the CPTGridListAnimatedButton.
 */
-(void)startInteractiveTransition;

@end
