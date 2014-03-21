//
//  GroupDetailVC.h
//  Photos
//
//  Created by song on 14-3-21.
//  Copyright (c) 2014年 tag_ux. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupDetailVC : UIViewController
{
    UICollectionView *myCollectionView;
}
@property (nonatomic,retain) ALAssetsGroup *group;
@end
