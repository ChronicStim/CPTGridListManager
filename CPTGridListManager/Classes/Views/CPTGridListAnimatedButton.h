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

@property (nonatomic, strong) IBInspectable UIColor *lineColor;
@property (nonatomic, assign) NSTimeInterval animationDuration;

/**
 Triggers the button animation action from its currently displayed icon to the icon for the nextLayoutState. You can choose to have this switch be animated (recommended) or instant. If animated, it's recommended to set the animationDuration of the button to the same value as the layout transition animation.

 @param nextLayoutState The LayoutState for the icon the button should animate towards.
 @param animate BOOL value which indicates whether the icon change should be animated or not.
 */
-(void)buttonSelectedDisplayNextLayoutState:(LayoutState)nextLayoutState animate:(BOOL)animate;

@end
