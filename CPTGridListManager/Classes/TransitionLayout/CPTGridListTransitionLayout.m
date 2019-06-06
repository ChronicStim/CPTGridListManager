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
    
    if (nil != nextAttributes) {

        for (UICollectionViewLayoutAttributes *activeLayoutAttributes in activeAttributes) {
            
            switch (activeLayoutAttributes.representedElementCategory) {
                case UICollectionElementCategoryCell: {
                    
                    if ([activeLayoutAttributes isMemberOfClass:[CPTGridListLayoutAttributes class]]) {
                        
                        CPTGridListLayoutAttributes *activeLayoutAttributesGridList = (CPTGridListLayoutAttributes *)activeLayoutAttributes;
                        activeLayoutAttributesGridList.transitionProgress = self.transitionProgress;
                        activeLayoutAttributesGridList.layoutState = self.layoutState;
                        
                        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
                            
                            return (NSOrderedSame == [activeLayoutAttributesGridList.indexPath compare:[(CPTGridListLayoutAttributes *)evaluatedObject indexPath]]);
                        }];
                        
                        NSArray *matchingNextLayoutAttributes = [nextAttributes filteredArrayUsingPredicate:predicate];
                        if ([matchingNextLayoutAttributes count]) {
                            
                            UICollectionViewLayoutAttributes *nextLayoutAttributes = matchingNextLayoutAttributes[0];
                            if (nil != nextLayoutAttributes && [nextLayoutAttributes isMemberOfClass:[CPTGridListLayoutAttributes class]]) {
                                activeLayoutAttributesGridList.nextLayoutCellFrame = nextLayoutAttributes.frame;
                            }
                        }
                    }
                }   break;
                case UICollectionElementCategorySupplementaryView: {
                    
                    if ([activeLayoutAttributes isMemberOfClass:[CPTGridListLayoutAttributes class]]) {
                        
                        CPTGridListLayoutAttributes *activeLayoutAttributesGridList = (CPTGridListLayoutAttributes *)activeLayoutAttributes;
                        activeLayoutAttributesGridList.transitionProgress = self.transitionProgress;
                        activeLayoutAttributesGridList.layoutState = self.layoutState;
                        
                        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
                            
                            BOOL matchingKind = [activeLayoutAttributesGridList.representedElementKind isEqualToString:[(CPTGridListLayoutAttributes *)evaluatedObject representedElementKind]];
                            BOOL matchingSection = (activeLayoutAttributesGridList.indexPath.section == [(CPTGridListLayoutAttributes *)evaluatedObject indexPath].section);
                            return (matchingKind && matchingSection);
                        }];
                        
                        NSArray *matchingNextLayoutAttributes = [nextAttributes filteredArrayUsingPredicate:predicate];
                        if ([matchingNextLayoutAttributes count]) {
                            
                            UICollectionViewLayoutAttributes *nextLayoutAttributes = matchingNextLayoutAttributes[0];
                            if (nil != nextLayoutAttributes && [nextLayoutAttributes isMemberOfClass:[CPTGridListLayoutAttributes class]]) {
                                activeLayoutAttributesGridList.nextLayoutCellFrame = nextLayoutAttributes.frame;
                            }
                        }
                    }
                }   break;
                case UICollectionElementCategoryDecorationView:
                default:
                    break;
            }
        }
    }
}

@end
