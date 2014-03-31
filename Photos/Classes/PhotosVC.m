//
//  PhotosVC.m
//  Photos
//
//  Created by tag_mac_05 on 14-3-17.
//  Copyright (c) 2014年 tag_ux. All rights reserved.
//

#import "PhotosVC.h"
#import "MapViewController.h"
#import "CollectionViewController.h"
@interface PhotosVC ()

@end

@implementation PhotosVC

#pragma mark - UICollectionViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {

    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

//        NSLog(@"%ld",(long)NSIntegerMax);
    


    [self confgiModel];
    [self configView];
    [self loadData];

    
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


#pragma mark - Model
-(void)confgiModel
{
    yearsArray = [[NSMutableArray alloc] init];
    collectionsArray = [[NSMutableArray alloc] init];
    momentsArray = [[NSMutableArray alloc] init];
    collectionMode = CollectionModeYear;
}

-(void)loadData
{
    NSMutableArray *allYears = [[NSMutableArray alloc] init];
    NSMutableArray *allAssets = [[NSMutableArray alloc] init];
    for (int i=0; i<200; i++) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [allYears addObject:array];
    }

    ALAssetsLibrary *library = [ToolKit sharedAssetsLibrary];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    [library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            
            [group setAssetsFilter:[ALAssetsFilter allAssets]];
            
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                if (result) {
                    //                    [allAsset addObject:result];
                    NSDate *date = [result valueForProperty:ALAssetPropertyDate];
                    NSInteger index = [[formatter stringFromDate:date] integerValue];
                    index = index-1990;
                    NSMutableArray *array = allYears[index];
                    if (![array containsObject:result]) {
                        [array addObject:result];
                    }
                    
                    if (![allAssets containsObject:result]) {
                        [allAssets addObject:result];
                    }
                    
                }
            }];
        }else
        {
//                NSLog(@"枚举完成");
            
            
//  ------------------------------年度------------------------------
            [yearsArray removeAllObjects];
            for (NSMutableArray *array in allYears) {
                if ([array count]>0) {
                    [yearsArray addObject:array];
                }
            }
            
            

//  ------------------------------精选------------------------------
            for (int i=0; i<[allAssets count]; i++) {
                if ([collectionsArray count]==0) {
                    NSMutableArray *collect = [[NSMutableArray alloc] init];
                    [collectionsArray addObject:collect];
                    [collect addObject:allAssets[0]];
                }else
                {
                    NSMutableArray *array = [collectionsArray lastObject];
                    ALAsset *asset1 = [array lastObject];
                    ALAsset *asset2 = allAssets[i];
                    BOOL isInSameCollection = [self alasset:asset1 isInSameCollectionWith:asset2];
                    if (isInSameCollection) {
                        [array addObject:asset2];
                    }else
                    {
                        NSMutableArray *newCollection = [[NSMutableArray alloc] init];
                        [newCollection addObject:asset2];
                        [collectionsArray addObject:newCollection];
                    }
                }
                
            }
            
            
//  ------------------------------时刻------------------------------
            
            
            
            
            
            
            [self.collectionView reloadData];
        }
    } failureBlock:^(NSError *error) {
        
    }];
}

//是否在同一个精选组
-(BOOL)alasset:(ALAsset*)asset1 isInSameCollectionWith:(ALAsset*)asset2
{
    BOOL isInSameCollection = NO;
    if (asset1 && asset2) {
        CLLocation* location1 = [asset1 valueForProperty:ALAssetPropertyLocation];
        CLLocation* location2 = [asset2 valueForProperty:ALAssetPropertyLocation];
        NSDate *date1 = [asset1 valueForProperty:ALAssetPropertyDate];
        NSDate *date2 = [asset2 valueForProperty:ALAssetPropertyDate];
        NSTimeInterval time1 = [date1 timeIntervalSince1970];
        NSTimeInterval time2 = [date2 timeIntervalSince1970];
        
        
        CLLocationDistance distance = [location1 distanceFromLocation:location2];
        NSTimeInterval timeDistance = time2-time1;
        
        
       
        if (location1 && location2) {
            if (distance<50000 && timeDistance<3600*24*50) {
                isInSameCollection = YES;
            }
        }else
        {
            if (timeDistance<3600*24*2) {
                isInSameCollection = YES;
            }
        }
        
        
    }
    
    
    return isInSameCollection;
}

