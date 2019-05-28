//
//  CPTGridListAnimatedButton.h
//  CPTGridListTransitionManager
//
//  Created by Bob Kutschke on 5/19/19.
//  Copyright © 2019 Chronic Stimulation, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPTGridListLayout.h"

@interface CPTGridListAnimatedButton : UIButton

@property (nonatomic, assign) NSTimeInterval animationDuration;

-(void)buttonSelectedDisplayNextLayoutState:(LayoutState)nextLayoutState animate:(BOOL)animate;

@end
