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

+(void)writeImageWithCollections:(NSArray*)collectionArray
{
    NSString *documentDir = [NSString stringWithFormat:@"%@/Documents",NSHomeDirectory()];
    for (int i=0; i<[collectionArray count]; i++) {
        NSArray *array = collectionArray[i];
        for (int j=0; j<[array count]; j++) {
            ALAsset *asset = array[j];
            UIImage *image = [UIImage imageWithCGImage:[asset thumbnail]];
            NSData *data = UIImagePNGRepresentation(image);
            NSString *path = [NSString stringWithFormat:@"%@/第%d组第%d张.png",documentDir,i,j];
            [data writeToFile:path atomically:YES];
        }
    }
}


+(NSDateFormatter*)yearDateFormatter
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    return formatter;
}




#pragma mark - Layout

//一行4个
+(UICollectionViewFlowLayout*)flowLayoutFourEachLine
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(78, 78);
    layout.minimumInteritemSpacing = 2;
    layout.minimumLineSpacing = 2;
    
    return layout;
}

//全屏
+(UICollectionViewFlowLayout*)flowLayoutFullScreen
{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(320, [ToolKit screenHeight]);
    //    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 40;
    layout.footerReferenceSize = CGSizeMake(40, [ToolKit screenHeight]);
    return layout;
}


//32个 10*10 像素
+(UICollectionViewFlowLayout*)flowLayoutYear
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(10, 10);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.headerReferenceSize = CGSizeMake(320, 40);
    return layout;
}

//32个 10*10 像素
+(UICollectionViewFlowLayout*)flowLayoutCollections
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(32, 32);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.headerReferenceSize = CGSizeMake(320, 40);
    return layout;
}


//时刻
+(UICollectionViewFlowLayout*)flowLayoutMoments
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(78.5, 78.5);
    layout.minimumInteritemSpacing = 2;
    layout.minimumLineSpacing = 2;
    layout.headerReferenceSize = CGSizeMake(320, 40);
    return layout;
}
@end
