//
//  CPTGridListLayout.m
//  CPTGridListTransitionManager
//
//  Created by Bob Kutschke on 5/19/19.
//  Copyright © 2019 Chronic Stimulation, LLC. All rights reserved.
//

#import "CPTGridListLayout.h"
#import "CPTGridListLayoutAttributes.h"

@interface CPTGridListLayout ()

@property (nonatomic, assign) NSUInteger numberOfColumns;
@property (nonatomic, assign) CGFloat activeLayoutStaticHeaderHeight;
@property (nonatomic, assign) CGFloat nextLayoutStaticHeaderHeight;
@property (nonatomic, assign) CGFloat activeLayoutStaticFooterHeight;
@property (nonatomic, assign) CGFloat nextLayoutStaticFooterHeight;
@property (nonatomic, assign) CGPoint supplementaryViewPadding;
@property (nonatomic, assign) CGPoint cellPadding;
@property (nonatomic, assign) CGFloat activeLayoutStaticCellHeight;
@property (nonatomic, assign) CGFloat nextLayoutStaticCellHeight;
@property (nonatomic, strong) NSValue *previousContentOffset;
@property (nonatomic, assign) NSUInteger listLayoutCountOfColumns;
@property (nonatomic, assign) NSUInteger gridLayoutCountOfColumns;
@property (nonatomic, strong) NSMutableDictionary < NSIndexPath *, CPTGridListLayoutAttributes *> *baseLayoutAttributes;
@property (nonatomic, strong) NSMutableDictionary < NSString *, NSMutableDictionary *> *baseLayoutSupplementaryAttributes; // By SuppView type to get NSMutDict, then by NSIndexPath to get attributes
@property (nonatomic, assign) CGFloat contentHeight;
@property (nonatomic, assign) CGFloat contentWidth;

@end

@implementation CPTGridListLayout

-(instancetype)initCPTGridListLayoutWithState:(LayoutState)layoutState
               activeLayoutStaticHeaderHeight:(CGFloat)activeLayoutStaticHeaderHeight
                 activeLayoutStaticCellHeight:(CGFloat)activeLayoutStaticCellHeight
               activeLayoutStaticFooterHeight:(CGFloat)activeLayoutStaticFooterHeight
               nextLayoutStaticHeaderHeight:(CGFloat)nextLayoutStaticHeaderHeight
                 nextLayoutStaticCellHeight:(CGFloat)nextLayoutStaticCellHeight
                 nextLayoutStaticFooterHeight:(CGFloat)nextLayoutStaticFooterHeight;
{
    self = [[CPTGridListLayout alloc] init];
    if (self) {

        [self configureWithDefaultConditions];
        
        _layoutState = layoutState;
        _activeLayoutStaticHeaderHeight = activeLayoutStaticHeaderHeight;
        _activeLayoutStaticCellHeight = activeLayoutStaticCellHeight;
        _activeLayoutStaticFooterHeight = activeLayoutStaticFooterHeight;
        _nextLayoutStaticHeaderHeight = nextLayoutStaticHeaderHeight;
        _nextLayoutStaticCellHeight = nextLayoutStaticCellHeight;
        _nextLayoutStaticFooterHeight = nextLayoutStaticFooterHeight;
    }
    
    return self;
}

-(instancetype)initCPTGridListLayoutWithActiveLayoutStaticCellHeight:(CGFloat)activeLayoutStaticCellHeight nextLayoutStaticCellHeight:(CGFloat)nextLayoutStaticCellHeight layoutState:(LayoutState)layoutState;
{
    return [self initCPTGridListLayoutWithActiveLayoutStaticCellHeight:activeLayoutStaticCellHeight nextLayoutStaticCellHeight:nextLayoutStaticCellHeight layoutState:layoutState cellPadding:CGPointMake(6.0f,6.0f) gridLayoutCountOfColumns:3];
}