-(BOOL)alasset:(ALAsset*)asset1 isInSameMomentWith:(ALAsset*)asset2
{
    BOOL isInSameCollection = NO;
    if (asset1 && asset2) {
        CLLocation* location1 = [asset1 valueForProperty:ALAssetPropertyLocation];
        CLLocation* location2 = [asset2 valueForProperty:ALAssetPropertyLocation];
        NSDate *date1 = [asset1 valueForProperty:ALAssetPropertyDate];
        NSDate *date2 = [asset2 valueForProperty:ALAssetPropertyDate];
        NSTimeInterval time1 = [date1 timeIntervalSince1970];
        NSTimeInterval time2 = [date2 timeIntervalSince1970];
        CLLocationDistance distance = [location1 distanceFromLocation:location2];
        if (!location1) {
            return isInSameCollection;
        }
        if (!location2) {
            return isInSameCollection;
        }
        if (distance<2000 && (time2-time1)<3600*24*50) {
            isInSameCollection = YES;
        }
        
    }
    
    
    return isInSameCollection;
}
#pragma mark - Control

#pragma mark - View
-(void)configView
{
    self.navigationController.navigationBar.translucent = NO;
    
    self.title = NSLocalizedString(@"Years", @"Years");
    self.tabBarItem.title = NSLocalizedString(@"Photos", nil);
 
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[ImageCell class] forCellWithReuseIdentifier:@"ImageCell"];
    [self.collectionView registerClass:[YearHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YearHeader"];
    
    [self.view addSubview:self.collectionView];
//    self.collectionView.delegate = self;
//    [self.collectionView setCollectionViewLayout:[Layouts flowLayoutYear]];
    
}

#pragma mark - UINavigationControllerDelegate


#pragma mark - YearHeaderDelegate
-(void)yearHeaderPressed:(YearHeader*)header
{
    MapViewController *map = [[MapViewController alloc] init];
    map.title = [header yearText];
    map.images = yearsArray[header.sectionIndex];
    [self.navigationController pushViewController:map animated:YES];
}

#pragma mark - UIViewControllerRotation
- (BOOL)shouldAutorotate
{
    return YES;
}
/*
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}
 */
/*
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    self.collectionView.frame = self.view.bounds;
    [self.collectionView.collectionViewLayout invalidateLayout];
}
 */

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    
    self.collectionView.frame = self.view.bounds;
    [self.collectionView.collectionViewLayout invalidateLayout];
//    [self.collectionView reloadData];
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewFlowLayout *layout = [Layouts flowLayoutCollections];
    //                    collectionMode = CollectionModeCollection;
    
    CollectionViewController *vc = [[CollectionViewController alloc] initWithCollectionViewLayout:layout];
    
    vc.title = NSLocalizedString(@"Collections", nil);
    vc.useLayoutToLayoutNavigationTransitions = YES;
    vc.collectionsArray = collectionsArray;
    [vc.collectionView performBatchUpdates:^{

    } completion:^(BOOL finished) {
        
    }];
    [self.navigationController pushViewController:vc animated:YES];
}
- (UICollectionViewTransitionLayout *)collectionView:(UICollectionView *)collectionView transitionLayoutForOldLayout:(UICollectionViewLayout *)fromLayout newLayout:(UICollectionViewLayout *)toLayout
{
    SWTTransitionLayout *layout = [[SWTTransitionLayout alloc] initWithCurrentLayout:fromLayout nextLayout:toLayout];
    return layout;
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{

            return [yearsArray count];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

            NSArray *array = yearsArray[section];
            return [array count];
            

    
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        YearHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YearHeader" forIndexPath:indexPath];
        header.delegate = self;
        header.sectionIndex = indexPath.section;
        
        NSArray *year = yearsArray[indexPath.section];
        ALAsset *asset = [year lastObject];
        NSDate *date = [asset valueForProperty:ALAssetPropertyDate];
        NSDateFormatter *formatter = [ToolKit yearDateFormatter];
        NSString *string = [formatter stringFromDate:date];
        string = [NSString stringWithFormat:@" %@",string];
        [header setYearText:string];
        return header;
    }
    return nil;
}


// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
  
    NSArray *array = yearsArray[indexPath.section];
    ALAsset *asset = array[indexPath.row];
    [cell loadWithALAsset:asset];

    
    return cell;
}

@end
