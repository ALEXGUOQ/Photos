//
//  AppData.h
//  Photos
//
//  Created by tag_mac_05 on 14-3-31.
//  Copyright (c) 2014年 tag_ux. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppData : NSObject
+(instancetype)sharedAppData;

-(void)loadSettingBundleData;

@property (nonatomic) BOOL hasSharedVC;
@end
