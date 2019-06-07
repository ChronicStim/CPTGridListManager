//
//  CPTGridListAnimatedView.m
//  CPTGridListManager
//
//  Created by Bob Kutschke on 6/7/19.
//

#import "CPTGridListAnimatedView.h"
#import "CPTGridListLayout.h"

@interface CPTGridListAnimatedView ()
{
    CGFloat _gridStrokeEnd;
    CGFloat _listStrokeEnd;
    CGFloat _gridLineWidth;
    CGFloat _listLineWidth;
    CGFloat _stepHeightDelta;
    CGFloat _stepWidthDelta;
    NSInteger _itemsCount;
    CAShapeLayer *_lineLayer1;
    CAShapeLayer *_lineLayer2;
    CAShapeLayer *_lineLayer3;
    CAShapeLayer *_lineLayer4;
    CAShapeLayer *_lineLayer5;
    CAShapeLayer *_lineLayer6;
    CAShapeLayer *_lineLayer7;
    CAShapeLayer *_lineLayer8;
    CAShapeLayer *_lineLayer9;
}
@property (nonatomic, strong) NSMutableArray <CAShapeLayer *> *lineLayers;
@property (nonatomic, assign) LayoutState nextLayoutState;

@end

@implementation CPTGridListAnimatedView

-(instancetype)init;
{
    self = [super init];
    if (self) {
        [self applyInitialButtonConditions];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame;
{
    self = [super initWithFrame:frame];
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

-(void)displayNextLayoutState:(LayoutState)nextLayoutState animate:(BOOL)animate;
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
    _gridStrokeEnd = 0.6f;
    _listStrokeEnd = 1.0f;
    _gridLineWidth = 4.0f;
    _listLineWidth = 2.0f;
    _stepHeightDelta = 0.3f;
    _stepWidthDelta = 1.0f/3.0f;
    _itemsCount = 9;
    self.animationDuration = 0.25;
    self.lineColor = [UIColor redColor];
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
    _lineLayer7 = [CAShapeLayer layer];
    _lineLayer8 = [CAShapeLayer layer];
    _lineLayer9 = [CAShapeLayer layer];

    [_lineLayers addObjectsFromArray:@[_lineLayer1,_lineLayer2,_lineLayer3,_lineLayer4,_lineLayer5,_lineLayer6,_lineLayer7,_lineLayer8,_lineLayer9]];
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
    CGFloat offsetX1 = 0.0f;
    CGFloat offsetX2 = 0.0f;
    for (int index = 0; index < _itemsCount; index++) {
        
        CAShapeLayer *lineLayer = self.lineLayers[index];
        if (index % 3 == 0) {
            if (index > 0) {
                heightDelta += _stepHeightDelta;
            }
            offsetX1 = 0.0f;
        } else {
            offsetX1 = offsetX2;
        }
        offsetX2 = offsetX1 + _stepWidthDelta;

        UIBezierPath *path = [UIBezierPath bezierPath];
        CGFloat width = self.bounds.size.width;
        [path moveToPoint:CGPointMake(offsetX1 * width, (self.bounds.size.height * heightDelta))];
        [path addLineToPoint:CGPointMake(offsetX2 * width, self.bounds.size.height * heightDelta)];
        lineLayer.path = path.CGPath;
        lineLayer.strokeColor = [self.lineColor CGColor];
        lineLayer.lineWidth = _listLineWidth;
    }
    
    [self adjustTransformsForNextLayoutState:initialLayoutState];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
