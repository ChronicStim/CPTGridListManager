//
//  CPTGridListProtocols.h
//  CPTGridListManager
//
//  Created by Bob Kutschke on 5/24/19.
//  Copyright © 2019 Chronic Stimulation, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPTGridListLayout.h"

/**
 Protocol to be applied to UICollectionViewCell objects when used with CPTGridListManager. This protocol includes 1 mandatory method which is called whenever the cell needs to be displayed. This includes the animation phases, where it allows you to redefine the NSLayoutConstraints for your cells as the animation progresses by using the transitionProgress (floatValue from 0.0 - 1.0) to interpolate between the final List and Grid layout modes. See the demo project for examples of how this is used.
 */
@protocol CPTGridListUICollectionViewCell <NSObject>

/**
 Method is called whenever the cell needs to be displayed. This includes the animation phases, where it allows you to redefine the NSLayoutConstraints for your cells as the animation progresses by using the transitionProgress (floatValue from 0.0 - 1.0) to interpolate between the final List and Grid layout modes. See the demo project for examples of how this is used.

 @param layoutState LayoutState that the animation is progressing towards. In other words, the destination state.
 @param transitionProgress Current animation progress as a CGFloat value 0.0 to 1.0
 @param cellSize CGSize for the current cell. This size can then be used within the method to feed into the constraint calculations.
 */
-(void)forLayoutMode:(LayoutState)layoutState setupCellLayoutConstraintsForTransitionProgress:(CGFloat)transitionProgress cellSize:(CGSize)cellSize;

@end

/**
 Protocol to be applied to UICollectionReusableView objects when used with CPTGridListManager. This protocol includes 1 mandatory method which is called during the animation phases. It allows you to redefine the NSLayoutConstraints for your ReusableViews as the animation progresses by using the transitionProgress (floatValue from 0.0 - 1.0) to interpolate between the final List and Grid layout modes. See the demo project for examples of how this is used.
 */
@protocol CPTGridListUICollectionReusableView <NSObject>

/**
 Method is called whenever the ReusableView needs to be displayed. This includes the animation phases, where it allows you to redefine the NSLayoutConstraints for your ReusableViews as the animation progresses by using the transitionProgress (floatValue from 0.0 - 1.0) to interpolate between the final List and Grid layout modes. See the demo project for examples of how this is used.

 @param layoutState LayoutState that the animation is progressing towards. In other words, the destination state.
 @param kind Use this NSString parameter to indicate whether the view is a Header or Footer view.
@param transitionProgress Current animation progress as a CGFloat value 0.0 to 1.0
 @param reusableViewSize CGSize for the current ReusableView. This size can then be used within the method to feed into the constraint calculations.
 */
-(void)forLayoutMode:(LayoutState)layoutState setupReusableViewOfKind:(NSString *)kind layoutConstraintsForTransitionProgress:(CGFloat)transitionProgress reusableViewSize:(CGSize)reusableViewSize;

@end
