//
//  CellDataObject.h
//  CPTGridListTransitionMangerExampleProject
//
//  Created by Bob Kutschke on 5/21/19.
//  Copyright © 2019 Chronic Stimulation, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellDataObject : NSObject

@property (nonatomic, strong) NSString *iconImageName;
@property (nonatomic, strong) NSString *listCellDisplayName;
@property (nonatomic, strong) NSString *gridCellDisplayName;

-(instancetype)initWithCellIndexPath:(NSIndexPath *)indexPath iconName:(NSString *)iconName;
-(UIImage *)iconImage;

@end
