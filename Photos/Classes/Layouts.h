//
//  Layouts.h
//  Photos
//
//  Created by song on 14-3-17.
//  Copyright (c) 2014年 tag_ux. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Layouts : NSObject

//一行四个
+(UICollectionViewFlowLayout*)flowLayoutFourEachLine;

//全屏
+(UICollectionViewFlowLayout*)flowLayoutFullScreen;

//年份
+(UICollectionViewFlowLayout*)flowLayoutYear;

//精选
+(UICollectionViewFlowLayout*)flowLayoutCollections;


//时刻
+(UICollectionViewFlowLayout*)flowLayoutMoments;
@end
