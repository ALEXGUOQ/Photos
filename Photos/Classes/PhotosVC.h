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
@interface PhotosVC : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate>
{
//    年度
    NSMutableArray *yearsArray;
    
//    精选
    NSMutableArray *collectionsArray;
    
//    时刻
    NSMutableArray *momentsArray;
    
    UICollectionView *myCollectionView;
}
@end
