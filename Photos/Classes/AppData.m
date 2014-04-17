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
        
//        AppDataRefreshDataNotification = @"AppDataRefreshDataNotification";
        
        _collectionMode = CollectionModeMoment;
        
//        UIApplication
        self.yearsArray = [[NSMutableArray alloc] init];
        self.collectionsArray = [[NSMutableArray alloc] init];
        self.momentsArray = [[NSMutableArray alloc] init];
        self.allArray = [[NSMutableArray alloc] init];
        
        [self loadData];
    }
    return self;
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
            [_yearsArray removeAllObjects];
            for (NSMutableArray *array in allYears) {
                if ([array count]>0) {
                    [_yearsArray addObject:array];
                }
            }
            
            
            
            //  ------------------------------精选------------------------------
            for (int i=0; i<[allAssets count]; i++) {
                if ([_collectionsArray count]==0) {
                    NSMutableArray *collect = [[NSMutableArray alloc] init];
                    [_collectionsArray addObject:collect];
                    [collect addObject:allAssets[0]];
                }else
                {
                    NSMutableArray *array = [_collectionsArray lastObject];
                    ALAsset *asset1 = [array lastObject];
                    ALAsset *asset2 = allAssets[i];
                    BOOL isInSameCollection = [self alasset:asset1 isInSameCollectionWith:asset2];
                    if (isInSameCollection) {
                        [array addObject:asset2];
                    }else
                    {
                        NSMutableArray *newCollection = [[NSMutableArray alloc] init];
                        [newCollection addObject:asset2];
                        [_collectionsArray addObject:newCollection];
                    }
                }
                
            }
            
            
            //  ------------------------------时刻------------------------------
            for (int i=0; i<[allAssets count]; i++) {
                if ([_collectionsArray count]==0) {
                    NSMutableArray *collect = [[NSMutableArray alloc] init];
                    [_collectionsArray addObject:collect];
                    [collect addObject:allAssets[0]];
                }else
                {
                    NSMutableArray *array = [_collectionsArray lastObject];
                    ALAsset *asset1 = [array lastObject];
                    ALAsset *asset2 = allAssets[i];
                    BOOL isInSameCollection = [self alasset:asset1 isInSameMomentWith:asset2];
                    if (isInSameCollection) {
                        [array addObject:asset2];
                    }else
                    {
                        NSMutableArray *newCollection = [[NSMutableArray alloc] init];
                        [newCollection addObject:asset2];
                        [_momentsArray addObject:newCollection];
                    }
                }
                
            }
            
            
            
            
            //  ------------------------------全部------------------------------
            [self.allArray addObjectsFromArray:allAssets];
            
            
            [[NSNotificationCenter defaultCenter] postNotificationName:AppDataRefreshDataNotification object:nil];
//            [self.collectionView reloadData];
        }
    } failureBlock:^(NSError *error) {
        
    }];
}


//是否在同一个精选组
-(BOOL)alasset:(ALAsset*)asset1 isInSameCollectionWith:(ALAsset*)asset2
{
    BOOL isInSameCollection = NO;
    if (asset1 && asset2) {
        CLLocation* location1 = [asset1 valueForProperty:ALAssetPropertyLocation];
        CLLocation* location2 = [asset2 valueForProperty:ALAssetPropertyLocation];
        NSDate *date1 = [asset1 valueForProperty:ALAssetPropertyDate];
        NSDate *date2 = [asset2 valueForProperty:ALAssetPropertyDate];
        NSTimeInterval time1 = [date1 timeIntervalSince1970];
        NSTimeInterval time2 = [date2 timeIntervalSince1970];
        
        
        CLLocationDistance distance = [location1 distanceFromLocation:location2];
        NSTimeInterval timeDistance = time2-time1;
        
        
        
        if (location1 && location2) {
            if (distance<50000 && timeDistance<3600*24*50) {
                isInSameCollection = YES;
            }
        }else
        {
            if (timeDistance<3600*24*2) {
                isInSameCollection = YES;
            }
        }
        
        
    }
    
    
    return isInSameCollection;
}


//是否在同一个时刻
-(BOOL)alasset:(ALAsset*)asset1 isInSameMomentWith:(ALAsset*)asset2
{
    BOOL isInSameCollection = NO;
    if (asset1 && asset2) {
        CLLocation* location1 = [asset1 valueForProperty:ALAssetPropertyLocation];
        CLLocation* location2 = [asset2 valueForProperty:ALAssetPropertyLocation];
        NSDate *date1 = [asset1 valueForProperty:ALAssetPropertyDate];
        NSDate *date2 = [asset2 valueForProperty:ALAssetPropertyDate];
        NSTimeInterval time1 = [date1 timeIntervalSince1970];
        NSTimeInterval time2 = [date2 timeIntervalSince1970];
        
        
        CLLocationDistance distance = [location1 distanceFromLocation:location2];
        NSTimeInterval timeDistance = time2-time1;
        
        
        
        if (location1 && location2) {
            if (distance<50000 && timeDistance<3600*24*5) {
                isInSameCollection = YES;
            }
        }else
        {
            if (timeDistance<3600*24*7) {
                isInSameCollection = YES;
            }
        }
        
        
    }
    
    
    return isInSameCollection;
}

-(void)loadSettingBundleData
{
//    enabled_preference
    
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    BOOL hasPhotoStream = [[defaults objectForKey:@"enabled_preference"] boolValue];
    self.hasSharedVC = hasPhotoStream;
}


@end
