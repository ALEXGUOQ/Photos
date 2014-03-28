//
//  YearHeader.h
//  Photos
//
//  Created by tag_mac_05 on 14-3-26.
//  Copyright (c) 2014年 tag_ux. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YearHeader;
@protocol YearHeaderDelegate <NSObject>


-(void)yearHeaderPressed:(YearHeader*)header;

@end
@interface YearHeader : UICollectionReusableView
{
    UILabel* yearLabel;
    UILabel* locationLabel;
    
}
@property (nonatomic) NSInteger sectionIndex;
@property (nonatomic,assign) id<YearHeaderDelegate> delegate;

-(void)setYearText:(NSString*)text;
-(NSString*)yearText;
@end
