//
//  PhotosVC.h
//  Photos
//
//  Created by tag_mac_05 on 14-3-17.
//  Copyright (c) 2014年 tag_ux. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "Layouts.h"
#import "ImageCell.h"
#import "YearHeader.h"
#import "SWTTransitionLayout.h"
@import CoreLocation;

typedef NS_ENUM(NSInteger, CollectionMode) {
    CollectionModeYear,                 // 年
    CollectionModeCollection,           // 精选
    CollectionModeMoment,               // 时刻
};
@interface PhotosVC : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate>
{
//    年度
    NSMutableArray *yearsArray;
    
//    精选
    NSMutableArray *collectionsArray;
    
//    时刻
    NSMutableArray *momentsArray;
    
    UICollectionView *myCollectionView;
    
    
    CollectionMode collectionMode;
    
}
@end
