//
//  CPTGridListViewController.m
//  CPTGridListManager
//
//  Created by support@chronicstimulation.com on 05/27/2019.
//  Copyright (c) 2019 support@chronicstimulation.com. All rights reserved.
//

#import "CPTGridListViewController.h"
#import <CPTGridListManager/CPTGridListManager.h>
#import "CellDataObject.h"
#import "CellDataProvider.h"
#import "TestCollectionViewCell.h"
#import "TestCollectionViewSupplementaryView.h"
#import "UserCollectionViewCell.h"

#define kExampleModeDisplayUserCollectionViewCell 0
#define kExampleModeIncludeSectionHeaders 1
#define kExampleModeIncludeSectionFooters 1

#define kNumberOfSections 5
#define kMaxNumberOfItemsPerSection 10

@interface CPTGridListViewController ()
< UICollectionViewDelegate, UICollectionViewDataSource >
{
    NSTimeInterval _animationDuration;
    CGFloat _listLayoutStaticCellHeight;
    CGFloat _gridLayoutStaticCellHeight;
    
    CGFloat _listLayoutStaticHeaderHeight;
    CGFloat _gridLayoutStaticHeaderHeight;
    
    CGFloat _listLayoutStaticFooterHeight;
    CGFloat _gridLayoutStaticFooterHeight;
    
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *changeLayoutButton;
@property (weak, nonatomic) IBOutlet CPTGridListAnimatedButton *rotationButton;
@property (nonatomic, strong) CellDataProvider *cellDataProvider;
@property (nonatomic, strong) UITapGestureRecognizer *tap;
@property (nonatomic, strong) NSArray *testData;
@property (nonatomic, assign) BOOL isTransitionAvailable;
@property (nonatomic, strong) CPTGridListLayout *gridLayout;
@property (nonatomic, strong) CPTGridListLayout *listLayout;
@property (nonatomic, assign) LayoutState layoutState;

-(IBAction)buttonTapped:(id)sender;

@end

@implementation CPTGridListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupInitialConditions];
}

-(void)setupInitialConditions;
{
    _animationDuration = 0.3;
    
    if (kExampleModeDisplayUserCollectionViewCell) {
        _listLayoutStaticCellHeight = 80.0f;
        _gridLayoutStaticCellHeight = 165.0f;
    } else {
        _listLayoutStaticCellHeight = 65.0f;
        _gridLayoutStaticCellHeight = 132.0f;
    }
    
    if (kExampleModeIncludeSectionHeaders) {
        _listLayoutStaticHeaderHeight = 60.0f;
        _gridLayoutStaticHeaderHeight = 45.0f;
    } else {
        _listLayoutStaticHeaderHeight = 0.0f;
        _gridLayoutStaticHeaderHeight = 0.0f;
    }
    
    if (kExampleModeIncludeSectionFooters) {
        _listLayoutStaticFooterHeight = 60.0f;
        _gridLayoutStaticFooterHeight = 45.0f;
    } else {
        _listLayoutStaticFooterHeight = 0.0f;
        _gridLayoutStaticFooterHeight = 0.0f;
    }
    
    self.layoutState = list;
    self.isTransitionAvailable = YES;
    self.rotationButton.animationDuration = _animationDuration;
    [self.rotationButton buttonSelectedDisplayNextLayoutState:grid animate:YES];
    
    [self setupCollectionView];
}

#pragma mark - Property Methods

-(CellDataProvider *)cellDataProvider;
{
    if (nil != _cellDataProvider) {
        return _cellDataProvider;
    }
    
    _cellDataProvider = [[CellDataProvider alloc] init];
    return _cellDataProvider;
}

-(NSArray *)testData;
{
    if (nil != _testData) {
        return _testData;
    }
    
    _testData = [self.cellDataProvider generateTestDataForSections:kNumberOfSections maxItemsPerSection:kMaxNumberOfItemsPerSection];
    return _testData;
}

