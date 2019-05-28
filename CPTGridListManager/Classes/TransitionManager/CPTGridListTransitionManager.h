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

-(instancetype)initWithDuration:(NSTimeInterval)duration collectionView:(UICollectionView *)collectionView destinationLayout:(UICollectionViewLayout *)destinationLayout layoutState:(LayoutState)layoutState;
-(void)startInteractiveTransition;

@end
