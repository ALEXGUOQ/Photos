//
//  Layouts.m
//  Photos
//
//  Created by song on 14-3-17.
//  Copyright (c) 2014年 tag_ux. All rights reserved.
//
#import "ToolKit.h"
#import "Layouts.h"

@implementation Layouts
+(UICollectionViewFlowLayout*)flowLayoutFourEachLine
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(78, 78);
    layout.minimumInteritemSpacing = 2;
    layout.minimumLineSpacing = 2;
    
    return layout;
}


+(UICollectionViewFlowLayout*)flowLayoutFullScreen
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(320, [ToolKit screenHeight]);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    return layout;
}
@end
