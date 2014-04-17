//
//  ToolKit.h
//  Photos
//
//  Created by tag_mac_05 on 14-3-19.
//  Copyright (c) 2014年 tag_ux. All rights reserved.
//

#import <Foundation/Foundation.h>
@import AssetsLibrary;
@interface ToolKit : NSObject


+(ALAssetsLibrary*)sharedAssetsLibrary;

+(CGFloat)screenHeight;


//用来区分是iPhone还是iPad
+(BOOL)isIphone;

+(void)writeImageWithCollections:(NSArray*)collectionArray;


//年份的日期格式
+(NSDateFormatter*)yearDateFormatter;


#pragma mark - Layout
//全屏
+(UICollectionViewFlowLayout*)flowLayoutFullScreen;

//年份
+(UICollectionViewFlowLayout*)flowLayoutYear;

//精选
+(UICollectionViewFlowLayout*)flowLayoutCollections;


//时刻
+(UICollectionViewFlowLayout*)flowLayoutMoments;
@end