-(UITapGestureRecognizer *)tap;
{
    if (nil != _tap) {
        return _tap;
    }
    
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
    return _tap;
}

-(CPTGridListLayout *)gridLayout;
{
    if (nil != _gridLayout) {
        return _gridLayout;
    }
    
    _gridLayout = [[CPTGridListLayout alloc] initCPTGridListLayoutWithState:grid
                                             activeLayoutStaticHeaderHeight:_gridLayoutStaticHeaderHeight
                                               activeLayoutStaticCellHeight:_gridLayoutStaticCellHeight
                                             activeLayoutStaticFooterHeight:_gridLayoutStaticFooterHeight
                                               nextLayoutStaticHeaderHeight:_listLayoutStaticHeaderHeight
                                                 nextLayoutStaticCellHeight:_listLayoutStaticCellHeight
                                               nextLayoutStaticFooterHeight:_listLayoutStaticFooterHeight];
    
    return _gridLayout;
}

-(CPTGridListLayout *)listLayout;
{
    if (nil != _listLayout) {
        return _listLayout;
    }
    
    _listLayout = [[CPTGridListLayout alloc] initCPTGridListLayoutWithState:list
                                             activeLayoutStaticHeaderHeight:_listLayoutStaticHeaderHeight
                                               activeLayoutStaticCellHeight:_listLayoutStaticCellHeight
                                             activeLayoutStaticFooterHeight:_listLayoutStaticFooterHeight
                                               nextLayoutStaticHeaderHeight:_gridLayoutStaticHeaderHeight
                                                 nextLayoutStaticCellHeight:_gridLayoutStaticCellHeight
                                               nextLayoutStaticFooterHeight:_gridLayoutStaticFooterHeight];
    
    return _listLayout;
}

#pragma mark -

-(void)handleTap;
{
    [self.view endEditing:YES];
}

#pragma mark -

