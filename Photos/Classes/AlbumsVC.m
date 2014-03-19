//
//  AlbumsVC.m
//  Photos
//
//  Created by tag_mac_05 on 14-3-17.
//  Copyright (c) 2014年 tag_ux. All rights reserved.
//

#import "AlbumsVC.h"
#import "ImageTableViewCell.h"
@interface AlbumsVC ()

@end

@implementation AlbumsVC

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
        [self configModel];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Model
-(void)configModel
{
    groupInfo = [[NSMutableArray alloc] init];
    library = [[ALAssetsLibrary alloc] init];
    [self loadGroupInfo];
}

-(void)loadGroupInfo
{
//    NSLog(@"%@",[self groupsForType:ALAssetsGroupAll]);
    
 
    [groupInfo removeAllObjects];
    // Enumerate just the photos and videos group by using ALAssetsGroupSavedPhotos.
    [library enumerateGroupsWithTypes:ALAssetsGroupAll
                           usingBlock:^(ALAssetsGroup *group, BOOL *stop)
     {
         if (group) {
             [groupInfo addObject:group];
         }else
         {
             NSInteger saveIndex = -1;
             NSInteger photoStreamIndex = -1;
             for (int i=0;i<[groupInfo count];i++) {
                 ALAssetsGroup *g = groupInfo[i];
                 NSNumber *type = [g valueForProperty:ALAssetPropertyType];
                 if ([type integerValue]==ALAssetsGroupSavedPhotos) {
                     saveIndex = i;
                 }
                 
                 if ([type integerValue]==ALAssetsGroupPhotoStream) {
                     photoStreamIndex = i;
                 }
             }
             
             NSArray *array = [groupInfo sortedArrayWithOptions:NSSortStable usingComparator:^NSComparisonResult(ALAssetsGroup *obj1, ALAssetsGroup *obj2) {
                 NSInteger type1 = [[obj1 valueForProperty:ALAssetPropertyType] integerValue];
                 NSInteger type2 = [[obj2 valueForProperty:ALAssetPropertyType] integerValue];
                 

                 if (type1<type2) {
                     
//                     升序
                     return NSOrderedAscending;
                 }else
                 {
                     
//                     降序
                     return NSOrderedDescending;
                 }

                 
             }];
             [groupInfo removeAllObjects];
             [groupInfo addObjectsFromArray:array];
             
//             [groupInfo repl]
             
             
             
             [myTableView reloadData];
         }
        

     }
                            failureBlock: ^(NSError *error)
     {
         // Typically you should handle an error more gracefully than this.
         NSLog(@"No groups");
     }];
}


#pragma mark - View
-(void)configView
{
    [self configTitleAndBarButtons];
    [self configAlert];
    
    
    [myTableView registerClass:[ImageTableViewCell class] forCellReuseIdentifier:@"ImageTableViewCell"];
}
-(void)configTitleAndBarButtons
{
    
    UIBarButtonItem *leftbuttonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(reciveAddButton:)];
    
    self.navigationItem.leftBarButtonItem = leftbuttonItem;
    
    
    //    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [editButton setTitle:@"编辑" forState:UIControlStateNormal];
    UIBarButtonItem *rightbuttonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(reciveEditButton:)];
    self.navigationItem.rightBarButtonItem = rightbuttonItem;
    
//    myTableView = [[UITableView alloc] initWithFrame:self.view.frame];
//    [self.view addSubview:myTableView];
//    NSLog(@"%@",myTableView);
    
}
-(void)configAlert
{
    alert = [[UIAlertView alloc] initWithTitle:@"新建相簿" message:@"请为次相簿输入名称" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"存储", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *textField = [alert textFieldAtIndex:0];
    textField.placeholder = @"标题";

}

#pragma mark - Control
-(void)reciveAddButton:(UIBarButtonItem*)sender
{
    
    UITextField *textField = [alert textFieldAtIndex:0];
    textField.text = @"";
    
    [alert show];
    
//    UIButton *saveButton = [alert buttonTitleAtIndex:1];
//    UITextField *textField = [alert textFieldAtIndex:0];
    
}

-(void)reciveEditButton:(UIBarButtonItem*)sender
{
    if (myTableView.editing) {
        [sender setTitle:@"编辑"];
        [myTableView setEditing:NO animated:YES];
    }else
    {
        [myTableView setEditing:YES animated:YES];
        [sender setTitle:@"完成"];
    }
    
}


#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
//        确定
        UITextField *textField = [alert textFieldAtIndex:0];
        [library addAssetsGroupAlbumWithName:textField.text resultBlock:^(ALAssetsGroup *group) {
            
        } failureBlock:^(NSError *error) {
            
        }];

    }
}

- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView
{
    UITextField *textField = [alertView textFieldAtIndex:0];
    if ([textField.text length] == 0)
    {
        return NO;
    }
    return YES;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.imageView.frame = CGRectMake(8, 4, 70, 74);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    2*80=160   14/2 = 7
    return 87;
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [groupInfo count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseId = @"ImageTableViewCell";
    ImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId forIndexPath:indexPath];
    if (!cell) {
        cell = [[ImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
       
        
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    ALAssetsGroup *group = groupInfo[indexPath.row];
    
    

    cell.imageView.image = [UIImage imageWithCGImage:group.posterImage];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    cell.imageView.image = [UIImage imageNamed:@"test.png"];
//    UIViewContentMode mode = cell.imageView.contentMode;
//    UIImageView *a = [[UIImageView alloc] init];
    NSLog(@"%@",[group valueForProperty:ALAssetsGroupPropertyType]);
    cell.textLabel.text = [group valueForProperty:ALAssetsGroupPropertyName];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",[group numberOfAssets]];
    

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
