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


-(void)loadSettingBundleData
{
//    enabled_preference
    
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    BOOL name=[[defaults objectForKey:@"enabled_preference"] boolValue];
    if (name) {
        NSLog(@"yes");
    }else
    {
        NSLog(@"no");
    }
//    NSLog(@"=======%@",name);
    return;
    NSBundle *bundle = [NSBundle bundleWithPath:NSHomeDirectory()];
    NSString *path = [bundle pathForResource:@"Root" ofType:@"plist"];
    NSDictionary *settingsDict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSLog(@"%@",settingsDict);
}
@end
