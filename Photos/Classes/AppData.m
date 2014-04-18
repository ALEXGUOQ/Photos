//
//  AppData.m
//  Photos
//
//  Created by tag_mac_05 on 14-3-31.
//  Copyright (c) 2014年 tag_ux. All rights reserved.
//

#import "AppData.h"
static AppData *sharedAppData = nil;
@implementation AppData
+(instancetype)sharedAppData
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedAppData = [[AppData alloc] init];
        
    });
    return sharedAppData;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.allArray = [[NSMutableArray alloc] init];
        [self loadSettingBundleData];
        [self loadData];
    }
    return self;
}

//判断是否有共享
-(void)loadSettingBundleData
{
//    enabled_preference
    
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    BOOL hasPhotoStream = [[defaults objectForKey:@"enabled_preference"] boolValue];
    self.hasSharedVC = hasPhotoStream;
}


-(void)loadData
{
    NSMutableArray *allYears = [[NSMutableArray alloc] init];
    NSMutableArray *allAssets = [[NSMutableArray alloc] init];
    for (int i=0; i<200; i++) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [allYears addObject:array];
    }
    
    ALAssetsLibrary *library = [ToolKit sharedAssetsLibrary];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    [library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            
            [group setAssetsFilter:[ALAssetsFilter allAssets]];
            
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                if (result) {
                    //                    [allAsset addObject:result];
                    NSDate *date = [result valueForProperty:ALAssetPropertyDate];
                    NSInteger index = [[formatter stringFromDate:date] integerValue];
                    index = index-1990;
                    NSMutableArray *array = allYears[index];
                    if (![array containsObject:result]) {
                        [array addObject:result];
                    }
                    
                    if (![allAssets containsObject:result]) {
                        [allAssets addObject:result];
                    }
                    
                }
            }];
        }else
        {
            //                NSLog(@"枚举完成");
            
            
            //  ------------------------------年度------------------------------
            [self.yearsArray removeAllObjects];
            for (NSMutableArray *array in allYears) {
                if ([array count]>0) {
                    [self.yearsArray addObject:array];
                }
            }
            
            
            
            //  ------------------------------精选------------------------------
            
            
            //  ------------------------------时刻------------------------------
            
            
            
            
            
            [[NSNotificationCenter defaultCenter] postNotificationName:AppDataDidRefreshALAssetsLibraryData object:nil];
        }
    } failureBlock:^(NSError *error) {
        
    }];
}


#pragma mark - Notifications
//刷新数据
NSString * const AppDataDidRefreshALAssetsLibraryData = @"AppDataDidRefreshALAssetsLibraryData";
@end
