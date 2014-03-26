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

@end