-(instancetype)initCPTGridListLayoutWithActiveLayoutStaticCellHeight:(CGFloat)activeLayoutStaticCellHeight nextLayoutStaticCellHeight:(CGFloat)nextLayoutStaticCellHeight layoutState:(LayoutState)layoutState cellPadding:(CGPoint)cellPadding gridLayoutCountOfColumns:(NSUInteger)countOfColumns;
{
    self = [[CPTGridListLayout alloc] init];
    if (self) {
        
        [self configureWithDefaultConditions];

        _activeLayoutStaticCellHeight = activeLayoutStaticCellHeight;
        _nextLayoutStaticCellHeight = nextLayoutStaticCellHeight;
        _gridLayoutCountOfColumns = countOfColumns;
        _layoutState = layoutState;
        _cellPadding = cellPadding;
        _supplementaryViewPadding = cellPadding;
        
    }
    return self;
}

-(void)configureWithDefaultConditions;
{
    _layoutState = list;
    _activeLayoutStaticHeaderHeight = 60.0f;
    _activeLayoutStaticCellHeight = 50.0f;
    _activeLayoutStaticFooterHeight = 35.0f;
    _nextLayoutStaticHeaderHeight = 0.0f;
    _nextLayoutStaticCellHeight = 80.0f;
    _nextLayoutStaticFooterHeight = 0.0;
    _cellPadding = CGPointMake(6.0f, 6.0f);
    _supplementaryViewPadding = CGPointMake(6.0f, 6.0f);
    _listLayoutCountOfColumns = 1;
    _gridLayoutCountOfColumns = 3;
}

#pragma mark - Property Setters/Getters

-(NSUInteger)numberOfColumns;
{
    switch (self.layoutState) {
        case grid:
            _numberOfColumns = self.gridLayoutCountOfColumns;
            break;
        case list:
        default:
            _numberOfColumns = self.listLayoutCountOfColumns;
            break;
    }
    return _numberOfColumns;
}

-(NSMutableDictionary < NSIndexPath *, CPTGridListLayoutAttributes *> *)baseLayoutAttributes;
{
    if (nil != _baseLayoutAttributes) {
        return _baseLayoutAttributes;
    }
    
    _baseLayoutAttributes = (NSMutableDictionary < NSIndexPath *, CPTGridListLayoutAttributes *> *)[NSMutableDictionary new];
    return _baseLayoutAttributes;
}

-(NSMutableDictionary < NSString *, NSMutableDictionary *> *)baseLayoutSupplementaryAttributes;
{
    if (nil != _baseLayoutSupplementaryAttributes) {
        return _baseLayoutSupplementaryAttributes;
    }
    
    _baseLayoutSupplementaryAttributes = [NSMutableDictionary new];
    NSMutableDictionary *sectionHeaderDict = [NSMutableDictionary new];
    NSMutableDictionary *sectionFooterDict = [NSMutableDictionary new];
    _baseLayoutSupplementaryAttributes[UICollectionElementKindSectionHeader] = sectionHeaderDict;
    _baseLayoutSupplementaryAttributes[UICollectionElementKindSectionFooter] = sectionFooterDict;

    return _baseLayoutSupplementaryAttributes;
}

-(CGFloat)contentWidth;
{
    _contentWidth = 0.0f;
    if (nil != self.collectionView) {
        UIEdgeInsets edgeInsets = self.collectionView.contentInset;
        _contentWidth = MAX(0,self.collectionView.bounds.size.width - edgeInsets.left - edgeInsets.right);
    }
    return _contentWidth;
}

#pragma mark - UICollectionViewLayout

