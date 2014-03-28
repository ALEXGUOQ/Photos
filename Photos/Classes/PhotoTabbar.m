//
//  PhotoTabbar.m
//  Photos
//
//  Created by tag_mac_05 on 14-3-19.
//  Copyright (c) 2014年 tag_ux. All rights reserved.
//
#import "ToolKit.h"
#import "PhotoTabbar.h"

@interface PhotoTabbar ()

@end

@implementation PhotoTabbar

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSMutableArray *array = [NSMutableArray new];
    [array addObject:@"Photos"];
    [array addObject:@"Shared"];
    [array addObject:@"Albums"];
    //    arrayWithObjects:@"Photos","Shared",@"Albums",nil
    for (int i=0;i<[self.tabBar.items count];i++) {
        UITabBarItem *item = self.tabBar.items[i];
        item.title = NSLocalizedString(array[i], nil);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
