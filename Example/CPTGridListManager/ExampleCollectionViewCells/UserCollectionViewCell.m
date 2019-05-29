//
//  UserCollectionViewCell.m
//  CPTGridListTransitionMangerExampleProject
//
//  Created by Bob Kutschke on 5/22/19.
//  Copyright © 2019 Chronic Stimulation, LLC. All rights reserved.
//

#import "UserCollectionViewCell.h"
#import "CellDataObject.h"
#import <CPTGridListManager/CPTGridListManager.h>

@interface UserCollectionViewCell ()
{
    CGFloat _avatarListLayoutSize;
    CGFloat _avatarGridLayoutSize;
    CGFloat _initialLabelsLeadingConstraintValue;
}

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UIView *backgroundGradientView;
@property (weak, nonatomic) IBOutlet UILabel *nameListLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameGridLabel;
@property (weak, nonatomic) IBOutlet UILabel *statisticLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarImageViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarImageViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameListLabelLeadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *statisticLabelLeadingConstraint;

@end

@implementation UserCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _avatarListLayoutSize = 80.0f;
    _avatarGridLayoutSize = 0.0f;
    
    _initialLabelsLeadingConstraintValue = self.nameListLabelLeadingConstraint.constant;
}

-(void)applyCellDataObjectContent:(CellDataObject *)cellDataObject;
{
    self.avatarImageView.image = [cellDataObject iconImage];
    self.nameListLabel.text = cellDataObject.listCellDisplayName;
    self.nameGridLabel.text = cellDataObject.gridCellDisplayName;
    self.statisticLabel.text = @"Just another line of text";
}

- (void)forLayoutMode:(LayoutState)layoutState setupCellLayoutConstraintsForTransitionProgress:(CGFloat)transitionProgress cellSize:(CGSize)cellSize {
    
    switch (layoutState) {
        case grid: {
            
            // @tp0 = 80    @tp1 = cellSize.width
            self.avatarImageViewHeightConstraint.constant = ceilf((cellSize.width - _avatarListLayoutSize) * transitionProgress + _avatarListLayoutSize);
            
            // @tp0 = 80    @tp1 = cellSize.width
            self.avatarImageViewWidthConstraint.constant = ceilf(self.avatarImageViewHeightConstraint.constant);
            
            // @tp0 = 95    @tp1 = (95-cellSize.width)
            self.nameListLabelLeadingConstraint.constant = -self.avatarImageViewWidthConstraint.constant * transitionProgress + _initialLabelsLeadingConstraintValue;
            
            // @tp0 = 95    @tp1 = (95-cellSize.width)
            self.statisticLabelLeadingConstraint.constant = self.nameListLabelLeadingConstraint.constant;
            
            // @tp0 = 1     @tp1 = 1    @tp0.5 = 0.5
            self.backgroundGradientView.alpha = (transitionProgress <= 0.5f) ? (1 - transitionProgress) : transitionProgress;
            
            // @tp0 = 1     @tp1 = 0
            self.nameListLabel.alpha = 1 - transitionProgress;

            // @tp0 = 1     @tp1 = 0
            self.statisticLabel.alpha = 1 - transitionProgress;

            // @tp0 = 0     @tp1 = 1
            self.nameGridLabel.alpha = transitionProgress;

        }   break;
        case list: {
            
            // @tp0 = 0     @tp1 = 80
            self.avatarImageViewHeightConstraint.constant = ceilf(_avatarGridLayoutSize - (_avatarGridLayoutSize - _avatarListLayoutSize) * transitionProgress);
            
            // @tp0 = 0     @tp1 = 80
            self.avatarImageViewWidthConstraint.constant = self.avatarImageViewHeightConstraint.constant;
            
            // @tp0 = 95    @tp1 = 95
            self.nameListLabelLeadingConstraint.constant = self.avatarImageViewWidthConstraint.constant * transitionProgress + (_initialLabelsLeadingConstraintValue - self.avatarImageViewHeightConstraint.constant);
            
            // @tp0 = 95    @tp1 = 95
            self.statisticLabelLeadingConstraint.constant = self.nameListLabelLeadingConstraint.constant;
            
            // @tp0 = 1     @tp1 = 1    @tp0.5 = 0.5
            self.backgroundGradientView.alpha = transitionProgress <= 0.5 ? (1 - transitionProgress) : transitionProgress;

            // @tp0 = 0     @tp1 = 1
            self.nameListLabel.alpha = transitionProgress;

            // @tp0 = 0     @tp1 = 1
            self.statisticLabel.alpha = transitionProgress;

            // @tp0 = 1     @tp1 = 0
            self.nameGridLabel.alpha = 1 - transitionProgress;

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
