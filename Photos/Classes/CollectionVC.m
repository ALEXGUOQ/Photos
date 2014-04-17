//
//  CollectionVC.m
//  Photos
//
//  Created by tag_mac_05 on 14-4-17.
//  Copyright (c) 2014年 tag_ux. All rights reserved.
//

#import "CollectionVC.h"
#import "ToolKit.h"
#import "MomentVC.h"
@interface CollectionVC ()

@end

@implementation CollectionVC

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MomentVC *moment = [[MomentVC alloc] initWithCollectionViewLayout:[ToolKit flowLayoutMoments]];
    
    [self.navigationController pushViewController:moment animated:YES];
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