-(void)prepareLayout;
{
    [super prepareLayout];
    
    [self.baseLayoutAttributes removeAllObjects];
    
    self.contentHeight = 0;
    CGFloat columnWidth = floorf(self.contentWidth / (CGFloat)(self.numberOfColumns));
    NSMutableArray < NSNumber *> *xOffsets = [NSMutableArray new];
    NSMutableArray < NSNumber *> *yOffsets = [NSMutableArray new];
    for (int column=0; column<self.numberOfColumns; column++) {
        [xOffsets addObject:@(floorf(column*columnWidth))];
        [yOffsets addObject:@(floorf(self.contentHeight))];
    }
    
    NSInteger sections = [self.collectionView numberOfSections];
    for (int section = 0; section < sections; section++) {
        
        NSIndexPath *sectionIndexPath = [NSIndexPath indexPathForItem:0 inSection:section];
        CPTGridListLayoutAttributes *headerAttributes = [CPTGridListLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:sectionIndexPath];
        if (headerAttributes && 0.0f < self.activeLayoutStaticHeaderHeight) {
            CGFloat headerHeight = self.supplementaryViewPadding.y + self.activeLayoutStaticHeaderHeight;
            
            // Use the maximum yOffset across all columns
            CGFloat suppViewFrameY = [[yOffsets valueForKeyPath:@"@max.floatValue"] floatValue];
            CGRect headerFrame = CGRectMake(0, suppViewFrameY, self.contentWidth, headerHeight);
            CGRect headerInsetFrame = CGRectInset(headerFrame, self.supplementaryViewPadding.x, self.supplementaryViewPadding.y);
            if (CGRectIsNull(headerInsetFrame)) { headerInsetFrame = CGRectZero;}
            
            headerAttributes.frame = headerInsetFrame;
            self.baseLayoutSupplementaryAttributes[UICollectionElementKindSectionHeader][sectionIndexPath] = headerAttributes;
            self.contentHeight = MAX(self.contentHeight, CGRectGetMaxX(headerFrame));
            
            // Shift all yOffset columns down to the same point below the headerView
            CGFloat newYOffset = suppViewFrameY + headerHeight;
            NSMutableArray < NSNumber *> *newYOffsets = [NSMutableArray new];
            for (int i=0; i<yOffsets.count; i++) {
                [newYOffsets addObject:@(newYOffset)];
            }
            yOffsets = newYOffsets;
        }
        
        int column = 0;
        NSInteger itemsInSection = [self.collectionView numberOfItemsInSection:section];
        for (int item = 0; item < itemsInSection; item++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            CGFloat height = self.cellPadding.y + self.activeLayoutStaticCellHeight;
            CGRect frame = CGRectMake(xOffsets[column].floatValue, yOffsets[column].floatValue, columnWidth, height);
            CGRect insetFrame = CGRectInset(frame,self.cellPadding.x,self.cellPadding.y);
            CPTGridListLayoutAttributes *attributes = [CPTGridListLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
  
            if (CGRectIsNull(insetFrame)) {
                insetFrame = CGRectZero;
            }
            
            attributes.frame = insetFrame;
            self.baseLayoutAttributes[indexPath] = attributes;
            self.contentHeight = MAX(self.contentHeight, CGRectGetMaxY(frame));
            yOffsets[column] = @(yOffsets[column].floatValue + height);
            column = (column == (self.numberOfColumns - 1)) ? 0 : column + 1;
        }
        
        CPTGridListLayoutAttributes *footerAttributes = [CPTGridListLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:sectionIndexPath];
        if (footerAttributes && 0.0f < self.activeLayoutStaticFooterHeight) {
            CGFloat footerHeight = self.supplementaryViewPadding.y + self.activeLayoutStaticFooterHeight;
            
            // Use the maximum yOffset across all columns
            CGFloat suppViewFrameY = [[yOffsets valueForKeyPath:@"@max.floatValue"] floatValue];
            CGRect footerFrame = CGRectMake(0, suppViewFrameY, self.contentWidth, footerHeight);
            CGRect footerInsetFrame = CGRectInset(footerFrame, self.supplementaryViewPadding.x, self.supplementaryViewPadding.y);
            if (CGRectIsNull(footerInsetFrame)) { footerInsetFrame = CGRectZero;}
            
            footerAttributes.frame = footerInsetFrame;
            self.baseLayoutSupplementaryAttributes[UICollectionElementKindSectionFooter][sectionIndexPath] = footerAttributes;
            self.contentHeight = MAX(self.contentHeight, CGRectGetMaxX(footerFrame));
            
            // Shift all yOffset columns down to the same point below the footerView
            CGFloat newYOffset = suppViewFrameY + footerHeight;
            NSMutableArray < NSNumber *> *newYOffsets = [NSMutableArray new];
            for (int i=0; i<yOffsets.count; i++) {
                [newYOffsets addObject:@(newYOffset)];
            }
            yOffsets = newYOffsets;
        }
    }
}

-(CGSize)collectionViewContentSize;
{
    return CGSizeMake(self.contentWidth, self.contentHeight);
}

-(NSArray <UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect;
{
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        
        return CGRectIntersectsRect(rect, [(CPTGridListLayoutAttributes *)evaluatedObject frame]);
    }];
    NSMutableArray *intersectingElements = [NSMutableArray new];
    
    //Find cell elements
    NSArray *cells = [self.baseLayoutAttributes.allValues filteredArrayUsingPredicate:predicate];
    
    //Find supplementary views
    NSArray *headers = [self.baseLayoutSupplementaryAttributes[UICollectionElementKindSectionHeader].allValues filteredArrayUsingPredicate:predicate];
    NSArray *footers = [self.baseLayoutSupplementaryAttributes[UICollectionElementKindSectionFooter].allValues filteredArrayUsingPredicate:predicate];
    
    [intersectingElements addObjectsFromArray:cells];
    [intersectingElements addObjectsFromArray:headers];
    [intersectingElements addObjectsFromArray:footers];
    
    return intersectingElements;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    return self.baseLayoutAttributes[indexPath];
}