-(void)setupCollectionView;
{
    self.collectionView.collectionViewLayout = self.listLayout;
    
    if (kExampleModeDisplayUserCollectionViewCell) {
        [self.collectionView registerNib:[UINib nibWithNibName:@"UserCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"UserCollectionViewCell"];
    } else {
        [self.collectionView registerNib:[UINib nibWithNibName:@"TestCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"TestCollectionViewCell"];
    }
    
    if (kExampleModeIncludeSectionHeaders) {
        [self.collectionView registerNib:[UINib nibWithNibName:@"TestCollectionViewSupplementaryView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TestCollectionViewSupplementaryView"];
    }
    
    if (kExampleModeIncludeSectionFooters) {
        [self.collectionView registerNib:[UINib nibWithNibName:@"TestCollectionViewSupplementaryView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"TestCollectionViewSupplementaryView"];
    }
}

-(CellDataObject *)cellDataObjectForIndexPath:(NSIndexPath *)indexPath;
{
    CellDataObject *cellDataObject = nil;
    if (nil != indexPath) {
        
        NSArray *sectionArray = [self.testData objectAtIndex:indexPath.section];
        
        if (nil != sectionArray && [sectionArray isKindOfClass:[NSArray class]]) {
            
            cellDataObject = [sectionArray objectAtIndex:indexPath.item];
        }
    }
    return cellDataObject;
}

#pragma mark -

-(IBAction)buttonTapped:(id)sender;
{
    if (!self.isTransitionAvailable) {
        return;
    }
    
    CPTGridListTransitionManager *transitionManager = nil;
    LayoutState previousState = self.layoutState; // which will also be the nextLayoutState for the animatedButton
    
    switch (self.layoutState) {
        case list: {
            
            self.layoutState = grid;
            transitionManager = [[CPTGridListTransitionManager alloc] initWithDuration:_animationDuration collectionView:self.collectionView destinationLayout:self.gridLayout layoutState:self.layoutState];
        }   break;
        case grid: {
            
            self.layoutState = list;
            transitionManager = [[CPTGridListTransitionManager alloc] initWithDuration:_animationDuration collectionView:self.collectionView destinationLayout:self.listLayout layoutState:self.layoutState];
        }   break;
        default:
            break;
    }
    
    if (transitionManager) {
        
        [transitionManager startInteractiveTransition];
        [self.rotationButton buttonSelectedDisplayNextLayoutState:previousState animate:YES];
    }
}

#pragma mark - UICollectionViewDataSource Methods

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView;
{
    if (kExampleModeIncludeSectionHeaders || kExampleModeIncludeSectionFooters) {
        return self.testData.count;
    }
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    if (kExampleModeIncludeSectionHeaders || kExampleModeIncludeSectionFooters) {
        return [self.testData[section] count];
    }
    return [self.testData[0] count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    if (kExampleModeDisplayUserCollectionViewCell) {
        UserCollectionViewCell <CPTGridListUICollectionViewCell> *cell = (UserCollectionViewCell <CPTGridListUICollectionViewCell> *)[collectionView dequeueReusableCellWithReuseIdentifier:@"UserCollectionViewCell" forIndexPath:indexPath];
        cell.cellIndexPath = indexPath;
        
        [cell forLayoutMode:self.layoutState setupCellLayoutConstraintsForTransitionProgress:1.0f cellSize:cell.frame.size];
        [cell applyCellDataObjectContent:[self cellDataObjectForIndexPath:indexPath]];
        
        return cell;
    } else {
        TestCollectionViewCell <CPTGridListUICollectionViewCell> *cell = (TestCollectionViewCell <CPTGridListUICollectionViewCell> *)[collectionView dequeueReusableCellWithReuseIdentifier:@"TestCollectionViewCell" forIndexPath:indexPath];
        
        [cell forLayoutMode:self.layoutState setupCellLayoutConstraintsForTransitionProgress:1.0f cellSize:cell.frame.size];
        [cell applyCellDataObjectContent:[self cellDataObjectForIndexPath:indexPath]];
        
        return cell;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath;
{
    TestCollectionViewSupplementaryView <CPTGridListUICollectionReusableView> *suppView = (TestCollectionViewSupplementaryView <CPTGridListUICollectionReusableView> *)[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"TestCollectionViewSupplementaryView" forIndexPath:indexPath];
    
    [suppView forLayoutMode:self.layoutState setupReusableViewLayoutConstraintsForTransitionProgress:1.0f cellSize:suppView.frame.size];
    
    NSDictionary *sectionDetails = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        sectionDetails = @{kTestCollectionViewSupplementaryViewSectionLabelText : [NSString stringWithFormat:@"Header: %ld",indexPath.section],
                           kTestCollectionViewSupplementaryViewLayoutStyleLabelText : (self.layoutState == grid) ? @"Grid" : @"List"
                           };
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        sectionDetails = @{kTestCollectionViewSupplementaryViewSectionLabelText : [NSString stringWithFormat:@"Footer: %ld",indexPath.section],
                           kTestCollectionViewSupplementaryViewLayoutStyleLabelText : (self.layoutState == grid) ? @"Grid" : @"List"
                           };
    }
    
    [suppView assignReusableViewKind:kind sectionDetails:sectionDetails];
    
    return suppView;
}

#pragma mark - UICollectionViewDelegate Methods

-(UICollectionViewTransitionLayout *)collectionView:(UICollectionView *)collectionView transitionLayoutForOldLayout:(UICollectionViewLayout *)fromLayout newLayout:(UICollectionViewLayout *)toLayout;
{
    CPTGridListTransitionLayout *customTransitionLayout = [[CPTGridListTransitionLayout alloc] initWithCurrentLayout:fromLayout nextLayout:toLayout];
    return customTransitionLayout;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
{
    _isTransitionAvailable = NO;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
{
    _isTransitionAvailable = YES;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
    [self.view endEditing:YES];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    NSLog(@"You just selected the item at (%ld, %ld)",indexPath.section,indexPath.item);
}

#pragma mark - CPTGridListLayoutDelegate methods


@end
