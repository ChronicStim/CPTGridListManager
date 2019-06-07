//
//  CPTGridListAnimatedButton.m
//  CPTGridListTransitionManager
//
//  Created by Bob Kutschke on 5/19/19.
//  Copyright © 2019 Chronic Stimulation, LLC. All rights reserved.
//

#import "CPTGridListAnimatedButton.h"
#import "CPTGridListLayout.h"

@interface CPTGridListAnimatedButton ()

@end

@implementation CPTGridListAnimatedButton

-(void)buttonSelectedDisplayNextLayoutState:(LayoutState)nextLayoutState animate:(BOOL)animate;
{
    [self displayNextLayoutState:nextLayoutState animate:animate];
}

@end