-(Class)layoutAttributesClass;
{
    return [CPTGridListLayoutAttributes class];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath;
{
    return self.baseLayoutSupplementaryAttributes[elementKind][indexPath];
}

-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset;
{

    CGPoint superContentOffset = [super targetContentOffsetForProposedContentOffset:proposedContentOffset];

    if (nil != self.previousContentOffset) {
        CGPoint previousContentOffsetPoint = self.previousContentOffset.CGPointValue;
        
        if (previousContentOffsetPoint.y == 0) {
            return previousContentOffsetPoint;
        }
        
        switch (self.layoutState) {
            case grid: {
                CGFloat realOffsetY = ceilf((previousContentOffsetPoint.y / self.nextLayoutStaticCellHeight * self.activeLayoutStaticCellHeight / (CGFloat)self.numberOfColumns) - self.cellPadding.y);
                CGFloat offsetY = floorf(realOffsetY / self.activeLayoutStaticCellHeight) * self.activeLayoutStaticCellHeight + self.cellPadding.y;
                return CGPointMake(superContentOffset.x, offsetY);
            }   break;
            case list: {
                CGFloat offsetY = ceilf( previousContentOffsetPoint.y + (self.activeLayoutStaticCellHeight * previousContentOffsetPoint.y / self.nextLayoutStaticCellHeight) + self.cellPadding.y);
                return CGPointMake(superContentOffset.x, offsetY);
            }   break;
        }
    }
    return superContentOffset;
}

-(void)prepareForTransitionFromLayout:(UICollectionViewLayout *)oldLayout;
{
    if (nil != oldLayout.collectionView) {
        self.previousContentOffset = [NSValue valueWithCGPoint:oldLayout.collectionView.contentOffset];
    } else {
        self.previousContentOffset = nil;
    }
    
    [super prepareForTransitionFromLayout:oldLayout];
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds;
{
    return (newBounds.size.width != self.collectionView.bounds.size.width);
}

-(void)finalizeLayoutTransition;
{
    self.previousContentOffset = nil;
    
    [super finalizeLayoutTransition];
}

@end
