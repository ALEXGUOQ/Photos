//
//  PhotoTabbar.m
//  Photos
//
//  Created by tag_mac_05 on 14-3-19.
//  Copyright (c) 2014年 tag_ux. All rights reserved.
//
#import "ToolKit.h"
#import "PhotoTabbar.h"
#import "PhotosVC.h"
#import "SharedVC.h"
#import "AlbumsVC.h"
#import "Layouts.h"
#import "AppData.h"
@interface PhotoTabbar ()

@end

@implementation PhotoTabbar

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSMutableArray *vcs = [[NSMutableArray alloc] init];
        
        PhotosVC *vc = [[PhotosVC alloc] initWithCollectionViewLayout:[Layouts flowLayoutYear]];
        UINavigationController *navi1 = [[UINavigationController alloc] initWithRootViewController:vc];
        [vcs addObject:navi1];
         if ([AppData sharedAppData].hasSharedVC) {
             SharedVC *shared = [[SharedVC alloc] init];
             UINavigationController *navi2 = [[UINavigationController alloc] initWithRootViewController:shared];
             [vcs addObject:navi2];
         }
        
        AlbumsVC *album = [[AlbumsVC alloc]init];
        UINavigationController *navi3 = [[UINavigationController alloc] initWithRootViewController:album];
        
        [vcs addObject:navi3];
        [self setViewControllers:vcs];
        
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
    if ([AppData sharedAppData].hasSharedVC) {
    [array addObject:@"Shared"];
    }
    [array addObject:@"Albums"];
    //    arrayWithObjects:@"Photos","Shared",@"Albums",nil
    for (int i=0;i<[self.tabBar.items count];i++) {
        UITabBarItem *item = self.tabBar.items[i];
        item.image = [UIImage imageNamed:@"first"];
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
