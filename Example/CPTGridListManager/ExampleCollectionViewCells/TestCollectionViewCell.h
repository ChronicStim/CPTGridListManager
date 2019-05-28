//
//  TestCollectionViewCell.h
//  CPTGridListTransitionMangerExampleProject
//
//  Created by Bob Kutschke on 5/21/19.
//  Copyright © 2019 Chronic Stimulation, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CPTGridListManager/CPTGridListManager.h>

@class CellDataObject;
@interface TestCollectionViewCell : UICollectionViewCell
< CPTGridListUICollectionViewCell >

@property (nonatomic, strong) NSString *cellIndexPath;

-(void)applyCellDataObjectContent:(CellDataObject *)cellDataObject;

@end
