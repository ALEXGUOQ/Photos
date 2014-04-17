//
//  MomentViewController.m
//  Photos
//
//  Created by song on 14-3-30.
//  Copyright (c) 2014年 tag_ux. All rights reserved.
//

#import "MomentViewController.h"
#import "FullScreenCollectionVC.h"


@interface MomentViewController ()

@end

@implementation MomentViewController
-(instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.title = NSLocalizedString(@"Moments", nil);
        
    }
    return self;
    
}
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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Select", nil) style:UIBarButtonItemStylePlain target:self action:@selector(selectButtonPressed:)];
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.collectionView.pagingEnabled = NO;
    self.collectionView.alwaysBounceVertical = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Model
-(void)configModel
{
    editing = NO;
}

#pragma mark - Control
-(void)selectButtonPressed:(UIBarButtonItem*)sender
{
    if (editing) {
        sender.title = NSLocalizedString(@"Select", nil);

    }else
    {
        sender.title = NSLocalizedString(@"Deselect", nil);
        
        
    }
    
    editing = !editing;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FullScreenCollectionVC *full = [[FullScreenCollectionVC alloc] initWithCollectionViewLayout:[ToolKit flowLayoutFullScreen]];
    full.useLayoutToLayoutNavigationTransitions = YES;
    [self.navigationController pushViewController:full animated:YES];
}

#pragma mark - UICollectionViewDataSource

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
