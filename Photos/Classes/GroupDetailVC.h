//
//  GroupDetailVC.h
//  Photos
//
//  Created by song on 14-3-21.
//  Copyright (c) 2014年 tag_ux. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTTransitionLayout.h"

typedef NS_ENUM(NSInteger, ImageMode) {
    ImageModeSmall,         // slow at beginning and end
    ImageModeBig
};
@interface GroupDetailVC : UICollectionViewController <UICollectionViewDataSource,UICollectionViewDelegate>
{
    ImageMode imageMode;
    

    NSMutableArray *assetsInfoArray;
    
    
//    CGRect animationFrame;
}
@property (nonatomic) CGRect pressRect;
@property (nonatomic,retain) ALAssetsGroup *group;
@end
