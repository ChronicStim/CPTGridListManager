//
//  CellDataProvider.m
//  CPTGridListTransitionMangerExampleProject
//
//  Created by Bob Kutschke on 5/21/19.
//  Copyright © 2019 Chronic Stimulation, LLC. All rights reserved.
//

#import "CellDataProvider.h"
#import "CellDataObject.h"

@implementation CellDataProvider

-(NSArray *)generateTestDataForSections:(NSInteger)sections maxItemsPerSection:(NSInteger)maxItemsPerSection;
{
    NSMutableArray *newTestDataArray = [NSMutableArray new];
    
    for (int section = 0; section < sections; section++) {
        
        NSInteger itemCountForSection = arc4random_uniform((uint32_t)maxItemsPerSection) + 1;
        NSMutableArray *newSectionArray = [NSMutableArray new];
        for (int item = 0; item < itemCountForSection; item++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            CellDataObject *cellDataObject = [self newCellDataObjectForIndexPath:indexPath];
            [newSectionArray addObject:cellDataObject];
        }
        
        [newTestDataArray addObject:newSectionArray];
    }
    
    return newTestDataArray;
}

-(NSArray *)iconImageNameArray;
{
    return @[@"FCIcon_clear_night",
             @"FCIcon_cloudy_night",
             @"FCIcon_cloudy",
             @"FCIcon_fog_night",
             @"FCIcon_fog",
             @"FCIcon_foggy",
             @"FCIcon_heavy_rain",
             @"FCIcon_ice",
             @"FCIcon_night_rain_thunder",
             @"FCIcon_night_rain",
             @"FCIcon_partly_cloudy",
             @"FCIcon_rain_sun",
             @"FCIcon_rain_thunder_sun",
             @"FCIcon_sleet",
             @"FCIcon_smoke",
             @"FCIcon_snow_night",
             @"FCIcon_snow_sun",
             @"FCIcon_sunny"];
}

-(NSInteger)iconArrayCount;
{
    return 18; // Must match count of iconImageNameArray
}

-(NSString *)randomIconFilename;
{
    int randomIndex = arc4random_uniform((uint32_t)[self iconArrayCount]);
    return self.iconImageNameArray[randomIndex];
}

-(CellDataObject *)newCellDataObjectForIndexPath:(NSIndexPath *)indexPath;
{
    CellDataObject *cellDataObject = nil;
    if (nil != indexPath) {
        
        NSString *randomIconFilename = [self randomIconFilename];
        cellDataObject = [[CellDataObject alloc] initWithCellIndexPath:indexPath iconName:randomIconFilename];
    }
    return cellDataObject;
}



@end
