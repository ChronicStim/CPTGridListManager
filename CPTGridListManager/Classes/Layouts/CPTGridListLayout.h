//
//  CPTGridListLayout.h
//  CPTGridListTransitionManager
//
//  Created by Bob Kutschke on 5/19/19.
//  Copyright © 2019 Chronic Stimulation, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    list,
    grid
} LayoutState;

@interface CPTGridListLayout : UICollectionViewLayout

@property (nonatomic, assign) LayoutState layoutState;

/**
 Initialize a new CPTGridListLayout.

 @param layoutState Define the mode of the layout (grid or list)
 @param activeLayoutStaticHeaderHeight Static height for Header in active layout mode
 @param activeLayoutStaticCellHeight Static height for Cell in active layout mode
 @param activeLayoutStaticFooterHeight Static height for Footer in active layout mode
 @param nextLayoutStaticHeaderHeight Static height for Header in Inactive layout mode
 @param nextLayoutStaticCellHeight Static height for Cell in Inactive layout mode
 @param nextLayoutStaticFooterHeight Static height for Footer in Inactive layout mode
 @return Initialized CPTGridListLayout
 */
-(instancetype)initCPTGridListLayoutWithState:(LayoutState)layoutState
               activeLayoutStaticHeaderHeight:(CGFloat)activeLayoutStaticHeaderHeight
                 activeLayoutStaticCellHeight:(CGFloat)activeLayoutStaticCellHeight
               activeLayoutStaticFooterHeight:(CGFloat)activeLayoutStaticFooterHeight
                 nextLayoutStaticHeaderHeight:(CGFloat)nextLayoutStaticHeaderHeight
                   nextLayoutStaticCellHeight:(CGFloat)nextLayoutStaticCellHeight
                 nextLayoutStaticFooterHeight:(CGFloat)nextLayoutStaticFooterHeight;

-(instancetype)initCPTGridListLayoutWithActiveLayoutStaticCellHeight:(CGFloat)activeLayoutStaticCellHeight nextLayoutStaticCellHeight:(CGFloat)nextLayoutStaticCellHeight layoutState:(LayoutState)layoutState;
-(instancetype)initCPTGridListLayoutWithActiveLayoutStaticCellHeight:(CGFloat)activeLayoutStaticCellHeight nextLayoutStaticCellHeight:(CGFloat)nextLayoutStaticCellHeight layoutState:(LayoutState)layoutState cellPadding:(CGPoint)cellPadding gridLayoutCountOfColumns:(NSUInteger)countOfColumns;

@end
