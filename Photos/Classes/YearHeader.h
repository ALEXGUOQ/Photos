//
//  YearHeader.h
//  Photos
//
//  Created by tag_mac_05 on 14-3-26.
//  Copyright (c) 2014年 tag_ux. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YearHeader : UICollectionReusableView
{
    UILabel* yearLabel;
    UILabel* locationLabel;
    
}

-(void)setYearText:(NSString*)text;

@end
