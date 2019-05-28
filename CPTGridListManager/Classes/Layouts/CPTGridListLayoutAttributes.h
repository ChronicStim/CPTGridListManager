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

@property (nonatomic, assign) CGFloat transitionProgress;
@property (nonatomic, assign) CGRect nextLayoutCellFrame;
@property (nonatomic, assign) LayoutState layoutState;

@end
