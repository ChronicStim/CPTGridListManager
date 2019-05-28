//
//  UserCollectionViewCell.h
//  CPTGridListTransitionMangerExampleProject
//
//  Created by Bob Kutschke on 5/22/19.
//  Copyright © 2019 Chronic Stimulation, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CPTGridListManager/CPTGridListManager.h>

@class CellDataObject;
@interface UserCollectionViewCell : UICollectionViewCell
< CPTGridListUICollectionViewCell >

@property (nonatomic, strong) NSIndexPath *cellIndexPath;

-(void)applyCellDataObjectContent:(CellDataObject *)cellDataObject;

@end
