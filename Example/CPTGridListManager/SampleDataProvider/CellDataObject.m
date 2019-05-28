//
//  CellDataObject.m
//  CPTGridListTransitionMangerExampleProject
//
//  Created by Bob Kutschke on 5/21/19.
//  Copyright © 2019 Chronic Stimulation, LLC. All rights reserved.
//

#import "CellDataObject.h"

@interface CellDataObject ()

@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@implementation CellDataObject

-(instancetype)initWithCellIndexPath:(NSIndexPath *)indexPath iconName:(NSString *)iconName;
{
    self = [super init];
    if (self) {
        
        _iconImageName = iconName;
        _indexPath = indexPath;
    }
    return self;
}

-(NSString *)listCellDisplayName;
{
    if (nil != _listCellDisplayName) {
        return _listCellDisplayName;
    }
    
    if (nil != _indexPath) {
        _listCellDisplayName = [NSString stringWithFormat:@"Cell at indexPath: %ld, %ld",_indexPath.section, _indexPath.row];
    } else {
        _listCellDisplayName = @"Cell at indexPath: ?, ?";
    }
    return _listCellDisplayName;
}

-(NSString *)gridCellDisplayName;
{
    if (nil != _gridCellDisplayName) {
        return _gridCellDisplayName;
    }
    
    if (nil != _indexPath) {
        _gridCellDisplayName = [NSString stringWithFormat:@"(%ld, %ld)",_indexPath.section, _indexPath.row];
    } else {
        _gridCellDisplayName = @"(?, ?)";
    }
    return _gridCellDisplayName;
}

-(UIImage *)iconImage;
{
    UIImage *iconImage = nil;
    if (nil != _iconImageName) {
        iconImage = [UIImage imageNamed:_iconImageName];
    }
    return iconImage;
}

@end
