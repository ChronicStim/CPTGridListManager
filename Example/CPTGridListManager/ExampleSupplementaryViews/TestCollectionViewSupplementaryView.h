//
//  TestCollectionViewSupplementaryView.h
//  CPTGridListTransitionMangerExampleProject
//
//  Created by Bob Kutschke on 5/22/19.
//  Copyright © 2019 Chronic Stimulation, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CPTGridListManager/CPTGridListManager.h>

#define kTestCollectionViewSupplementaryViewSectionLabelText @"sectionLabelText"
#define kTestCollectionViewSupplementaryViewLayoutStyleLabelText @"layoutStyleLabelText"

@interface TestCollectionViewSupplementaryView : UICollectionReusableView
< CPTGridListUICollectionReusableView >

-(void)assignReusableViewKind:(NSString *)reusableViewKind sectionDetails:(NSDictionary *)sectionDetails;

@end
