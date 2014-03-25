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

@interface PhotosVC : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSMutableArray *yearArray;
    UICollectionView *myCollectionView;
}
@end
