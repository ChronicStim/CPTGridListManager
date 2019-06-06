//
//  CPTGridListTransitionLayout.m
//  CPTGridListTransitionManager
//
//  Created by Bob Kutschke on 5/19/19.
//  Copyright © 2019 Chronic Stimulation, LLC. All rights reserved.
//

#import "CPTGridListTransitionLayout.h"
#import "CPTGridListLayout.h"
#import "CPTGridListLayoutAttributes.h"

@interface CPTGridListTransitionLayout ()


@end

@implementation CPTGridListTransitionLayout

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect;
{
    NSArray *activeAttributes = [super layoutAttributesForElementsInRect:rect];
    [self setupNextLayoutWithActiveAttributes:activeAttributes inRect:rect];
    
    return activeAttributes;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    if (nil != attributes && [attributes isMemberOfClass:[CPTGridListLayoutAttributes class]]) {
        
        CPTGridListLayoutAttributes *layoutAttributes = (CPTGridListLayoutAttributes *)attributes;
        layoutAttributes.transitionProgress = self.transitionProgress;
        layoutAttributes.layoutState = self.layoutState;
        
        UICollectionViewLayoutAttributes *nextLayoutAttributes = [self.nextLayout layoutAttributesForItemAtIndexPath:indexPath];
        if (nil != nextLayoutAttributes && [nextLayoutAttributes isMemberOfClass:[CPTGridListLayoutAttributes class]]) {
            layoutAttributes.nextLayoutCellFrame = nextLayoutAttributes.frame;
        }
    }
    return attributes;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath;
{
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForSupplementaryViewOfKind:elementKind atIndexPath:indexPath];
    if (nil != attributes && [attributes isMemberOfClass:[CPTGridListLayoutAttributes class]]) {
        
        CPTGridListLayoutAttributes *layoutAttributes = (CPTGridListLayoutAttributes *)attributes;
        layoutAttributes.transitionProgress = self.transitionProgress;
        layoutAttributes.layoutState = self.layoutState;
        
        UICollectionViewLayoutAttributes *nextLayoutAttributes = [self.nextLayout layoutAttributesForSupplementaryViewOfKind:elementKind atIndexPath:indexPath];
        if (nil != nextLayoutAttributes && [nextLayoutAttributes isMemberOfClass:[CPTGridListLayoutAttributes class]]) {
            layoutAttributes.nextLayoutCellFrame = nextLayoutAttributes.frame;
        }
    }
    return attributes;
}

-(void)setupNextLayoutWithActiveAttributes:(NSArray *)activeAttributes inRect:(CGRect)rect;
{
    NSArray *nextAttributes = [self.nextLayout layoutAttributesForElementsInRect:rect];
    NSInteger index = 0;
    for (UICollectionViewLayoutAttributes *activeLayoutAttributes in activeAttributes) {
        
        if ([activeLayoutAttributes isMemberOfClass:[CPTGridListLayoutAttributes class]]) {
            
            CPTGridListLayoutAttributes *activeLayoutAttributesGridList = (CPTGridListLayoutAttributes *)activeLayoutAttributes;
            activeLayoutAttributesGridList.transitionProgress = self.transitionProgress;
            activeLayoutAttributesGridList.layoutState = self.layoutState;
            
            if (nil != nextAttributes && index < [nextAttributes count]) {
                
                UICollectionViewLayoutAttributes *nextLayoutAttributes = nextAttributes[index];
                if (nil != nextLayoutAttributes && [nextLayoutAttributes isMemberOfClass:[CPTGridListLayoutAttributes class]]) {
                    activeLayoutAttributesGridList.nextLayoutCellFrame = nextLayoutAttributes.frame;
                }
            }
        }
        index++;
    }
}

@end
