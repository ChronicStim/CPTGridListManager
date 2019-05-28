//
//  CPTGridListLayoutAttributes.m
//  CPTGridListTransitionManager
//
//  Created by Bob Kutschke on 5/19/19.
//  Copyright © 2019 Chronic Stimulation, LLC. All rights reserved.
//

#import "CPTGridListLayoutAttributes.h"

@implementation CPTGridListLayoutAttributes

-(instancetype)init;
{
    self = [super init];
    if (self) {
        
        _transitionProgress = 0.0f;
        _nextLayoutCellFrame = CGRectZero;
        _layoutState = list;
    }
    return self;
}

-(instancetype)copyWithZone:(NSZone *)zone;
{
    CPTGridListLayoutAttributes *copy = [super copyWithZone:zone];
    copy.transitionProgress = _transitionProgress;
    copy.nextLayoutCellFrame = _nextLayoutCellFrame;
    copy.layoutState = _layoutState;
    
    return copy;
}

-(BOOL)isEqual:(id)object;
{
    BOOL isEqual = NO;
    if (nil != object && [object isMemberOfClass:[CPTGridListLayoutAttributes class]]) {
        if ([(CPTGridListLayoutAttributes *)object transitionProgress] == _transitionProgress &&
            CGRectEqualToRect([(CPTGridListLayoutAttributes *)object nextLayoutCellFrame], _nextLayoutCellFrame) &&
            [(CPTGridListLayoutAttributes *)object layoutState] == _layoutState) {
            return [super isEqual:object];
        }
    }
    return isEqual;
}

@end
