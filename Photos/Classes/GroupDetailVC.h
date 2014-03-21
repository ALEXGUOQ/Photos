//
//  GroupDetailVC.h
//  Photos
//
//  Created by song on 14-3-21.
//  Copyright (c) 2014年 tag_ux. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, ImageMode) {
    ImageModeSmall,         // slow at beginning and end
    ImageModeBig
};
@interface GroupDetailVC : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate>
{
    ImageMode imageMode;
    
    UICollectionView *myCollectionView;
    NSMutableArray *assetsInfoArray;
}
@property (nonatomic,retain) ALAssetsGroup *group;
@end
