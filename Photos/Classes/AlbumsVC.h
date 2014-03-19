//  相簿
//  AlbumsVC.h
//  Photos
//
//  Created by tag_mac_05 on 14-3-17.
//  Copyright (c) 2014年 tag_ux. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
@interface AlbumsVC : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    
    
    ALAssetsLibrary *library;
    IBOutlet UITableView *myTableView;
    
    NSMutableArray *groupInfo;
    
    
    
    UIAlertView *alert;
}
@end
