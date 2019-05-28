//
//  CPTGridListTransitionManager.m
//  CPTGridListTransitionManager
//
//  Created by Bob Kutschke on 5/19/19.
//  Copyright © 2019 Chronic Stimulation, LLC. All rights reserved.
//

#import "CPTGridListTransitionManager.h"
#import "CPTGridListTransitionLayout.h"

@interface CPTGridListTransitionManager ()

@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewLayout *destinationLayout;
@property (nonatomic, assign) LayoutState layoutState;
@property (nonatomic, strong) CPTGridListTransitionLayout *transitionLayout;
@property (nonatomic, strong) CADisplayLink *updater;
@property (nonatomic, assign) NSTimeInterval startTime;
@property (nonatomic, assign) CGFloat finishTransitionValue;

@end

@implementation CPTGridListTransitionManager

-(instancetype)initWithDuration:(NSTimeInterval)duration collectionView:(UICollectionView *)collectionView destinationLayout:(CPTGridListLayout *)destinationLayout layoutState:(LayoutState)layoutState;
{
    self = [super init];
    if (self) {
        
        _collectionView = collectionView;
        _destinationLayout = destinationLayout;
        _layoutState = layoutState;
        _duration = duration;
        _finishTransitionValue = 1.0f;
    }
    return self;
}

-(void)startInteractiveTransition;
{
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    self.transitionLayout = (CPTGridListTransitionLayout *)[self.collectionView startInteractiveTransitionToCollectionViewLayout:self.destinationLayout completion:^(BOOL completed, BOOL finished) {
        
        if (completed && finished) {
            
            [self.collectionView reloadData];
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        }
    }];
    self.transitionLayout.layoutState = self.layoutState;
    [self createUpdaterAndStart];
}

-(void)createUpdaterAndStart;
{
    _startTime = CACurrentMediaTime();
    self.updater = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateTransitionProgress)];
    [self.updater addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

-(void)updateTransitionProgress;
{
    NSTimeInterval progress = (self.updater.timestamp - self.startTime) / self.duration;
    progress = MIN(1, progress);
    progress = MAX(0, progress);
    self.transitionLayout.transitionProgress = (CGFloat)progress;
    
    [self.transitionLayout invalidateLayout];
    if (progress == self.finishTransitionValue) {
        [self.collectionView finishInteractiveTransition];
        [self.updater invalidate];
    }
}

@end
