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
{
    CGFloat _gridStrokeEnd;
    CGFloat _listStrokeEnd;
    CGFloat _gridLineWidth;
    CGFloat _listLineWidth;
    CGFloat _stepHeightDelta;
    NSInteger _itemsCount;
    CAShapeLayer *_lineLayer1;
    CAShapeLayer *_lineLayer2;
    CAShapeLayer *_lineLayer3;
    CAShapeLayer *_lineLayer4;
    CAShapeLayer *_lineLayer5;
    CAShapeLayer *_lineLayer6;
}
@property (nonatomic, strong) NSMutableArray <CAShapeLayer *> *lineLayers;
@property (nonatomic, assign) LayoutState nextLayoutState;

@end

@implementation CPTGridListAnimatedButton

-(instancetype)init;
{
    self = [super init];
    if (self) {
        [self applyInitialButtonConditions];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder;
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self applyInitialButtonConditions];
    }
    return self;
}

-(void)buttonSelectedDisplayNextLayoutState:(LayoutState)nextLayoutState animate:(BOOL)animate;
{
    _nextLayoutState = nextLayoutState;

    if (animate) {
        [self animateRotationWithDuration:self.animationDuration];
    } else {
        [self animateRotationWithDuration:0];
    }
}

-(void)adjustTransformsForNextLayoutState:(LayoutState)nextLayoutState;
{
    switch (nextLayoutState) {
        case grid: {
            
            self.transform = CGAffineTransformMakeRotation(-M_PI_2);
            for (int index = 0; index < _itemsCount; index++) {
                CAShapeLayer *lineLayer = self.lineLayers[index];
                lineLayer.strokeEnd = _gridStrokeEnd;
                lineLayer.lineWidth = _gridLineWidth;
            }
            
        }   break;
        case list: {
            
            self.transform = CGAffineTransformIdentity;
            for (int index = 0; index < _itemsCount; index++) {
                CAShapeLayer *lineLayer = self.lineLayers[index];
                lineLayer.strokeEnd = _listStrokeEnd;
                lineLayer.lineWidth = _listLineWidth;
            }
            
        }   break;
    }
}

-(void)applyInitialButtonConditions;
{
    _gridStrokeEnd = 0.8f;
    _listStrokeEnd = 1.0f;
    _gridLineWidth = 4.0f;
    _listLineWidth = 2.0f;
    _stepHeightDelta = 0.3f;
    _itemsCount = 6;
    self.animationDuration = 0.25;
    self.lineColor = [UIColor greenColor];
    self.contentMode = UIViewContentModeScaleAspectFit;
}

-(void)awakeFromNib;
{
    [super awakeFromNib];
    
    for (int lineLayer = 0; lineLayer < _itemsCount; lineLayer++) {
        [self.layer addSublayer:self.lineLayers[lineLayer]];
    }
    [self drawLineForInitialState:grid];
}

-(NSMutableArray <CAShapeLayer *> *)lineLayers;
{
    if (nil != _lineLayers) {
        return _lineLayers;
    }
    
    _lineLayers = (NSMutableArray <CAShapeLayer *> *)[[NSMutableArray alloc] init];
    
    _lineLayer1 = [CAShapeLayer layer];
    _lineLayer2 = [CAShapeLayer layer];
    _lineLayer3 = [CAShapeLayer layer];
    _lineLayer4 = [CAShapeLayer layer];
    _lineLayer5 = [CAShapeLayer layer];
    _lineLayer6 = [CAShapeLayer layer];

    [_lineLayers addObjectsFromArray:@[_lineLayer1,_lineLayer2,_lineLayer3,_lineLayer4,_lineLayer5,_lineLayer6]];
    return _lineLayers;
}

-(void)animateRotationWithDuration:(NSTimeInterval)duration;
{
    __weak __typeof__(self) weakSelf = self;
    [UIView animateWithDuration:duration animations:^{
        __typeof__(self) strongSelf = weakSelf;

        [strongSelf adjustTransformsForNextLayoutState:strongSelf->_nextLayoutState];
        
        CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        strokeEndAnimation.duration = duration;
        
        CABasicAnimation *lineWidthAnimation = [CABasicAnimation animationWithKeyPath:@"lineWidth"];
        lineWidthAnimation.duration = duration;
        
        for (int index = 0; index < strongSelf->_itemsCount; index++) {
            CAShapeLayer *lineLayer = strongSelf.lineLayers[index];
            [lineLayer addAnimation:strokeEndAnimation forKey:nil];
            [lineLayer addAnimation:lineWidthAnimation forKey:nil];
        }
    }];
}

-(void)drawLineForInitialState:(LayoutState)initialLayoutState;
{
    CGFloat heightDelta = 0.2;
    for (int index = 0; index < _itemsCount; index++) {
        
        CAShapeLayer *lineLayer = self.lineLayers[index];
        CGFloat offsetX = 0.0f;
        if (index % 2 == 0) {
            if (index > 0) {
                heightDelta += _stepHeightDelta;
            }
        } else {
            offsetX = self.bounds.size.width;
        }
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(offsetX, (self.bounds.size.height * heightDelta))];
        [path addLineToPoint:CGPointMake((self.bounds.size.width / 2.0f), self.bounds.size.height * heightDelta)];
        lineLayer.path = path.CGPath;
        lineLayer.strokeColor = [self.lineColor CGColor];
        lineLayer.lineWidth = _listLineWidth;
    }
    
    [self adjustTransformsForNextLayoutState:initialLayoutState];
}

@end
