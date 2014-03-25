//
//  ToolKit.m
//  Photos
//
//  Created by tag_mac_05 on 14-3-19.
//  Copyright (c) 2014年 tag_ux. All rights reserved.
//

#import "ToolKit.h"

@implementation ToolKit

//AssetsLibrary *library = nil;
static ALAssetsLibrary *library;
+(ALAssetsLibrary*)sharedAssetsLibrary
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        library = [[ALAssetsLibrary alloc] init];
    });
    return library;
}

+(UIUserInterfaceIdiom)deviceIdiom
{
    UIDevice *decive = [UIDevice currentDevice];
    UIUserInterfaceIdiom interface = decive.userInterfaceIdiom;
    return interface;
}


+(CGFloat)screenHeight
{
    UIScreen *sc = [UIScreen mainScreen];
    return CGRectGetHeight(sc.bounds);
}
+(BOOL)isIphone
{
    UIDevice *decive = [UIDevice currentDevice];
    UIUserInterfaceIdiom interface = decive.userInterfaceIdiom;
    if (interface == UIUserInterfaceIdiomPhone) {
        return YES;
    }else
    {
        return NO;
    }
}
@end
