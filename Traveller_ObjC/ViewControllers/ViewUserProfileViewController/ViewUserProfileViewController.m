//
//  ViewUserProfileViewController.m
//  Traveller_ObjC
//
//  Created by Sagar Shirbhate on 14/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import "ViewUserProfileViewController.h"
#import "SignUpViewController.h"
#import "ViewProfileTableViewCell.h"
@interface ViewUserProfileViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ViewUserProfileViewController
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=NO;
    [self.view showLoader];
    [self performSelectorInBackground:@selector(getUserDetailsWebservice) withObject:nil];
}

-(void)getUserDetailsWebservice{
    NSString *apiURL =  [NSString stringWithFormat:@"%@action=%@&&userId=%@&publicId=%@",URL_CONST,ACTION_GET_USER_DETAILS,[UserData getUserID],_userID];
    NSDictionary * dict = [[WebHandler sharedHandler]getDataFromWebservice:apiURL];
    [self performSelectorOnMainThread:@selector(setValues:) withObject:dict waitUntilDone:YES];

}

-(void)setValues:(NSDictionary *)dict {
    
    userdataArray =[NSMutableArray new];
    NSDictionary * userDict =[[dict valueForKey:@"data"]lastObject ];
    NSDictionary * dict1 = @{@"key":@"City" ,@"value":[userDict valueForKey:@"city"]};
    [userdataArray addObject:dict1];
    dict1 = @{@"key":@"State" ,@"value":[userDict valueForKey:@"state"]};
    [userdataArray addObject:dict1];
    dict1 = @{@"key":@"Country" ,@"value":[userDict valueForKey:@"country"]};
    [userdataArray addObject:dict1];
    dict1 = @{@"key":@"Email" ,@"value":[userDict valueForKey:@"email"]};
    [userdataArray addObject:dict1];
    dict1 = @{@"key":@"Mobile" ,@"value":[userDict valueForKey:@"mobile"]};
    [userdataArray addObject:dict1];
    dict1 = @{@"key":@"Destination" ,@"value":[userDict valueForKey:@"next_destination"]};
    [userdataArray addObject:dict1];
    dict1 = @{@"key":@"Web Url" ,@"value":[userDict valueForKey:@"weburl"]};
    [userdataArray addObject:dict1];
  
    statusLbl.text = [userDict valueForKey:@"my_status"];
    userNameLbl.text=[userDict valueForKey:@"name"];
    
    follower.text=[NSString stringWithFormat:@"%@",[dict valueForKey:@"follow_count"]];
    following.text=[NSString stringWithFormat:@"%@",[dict valueForKey:@"follow_count"]];
    
    //Checked for post Image
    NSString * urlStringForPostImage =[userDict valueForKey:@"image"];
    if (![urlStringForPostImage isKindOfClass:[NSNull class]]) {
        NSURL * profileUrl =[NSURL URLWithString:urlStringForPostImage];
        [userImageView sd_setImageWithURL:profileUrl placeholderImage:[UIImage imageNamed:@"PlaceHolder"]];
    }
    [userImageView addBlackLayerAndCornerRadius:50 AndWidth:1];
    userImageView.clipsToBounds=YES;
    [_viewProfileTableView reloadData];
    tableHeight.constant= _viewProfileTableView.contentSize.height;
    [self.view layoutIfNeeded];
    
    [self performSelector:@selector(setupView) withObject:nil afterDelay:1];
}
-(void)viewDidAppear:(BOOL)animated{
    tableHeight.constant= _viewProfileTableView.contentSize.height;
    [self.view layoutIfNeeded];
}
-(void)setupView{
    
    if ([_userID isEqualToString:[UserData getUserID]]) {
        if(iPAD){
            imageAboveHeight.constant=100;
        }else{
            imageAboveHeight.constant=10;
        }
        writeMsgBtn.hidden=YES;
        messageLogo.hidden=YES;
        followBtn.hidden=YES;
        followLogo.hidden=YES;
        userNameLbl.text=[UserData getUserName];
        statusLbl.text=[UserData getUserMyStatus];
    }else{
        if(iPAD){
            imageAboveHeight.constant=150;
        }
        writeMsgBtn.hidden=NO;
        messageLogo.hidden=NO;
        followBtn.hidden=NO;
        followLogo.hidden=NO;
    }
    tableHeight.constant= _viewProfileTableView.contentSize.height;
    [self.view layoutIfNeeded];
    [self.view hideLoader];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationBar];
    self.title=@"Profile";
 
    _viewProfileTableView.estimatedRowHeight=40;
    _viewProfileTableView.rowHeight=UITableViewAutomaticDimension;
}
-(void)setUpNavigationBar{
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont
                                                                           fontWithName:font_bold size:font_size_normal_regular], NSFontAttributeName,
                                [UIColor blackColor], NSForegroundColorAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    self.navigationController.navigationItem.titleView=[UIView new];
    UIButton *btnClose = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnClose setFrame:CGRectMake(0, 0, 30, 30)];
    
    btnClose.titleLabel.font=[UIFont fontWithName:fontIcomoon size:logo_Size_Small];
    btnClose.tintColor=[UIColor blackColor];
    [btnClose setTitle:[NSString stringWithUTF8String:ICOMOON_BACK_CIECLE_LEFT] forState:UIControlStateNormal];
    [btnClose addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftbarButton = [[UIBarButtonItem alloc] initWithCustomView:btnClose];
    self.navigationItem.leftBarButtonItem = leftbarButton;
    
    UIButton *btnSend = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnSend setFrame:CGRectMake(0, 0, 30, 30)];
    btnSend.titleLabel.font=[UIFont fontWithName:fontIcomoon size:logo_Size_Small];
    btnSend.tintColor=[UIColor blackColor];
   [btnSend setTitle:[NSString stringWithUTF8String:ICOMOON_EDIT]  forState:UIControlStateNormal];
    [btnSend addTarget:self action:@selector(editClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *sendBarBtn = [[UIBarButtonItem alloc] initWithCustomView:btnSend];
    NSMutableArray *buttonArray=[[NSMutableArray alloc]init];
    [buttonArray addObject:sendBarBtn];
    self.navigationItem.rightBarButtonItems = buttonArray;
}

-(void)editClick{
    SignUpViewController * vc =[self.storyboard instantiateViewControllerWithIdentifier:@"SignUpViewController"];
    vc.fromWhichMenu=@"Update";
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return userdataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ViewProfileTableViewCell * cell =[_viewProfileTableView dequeueReusableCellWithIdentifier:@"ViewProfileTableViewCell"];
    cell.title.text=[[userdataArray objectAtIndex:indexPath.row]valueForKey:@"key"];
    cell.value.text=[NSString stringWithFormat:@": %@",[[userdataArray objectAtIndex:indexPath.row]valueForKey:@"value"]];
    
    if (indexPath.row%2==0) {
        cell.backgroundColor=[UIColor lightGrayColor];
    }else{
        cell.backgroundColor=[UIColor whiteColor];
    }
    
    
    return cell;
}


#pragma mark - ImagePickerController Delegate

-(void)clickOnImage{
    UIAlertController * view=   [UIAlertController
                                 alertControllerWithTitle:@"Traweller"
                                 message:@"Change Profile picture"
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Cancel"
                         style:UIAlertActionStyleCancel
                         handler:^(UIAlertAction * action)
                         {
                             [self dismissViewControllerAnimated:YES completion:nil];
                         }];
    UIAlertAction* camera = [UIAlertAction
                           actionWithTitle:@"Camera"
                           style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action)
                           {
                               [self btnCameraClick];
                               [self dismissViewControllerAnimated:YES completion:nil];
                           }];
    UIAlertAction* gallery = [UIAlertAction
                             actionWithTitle:@"Gallery"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [self btnGalleryClick];
                                 [self dismissViewControllerAnimated:YES completion:nil];
                             }];
    
    [view addAction:ok];
    [view addAction:gallery];
    [view addAction:camera];
    CGPoint windowPoint = [userImageView convertPoint:userImageView.bounds.origin toView:self.view.window];
    view.popoverPresentationController.sourceView = self.view;
    view.popoverPresentationController.sourceRect = CGRectMake(userImageView.frame.origin.x, windowPoint.y+15, userImageView.frame.size.width, userImageView.frame.size.height);;
    [self presentViewController: view animated:YES completion:nil];
}



-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if(!iPAD) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    } else {
        [popover dismissPopoverAnimated:YES];
    }
    userImageView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)btnGalleryClick
{
    ipc= [[UIImagePickerController alloc] init];
    ipc.delegate = self;
    ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    if(!iPAD)
        [self presentViewController:ipc animated:YES completion:nil];
    else
    {
        ipc.modalPresentationStyle = UIModalPresentationPopover;
        ipc.popoverPresentationController.sourceView = userImageView;
        [self presentViewController:ipc animated:YES completion:nil];
    }
}

- (void)btnCameraClick
{
    ipc = [[UIImagePickerController alloc] init];
    ipc.delegate = self;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:ipc animated:YES completion:NULL];
    }
    else
    {
        [self.view makeToast:@"No Camera Available" duration:toastDuration position:toastPositionBottomUp];
    }
}


- (IBAction)followClick:(id)sender {
}

- (IBAction)messgeClick:(id)sender {
}
@end
