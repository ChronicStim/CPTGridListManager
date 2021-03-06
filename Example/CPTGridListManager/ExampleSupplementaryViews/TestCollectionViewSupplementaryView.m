//
//  TestCollectionViewSupplementaryView.m
//  CPTGridListTransitionMangerExampleProject
//
//  Created by Bob Kutschke on 5/22/19.
//  Copyright © 2019 Chronic Stimulation, LLC. All rights reserved.
//

#import "TestCollectionViewSupplementaryView.h"
#import <CPTGridListManager/CPTGridListManager.h>

@interface TestCollectionViewSupplementaryView ()
{
    CGFloat _sectionHeaderHeightList;
    CGFloat _sectionHeaderHeightGrid;
    CGFloat _initialSectionHeaderHeightConstraintValue;
}

@property (weak, nonatomic) IBOutlet UIView *outerContainerView;
@property (weak, nonatomic) IBOutlet UILabel *sectionLabel;
@property (weak, nonatomic) IBOutlet UIView *indentedContainerView;
@property (weak, nonatomic) IBOutlet UIView *colorBackgroundView;
@property (weak, nonatomic) IBOutlet UIView *upperBorderStripeView;
@property (weak, nonatomic) IBOutlet UIView *lowerBorderStripeView;
@property (weak, nonatomic) IBOutlet UILabel *layoutStyleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *colorBackgroundViewHeightConstraint;

@end


@implementation TestCollectionViewSupplementaryView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _sectionHeaderHeightGrid = 35.0f;
    _sectionHeaderHeightList = 55.0f;
    
    _initialSectionHeaderHeightConstraintValue = self.colorBackgroundViewHeightConstraint.constant;
}

-(void)assignReusableViewKind:(NSString *)reusableViewKind sectionDetails:(NSDictionary *)sectionDetails;
{
    UIColor *stripeColor = [UIColor blackColor];
    if ([reusableViewKind isEqualToString:UICollectionElementKindSectionHeader]) {
        stripeColor = [UIColor blueColor];
    } else if ([reusableViewKind isEqualToString:UICollectionElementKindSectionFooter]) {
        stripeColor = [UIColor redColor];
    }
    self.upperBorderStripeView.backgroundColor = stripeColor;
    self.lowerBorderStripeView.backgroundColor = stripeColor;
    
    self.sectionLabel.text = sectionDetails[kTestCollectionViewSupplementaryViewSectionLabelText];
    self.layoutStyleLabel.text = sectionDetails[kTestCollectionViewSupplementaryViewLayoutStyleLabelText];
}

-(void)forLayoutMode:(LayoutState)layoutState setupReusableViewOfKind:(NSString *)kind layoutConstraintsForTransitionProgress:(CGFloat)transitionProgress reusableViewSize:(CGSize)reusableViewSize;
{
    switch (layoutState) {
        case grid: {
            
            self.colorBackgroundViewHeightConstraint.constant = ceilf((reusableViewSize.height - _sectionHeaderHeightList) * transitionProgress + _sectionHeaderHeightList);
            
            self.colorBackgroundView.alpha = (transitionProgress <= 0.5f) ? (1 - transitionProgress) : transitionProgress;

            if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
                self.sectionLabel.alpha = 1.0f - transitionProgress;
                self.layoutStyleLabel.alpha = 1.0f - transitionProgress;
            }
        }   break;
        case list: {
            
            self.colorBackgroundViewHeightConstraint.constant = ceilf(_sectionHeaderHeightGrid - (_sectionHeaderHeightGrid - _sectionHeaderHeightList) * transitionProgress);
            
            self.colorBackgroundView.alpha = transitionProgress <= 0.5 ? (1 - transitionProgress) : transitionProgress;

            self.sectionLabel.alpha = transitionProgress;
            self.layoutStyleLabel.alpha = transitionProgress;
        }   break;
    }
}

-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes;
{
    [super applyLayoutAttributes:layoutAttributes];
    
    if (nil != layoutAttributes && [layoutAttributes isKindOfClass:[CPTGridListLayoutAttributes class]]) {
        
        CPTGridListLayoutAttributes *attributes = (CPTGridListLayoutAttributes *)layoutAttributes;
        if (0 < attributes.transitionProgress) {
            
            [self forLayoutMode:attributes.layoutState setupReusableViewOfKind:attributes.representedElementKind layoutConstraintsForTransitionProgress:attributes.transitionProgress reusableViewSize:attributes.nextLayoutCellFrame.size];
        }
    }
}

@end
