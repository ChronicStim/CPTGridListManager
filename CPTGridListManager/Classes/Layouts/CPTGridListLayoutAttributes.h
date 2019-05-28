//
//  CPTGridListLayoutAttributes.h
//  CPTGridListTransitionManager
//
//  Created by Bob Kutschke on 5/19/19.
//  Copyright © 2019 Chronic Stimulation, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPTGridListLayout.h"

@interface CPTGridListLayoutAttributes : UICollectionViewLayoutAttributes

/**
 Animation progress from previous LayoutState to the next LayoutState. Ranges from 0.0 to 1.0.
 */
@property (nonatomic, assign) CGFloat transitionProgress;

/**
 The frame rectangle for the item under the next LayoutState definition
 */
@property (nonatomic, assign) CGRect nextLayoutCellFrame;

/**
 The current LayoutState of the element. Currently two states are supported: list, grid
 */
@property (nonatomic, assign) LayoutState layoutState;

@end
