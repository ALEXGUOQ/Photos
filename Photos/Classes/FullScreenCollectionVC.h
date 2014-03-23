//
//  FullScreenCollectionVC.h
//  Photos
//
//  Created by song on 14-3-23.
//  Copyright (c) 2014年 tag_ux. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FullScreenCollectionVC : UICollectionViewController <UINavigationBarDelegate>
{
    BOOL preferStatusBarHidden;
}
@property (nonatomic) NSInteger pageIndex;
@property (nonatomic,retain) ALAssetsGroup *group;
@end
