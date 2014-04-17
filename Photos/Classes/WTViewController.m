//
//  WTViewController.m
//  Photos
//
//  Created by tag_mac_05 on 14-4-17.
//  Copyright (c) 2014年 tag_ux. All rights reserved.
//

#import "WTViewController.h"
#import "AppData.h"
#import "ImageCell.h"
@interface WTViewController ()

@end

@implementation WTViewController
+(NSString*)reuseId
{
    return @"reuseId";
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        [self.collectionView registerClass:[ImageCell class] forCellWithReuseIdentifier:[WTViewController reuseId]];
        [self.collectionView setBackgroundColor:[UIColor redColor]];
        
        
        
        
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.collectionViewLayout invalidateLayout];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserverForName:AppDataRefreshDataNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
//        UIViewController *top = self.navigationController.topViewController;
        [self.collectionView reloadData];
        //            [self.collectionViewLayout invalidateLayout];
        //            [self.collectionView reloadData];
    }];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AppDataRefreshDataNotification object:nil];
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


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    NSInteger number = 0;
    AppData *data  =[AppData sharedAppData];
    switch (data.collectionMode) {
        case CollectionModeYear:
        {
            number = [data.yearsArray count];
        }
            break;
        case CollectionModeCollection:
        {
            number = [data.collectionsArray count];
        }
            break;
        case CollectionModeMoment:
        {
            number = [data.momentsArray count];
        }
            break;
        case CollectionModeFullScreen:
        {
            number = 1;
        }
            break;
            
        default:
            break;
    }
    return number;
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger number = 0;
    AppData *data  =[AppData sharedAppData];
    switch (data.collectionMode) {
        case CollectionModeYear:
        {
            number = [data.yearsArray[section] count];
        }
            break;
            case CollectionModeCollection:
        {
            NSArray *array = data.collectionsArray[section];
            number = [array count];

        }
            break;
            case CollectionModeMoment:
        {
            number = [data.momentsArray[section] count];
        }
            break;
            case CollectionModeFullScreen:
        {
            number = [data.allArray count];
        }break;
            
        default:
            break;
    }
    return number;
    
}
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    

    
    NSString *reuseId = [WTViewController reuseId];
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseId forIndexPath:indexPath];
    
    
    AppData *data  =[AppData sharedAppData];
    ALAsset *asset = nil;
    
    
//    asset = data.allArray[indexPath.row];
//    [cell loadWithALAsset:asset];
    switch (data.collectionMode) {
        case CollectionModeYear:
        {
            asset = data.yearsArray[indexPath.section][indexPath.row];
            [cell loadWithALAsset:asset];
        }
            break;
        case CollectionModeCollection:
        {
            asset = data.collectionsArray[indexPath.section][indexPath.row];
            [cell loadWithALAsset:asset];
        }break;
        case CollectionModeMoment:
        {
            asset = data.momentsArray[indexPath.section][indexPath.row];
            [cell loadWithALAsset:asset];
        }break;
        case CollectionModeFullScreen:
        {
            asset = data.allArray[indexPath.row];
            [cell loadWithFullScreen:asset];
        }break;
            
        default:
            break;
    }
    return cell;
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
