//
//  CPTGridListAnimatedView.h
//  CPTGridListManager
//
//  Created by Bob Kutschke on 6/7/19.
//

#import <UIKit/UIKit.h>
#import "CPTGridListLayout.h"

@interface CPTGridListAnimatedView : UIView

@property (nonatomic, strong) IBInspectable UIColor *lineColor;
@property (nonatomic, assign) NSTimeInterval animationDuration;

-(void)displayNextLayoutState:(LayoutState)nextLayoutState animate:(BOOL)animate;

@end
