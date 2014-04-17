//
//  YearVC.m
//  Photos
//
//  Created by tag_mac_05 on 14-4-17.
//  Copyright (c) 2014年 tag_ux. All rights reserved.
//

#import "YearVC.h"
#import "CollectionVC.h"
#import "ToolKit.h"

@interface YearVC ()

@end

@implementation YearVC

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
    self.navigationController.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionVC *vc = [[CollectionVC alloc] initWithCollectionViewLayout:[ToolKit flowLayoutCollections]];
//    vc.useLayoutToLayoutNavigationTransitions = YES;
    [self.navigationController pushViewController:vc animated:YES];
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
