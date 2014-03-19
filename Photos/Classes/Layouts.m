//
//  Layouts.m
//  Photos
//
//  Created by song on 14-3-17.
//  Copyright (c) 2014年 tag_ux. All rights reserved.
//

#import "Layouts.h"

@implementation Layouts
+(UICollectionViewFlowLayout*)flowLayout
{
    
//     6 + 4x = 320
    /*
     4x = 320-6 = 224
     224/4 = 56
     x =
     */
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(78.5, 78.5);
    layout.minimumInteritemSpacing = 2;
    layout.minimumLineSpacing = 2;
    
    
    
    return layout;
}
@end
