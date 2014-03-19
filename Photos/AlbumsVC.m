//
//  AlbumsVC.m
//  Photos
//
//  Created by tag_mac_05 on 14-3-17.
//  Copyright (c) 2014年 tag_ux. All rights reserved.
//

#import "AlbumsVC.h"

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configModel];
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
    [self loadGroupInfo];
}

-(void)loadGroupInfo
{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    // Enumerate just the photos and videos group by using ALAssetsGroupSavedPhotos.
    [library enumerateGroupsWithTypes:ALAssetsGroupAll
                           usingBlock:^(ALAssetsGroup *group, BOOL *stop)
     {
         if (group) {
             [groupInfo addObject:group];
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
}
-(void)configTitleAndBarButtons
{
    self.title = @"相簿";
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

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"count:%d",[groupInfo count]);
    return [groupInfo count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseId = @"UITableViewCell";
    UITableViewCell *cell;
//    cell = [tableView dequeueReusableCellWithIdentifier:reuseId forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    ALAssetsGroup *group = groupInfo[indexPath.row];
    cell.imageView.image = [UIImage imageWithCGImage:group.posterImage];
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
