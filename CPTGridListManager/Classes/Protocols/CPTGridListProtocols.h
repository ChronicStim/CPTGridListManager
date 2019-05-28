//
//  CPTGridListProtocols.h
//  CPTGridListManager
//
//  Created by Bob Kutschke on 5/24/19.
//  Copyright © 2019 Chronic Stimulation, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPTGridListLayout.h"

@protocol CPTGridListUICollectionViewCell <NSObject>

-(void)forLayoutMode:(LayoutState)layoutState setupCellLayoutConstraintsForTransitionProgress:(CGFloat)transitionProgress cellSize:(CGSize)cellSize;

@end

@protocol CPTGridListUICollectionReusableView <NSObject>

-(void)forLayoutMode:(LayoutState)layoutState setupReusableViewLayoutConstraintsForTransitionProgress:(CGFloat)transitionProgress cellSize:(CGSize)cellSize;

@end
