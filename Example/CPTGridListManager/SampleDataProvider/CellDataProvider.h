//
//  CellDataProvider.h
//  CPTGridListTransitionMangerExampleProject
//
//  Created by Bob Kutschke on 5/21/19.
//  Copyright © 2019 Chronic Stimulation, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellDataProvider : NSObject

-(NSArray *)generateTestDataForSections:(NSInteger)sections maxItemsPerSection:(NSInteger)maxItemsPerSection;

@end
