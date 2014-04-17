//
//  AppData.h
//  Photos
//
//  Created by tag_mac_05 on 14-3-31.
//  Copyright (c) 2014年 tag_ux. All rights reserved.
//

#import <Foundation/Foundation.h>
//const NSString *AppDataRefreshDataNotification = @"AppDataRefreshDataNotification";


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

+(instancetype)sharedAppData;

-(void)loadSettingBundleData;

@property (nonatomic) BOOL hasSharedVC;


@property (nonatomic) CollectionMode collectionMode;
//年度
@property (nonatomic,retain) NSMutableArray *yearsArray;
//精选
@property (nonatomic,retain) NSMutableArray *collectionsArray;
//时刻
@property (nonatomic,retain) NSMutableArray *momentsArray;

@property (nonatomic,retain) NSMutableArray *allArray;




#pragma mark - Notification

@end

//数据更新
const NSString *AppDataRefreshDataNotification = @"AppDataRefreshDataNotification";

#define AppDataRefreshDataNotification @"AppDataRefreshDataNotification"
