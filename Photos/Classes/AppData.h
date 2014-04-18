//
//  AppData.h
//  Photos
//
//  Created by tag_mac_05 on 14-3-31.
//  Copyright (c) 2014年 tag_ux. All rights reserved.
//

#import <Foundation/Foundation.h>
//const NSString *AppDataRefreshDataNotification = @"AppDataRefreshDataNotification";

<<<<<<< HEAD
<<<<<<< HEAD

@import CoreLocation;
typedef NS_ENUM(NSInteger, CollectionMode) {
    CollectionModeYear,                 // 年
    CollectionModeCollection,           // 精选
    CollectionModeMoment,               // 时刻
    CollectionModeFullScreen            //全屏
};

@interface AppData : NSObject
{
//    UIApplication
}

=======
@interface AppData : NSObject
>>>>>>> parent of 1bc2def... ci
=======
@interface AppData : NSObject
>>>>>>> parent of 1bc2def... ci
+(instancetype)sharedAppData;

-(void)loadSettingBundleData;

@property (nonatomic) BOOL hasSharedVC;
<<<<<<< HEAD
<<<<<<< HEAD


@property (nonatomic) CollectionMode collectionMode;
//年度
@property (nonatomic,retain) NSMutableArray *yearsArray;
//精选
@property (nonatomic,retain) NSMutableArray *collectionsArray;
//时刻
@property (nonatomic,retain) NSMutableArray *momentsArray;

@property (nonatomic,retain) NSMutableArray *allArray;




#pragma mark - Notification

=======
>>>>>>> parent of 1bc2def... ci
=======
>>>>>>> parent of 1bc2def... ci
@end

//数据更新
const NSString *AppDataRefreshDataNotification = @"AppDataRefreshDataNotification";

#define AppDataRefreshDataNotification @"AppDataRefreshDataNotification"
