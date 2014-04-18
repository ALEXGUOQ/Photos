//
//  ImageCell.h
//  Photos
//
//  Created by song on 14-3-17.
//  Copyright (c) 2014年 tag_ux. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCell : UICollectionViewCell
{
    UIImageView *imageView;
}
-(void)loadWithALAsset:(ALAsset*)asset;

@end
