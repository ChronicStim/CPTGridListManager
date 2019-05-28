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
@property (nonatomic, assign) CGPoint cellPadding;
@property (nonatomic, assign) CGFloat activeLayoutStaticCellHeight;
@property (nonatomic, assign) CGFloat nextLayoutStaticCellHeight;
@property (nonatomic, assign) CGPoint supplementaryViewPadding;
@property (nonatomic, assign) CGFloat activeLayoutStaticHeaderHeight;
@property (nonatomic, assign) CGFloat nextLayoutStaticHeaderHeight;
@property (nonatomic, assign) CGFloat activeLayoutStaticFooterHeight;
@property (nonatomic, assign) CGFloat nextLayoutStaticFooterHeight;
@property (nonatomic, assign) NSUInteger gridLayoutCountOfColumns;
@property (nonatomic, assign) CGFloat desiredGridCellAspectRatio;

/**
 Initialize a new CPTGridListLayout. You will need to generate two of these objects: one for List mode, and one for Grid mode. The method requires inputs for the target layout heights for the various elements of the collectionView display. These will be used in the construction of the Grid and List layouts. The staticCellHeights are used for sizing purposes in calculating layouts. For a grid layout, you can specify the desired number of columns, and when doing so, you can also specify a desiredGridCellAspectRatio. This ratio will be used to determine if the staticCellHeight that was provided needs to be adjusted so that it fits within the max column width. See the demo project for an example of this.
 
 @param activeLayoutStaticCellHeight Static height for Cell in active layout mode
 @param nextLayoutStaticCellHeight Static height for cell in the inactive layout mode
 @param layoutState The current LayoutState for the layout. Current options: grid, list
 @param cellPadding CGPoint indicating the padding around the elements in the collectionView
 @param countOfColumns Number of columns of Cells to be displayed in Grid LayoutState
 @param desiredGridCellAspectRatio The aspectRatio for the Grid Cell. Specify 0.0 if you do not want the aspectRatio calculation to be made
 @return Returns a CPTGridListLayout object.
 */
-(instancetype)initCPTGridListLayoutWithActiveLayoutStaticCellHeight:(CGFloat)activeLayoutStaticCellHeight nextLayoutStaticCellHeight:(CGFloat)nextLayoutStaticCellHeight layoutState:(LayoutState)layoutState cellPadding:(CGPoint)cellPadding gridLayoutCountOfColumns:(NSUInteger)countOfColumns desiredGridCellWtoHAspectRatio:(CGFloat)desiredGridCellAspectRatio;

/**
 Initialize a new CPTGridListLayout. You will need to generate two of these objects: one for List mode, and one for Grid mode. The method requires inputs for the target layout heights for the various elements of the collectionView display. These will be used in the construction of the Grid and List layouts. You may find that using targeted cell heights in this manner is more efficient. You can see an example of this approach in the demo project.

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

@end
