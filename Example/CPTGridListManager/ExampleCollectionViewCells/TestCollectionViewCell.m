//
//  TestCollectionViewCell.m
//  CPTGridListTransitionMangerExampleProject
//
//  Created by Bob Kutschke on 5/21/19.
//  Copyright © 2019 Chronic Stimulation, LLC. All rights reserved.
//

#import "TestCollectionViewCell.h"
#import "CellDataObject.h"
#import <CPTGridListManager/CPTGridListManager.h>

@interface TestCollectionViewCell ()
{
    CGFloat _initialListStackViewExtensionTrailingToTrailingEdgeDistanceInListState;
    CGFloat _initialGridStackViewHeightInListState;

    CGFloat _gridStackViewListModeLayoutHeightFactor;
    CGFloat _gridStackViewGridModeLayoutHeightFactor;
}
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *gridStackViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *listStackViewExtensionTrailingEdgeConstraint;
@property (weak, nonatomic) IBOutlet UIView *outerContainerView;
@property (weak, nonatomic) IBOutlet UIStackView *horizStackView;
@property (weak, nonatomic) IBOutlet UIView *iconStackSubView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIView *textStackSubView;
@property (weak, nonatomic) IBOutlet UIView *textBackgroundView;
@property (weak, nonatomic) IBOutlet UILabel *listTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *gridTextLabel;


@end

@implementation TestCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _gridStackViewListModeLayoutHeightFactor = 65.0f;
    _gridStackViewGridModeLayoutHeightFactor = 0.0f;
    
    _initialListStackViewExtensionTrailingToTrailingEdgeDistanceInListState = self.listStackViewExtensionTrailingEdgeConstraint.constant;
    _initialGridStackViewHeightInListState = self.gridStackViewHeightConstraint.constant;
}

-(void)applyCellDataObjectContent:(CellDataObject *)cellDataObject;
{
    self.iconImageView.image = [cellDataObject iconImage];
    self.listTextLabel.text = cellDataObject.listCellDisplayName;
    self.gridTextLabel.text = cellDataObject.gridCellDisplayName;
}

- (void)forLayoutMode:(LayoutState)layoutState setupCellLayoutConstraintsForTransitionProgress:(CGFloat)transitionProgress cellSize:(CGSize)cellSize {
    
    switch (layoutState) {
        case grid: {
            
            self.gridStackViewHeightConstraint.constant = cellSize.height;
            self.listStackViewExtensionTrailingEdgeConstraint.constant = ceilf((cellSize.width-self.gridStackViewHeightConstraint.constant)*(1.0f-transitionProgress));
            self.gridTextLabel.alpha = transitionProgress;

        }   break;
        case list: {
            
            self.gridStackViewHeightConstraint.constant = cellSize.height;
            self.listStackViewExtensionTrailingEdgeConstraint.constant = ceilf((cellSize.width-self.gridStackViewHeightConstraint.constant)*transitionProgress);
            self.gridTextLabel.alpha = 1 - transitionProgress;

        }   break;
    }
}

-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes;
{
    [super applyLayoutAttributes:layoutAttributes];
    
    if (nil != layoutAttributes && [layoutAttributes isKindOfClass:[CPTGridListLayoutAttributes class]]) {
        
        CPTGridListLayoutAttributes *attributes = (CPTGridListLayoutAttributes *)layoutAttributes;
        if (0 < attributes.transitionProgress) {
            
            [self forLayoutMode:attributes.layoutState setupCellLayoutConstraintsForTransitionProgress:attributes.transitionProgress cellSize:attributes.nextLayoutCellFrame.size];
        }
    }
}

@end
