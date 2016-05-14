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
#import "ChangePasswordViewController.h"
#import "WriteMessage ViewController.h"
@interface ViewUserProfileViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ViewUserProfileViewController


-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.backgroundColor=[UIColor clearColor];
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=NO;
    if (userdataArray.count==0) {
        [self.view.subviews setValue:@YES forKeyPath:@"hidden"]; // For Hiding All subview of View
        [self.view showLoader];
        [self performSelectorInBackground:@selector(getUserDetailsWebservice) withObject:nil];
    }
    self.navigationController.navigationBar.backgroundColor=navigation_background_Color;
    self.navigationController.navigationBar.barTintColor=navigation_background_Color;
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
}

-(void)getUserDetailsWebservice{
    NSString *apiURL =  [NSString stringWithFormat:@"%@action=%@&&userId=%@&publicId=%@",URL_CONST,ACTION_GET_USER_DETAILS,_userID,[UserData getUserID]];
    NSDictionary * dict = [[WebHandler sharedHandler]getDataFromWebservice:apiURL];
    if (dict) {
        [self performSelectorOnMainThread:@selector(setValues:) withObject:dict waitUntilDone:YES];
    }
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
    dict1 = @{@"key":@"Next Destination" ,@"value":[userDict valueForKey:@"next_destination"]};
    [userdataArray addObject:dict1];
    dict1 = @{@"key":@"Web Url" ,@"value":[userDict valueForKey:@"weburl"]};
    [userdataArray addObject:dict1];
  
    int followStatus =[[userDict valueForKey:@"follow"]intValue];
    if (followStatus==1) {
        //following
        followBtn.titleLabel.font=[UIFont fontWithName:fontIcomoon size:logo_Size_Small];
        followBtn.tintColor=[UIColor whiteColor];
        [followBtn setTitle:[NSString stringWithUTF8String:ICOMOON_USERICON_minus] forState:UIControlStateNormal];
        [followBtn setBackgroundColor:[UIColor redColor]];
    }else{
        followBtn.titleLabel.font=[UIFont fontWithName:fontIcomoon size:logo_Size_Small];
        followBtn.tintColor=[UIColor whiteColor];
        [followBtn setTitle:[NSString stringWithUTF8String:ICOMOON_USER_ICONPlus] forState:UIControlStateNormal];
         [followBtn setBackgroundColor:[UIColor greenColor]];
    }
    
    
    statusLbl.text = [userDict valueForKey:@"my_status"];
    if ([statusLbl.text isEqualToString:@""]) {
        statusLbl.text=@"No status set Yet !!!";
    }
    userNameLbl.text=[userDict valueForKey:@"name"];
    
    follower.text=[NSString stringWithFormat:@"%@",[dict valueForKey:@"follow_count"]];
    following.text=[NSString stringWithFormat:@"%@",[dict valueForKey:@"following_count"]];
    
    //Checked for post Image
    NSString * urlStringForPostImage =[userDict valueForKey:@"image"];
    if (![urlStringForPostImage isKindOfClass:[NSNull class]]) {
        NSURL * profileUrl =[NSURL URLWithString:urlStringForPostImage];
        [userImageView sd_setImageWithURL:profileUrl placeholderImage:[UIImage imageNamed:@"PlaceHolder"]];
    }
    [userImageView addBlackLayerAndCornerRadius:50 AndWidth:1];
    [imageBackgroundView addBlackLayerAndCornerRadius:55 AndWidth:3];
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
    [writeMsgBtn addBlackLayerAndCornerRadius:20 AndWidth:1];
    writeMsgBtn.titleLabel.font=[UIFont fontWithName:fontIcomoon size:logo_Size_Small];
    writeMsgBtn.tintColor=[UIColor whiteColor];
    [writeMsgBtn setTitle:[NSString stringWithUTF8String:ICOMOON_COMMENT1] forState:UIControlStateNormal];
    
    followBtn.titleLabel.font=[UIFont fontWithName:fontIcomoon size:logo_Size_Small];
    followBtn.tintColor=[UIColor whiteColor];
     [followBtn addBlackLayerAndCornerRadius:20 AndWidth:1];
    
    changeImageButton.titleLabel.font=[UIFont fontWithName:fontIcomoon size:logo_Size_Small];
    changeImageButton.tintColor=[UIColor whiteColor];
    [changeImageButton setTitle:[NSString stringWithUTF8String:ICOMOON_PHOTOCAMERA] forState:UIControlStateNormal];
     [changeImageButton addBlackLayerAndCornerRadius:18 AndWidth:1];
    
    if ([_userID isEqualToString:[UserData getUserID]]) {
        writeMsgBtn.hidden=YES;
        followBtn.hidden=YES;
        changeImageButton.hidden=NO;
        userNameLbl.text=[UserData getUserName];
        statusLbl.text=[UserData getUserMyStatus];
    }else{
        writeMsgBtn.hidden=NO;
        followBtn.hidden=NO;
        changeImageButton.hidden=YES;
    }
    tableHeight.constant= _viewProfileTableView.contentSize.height;
    [self.view layoutIfNeeded];
    [self.view hideLoader];
      [self.view.subviews setValue:@NO forKeyPath:@"hidden"]; // For Hiding All subview of View
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
                                [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    self.navigationController.navigationBar.backgroundColor=navigation_background_Color;
    self.navigationController.navigationBar.barTintColor=navigation_background_Color;
    
    self.navigationController.navigationItem.titleView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.width, 60) ];
    UIButton *btnClose = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnClose setFrame:CGRectMake(0, 0, 30, 30)];
    
    btnClose.titleLabel.font=[UIFont fontWithName:fontIcomoon size:logo_Size_Small];
    btnClose.tintColor=[UIColor whiteColor];
    
    if (_fromMenu==YES) {
        [btnClose setTitle:[NSString stringWithUTF8String:ICOMOON_MENU] forState:UIControlStateNormal];
        [btnClose addTarget:self action:@selector(toggleMenu) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [btnClose setTitle:[NSString stringWithUTF8String:ICOMOON_BACK_CIECLE_LEFT] forState:UIControlStateNormal];
        [btnClose addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    }
    UIBarButtonItem *leftbarButton = [[UIBarButtonItem alloc] initWithCustomView:btnClose];
    self.navigationItem.leftBarButtonItem = leftbarButton;
    
    
      if ([_userID isEqualToString:[UserData getUserID]]) {
    UIButton *btnSend = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnSend setFrame:CGRectMake(0, 0, 30, 30)];
    btnSend.titleLabel.font=[UIFont fontWithName:fontIcomoon size:logo_Size_Small];
    btnSend.tintColor=[UIColor whiteColor];
   [btnSend setTitle:[NSString stringWithUTF8String:ICOMOON_EDIT]  forState:UIControlStateNormal];
    [btnSend addTarget:self action:@selector(editClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *sendBarBtn = [[UIBarButtonItem alloc] initWithCustomView:btnSend];
    
    UIButton *pwdBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [pwdBtn setFrame:CGRectMake(0, 0, 30, 30)];
    pwdBtn.titleLabel.font=[UIFont fontWithName:fontIcomoon size:logo_Size_Small];
    pwdBtn.tintColor=[UIColor whiteColor];
    [pwdBtn setTitle:[NSString stringWithUTF8String:ICOMOON_KEY] forState:UIControlStateNormal];
    [pwdBtn addTarget:self action:@selector(changePassClick) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:pwdBtn];
        self.navigationItem.rightBarButtonItem = right;
    
    NSMutableArray *buttonArray=[[NSMutableArray alloc]init];
    [buttonArray addObject:sendBarBtn];
    [buttonArray addObject:right];
    self.navigationItem.rightBarButtonItems = buttonArray;
      }
}

-(void)changePassClick{
    ChangePasswordViewController * vc =[self.storyboard instantiateViewControllerWithIdentifier:@"ChangePasswordViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)editClick{
    SignUpViewController * vc =[self.storyboard instantiateViewControllerWithIdentifier:@"SignUpViewController"];
    vc.fromWhichMenu=@"Update";
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)toggleMenu{
    AppDelegate *d = [[UIApplication sharedApplication] delegate];
    [d.drawerView showLeftPanelAnimated:YES ];
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
    cell.value.text=[NSString stringWithFormat:@"%@",[[userdataArray objectAtIndex:indexPath.row]valueForKey:@"value"]];
    if ([cell.value.text isEqualToString:@""]) {
        cell.value.text=@"Not specified";
    }

    
    
    return cell;
}


#pragma mark - ImagePickerController Delegate
- (IBAction)clickonImage:(id)sender {
    UIImageView * imageview = userImageView;
    
    // Create image info
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
    imageInfo.image = imageview.image;
    imageInfo.referenceRect = imageview.frame;
    imageInfo.referenceView = self.view;
    imageInfo.referenceContentMode = imageview.contentMode;
    imageInfo.referenceCornerRadius = imageview.layer.cornerRadius;
    
    // Setup view controller
    JTSImageViewController *imageViewer = [[JTSImageViewController alloc]
                                           initWithImageInfo:imageInfo
                                           mode:JTSImageViewControllerMode_Image
                                           backgroundStyle:JTSImageViewControllerBackgroundOption_Scaled];
    
    // Present the view controller.
    [imageViewer showFromViewController:self transition:JTSImageViewControllerTransition_FromOriginalPosition];
    }



-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if(!iPAD) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    } else {
        [popover dismissPopoverAnimated:YES];
    }
    userImageView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self imageuploadWebservice];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)imageuploadWebservice{
    NSDictionary *parameters = @{
                                 @"action": ACTION_CHANGE_PROFILE_PIC,
                                 @"userId": [UserData getUserID],
                                 };
    [[WebHandler sharedHandler]uploadDataWithImage:userImageView.image forKey:@"userFile" andParameters:parameters OnUrl:URL_CONST completion:^(NSDictionary *dict) {
        if (dict) {
            int status =[[dict valueForKey:@"status"] intValue];
            if (status == 1) {
                [UserData setImageUrl:[dict valueForKey:@"image"]];
            }
        }
    }];
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


- (IBAction)changeImageButtonClick:(id)sender {
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
                                 [self dismissViewControllerAnimated:YES completion:nil];
                                 [self btnCameraClick];
                                 
                             }];
    UIAlertAction* gallery = [UIAlertAction
                              actionWithTitle:@"Gallery"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  [self dismissViewControllerAnimated:YES completion:nil];
                                  [self btnGalleryClick];
                                  
                              }];
    
    [view addAction:ok];
    [view addAction:gallery];
    [view addAction:camera];
    CGPoint windowPoint = [userImageView convertPoint:userImageView.bounds.origin toView:self.view.window];
    view.popoverPresentationController.sourceView = self.view;
    view.popoverPresentationController.sourceRect = CGRectMake(userImageView.frame.origin.x, windowPoint.y+15, userImageView.frame.size.width, userImageView.frame.size.height);;
    [self presentViewController: view animated:YES completion:nil];

}

- (IBAction)followClick:(id)sender {
    
    if ([followBtn.titleLabel.text isEqualToString:[NSString stringWithUTF8String:ICOMOON_USERICON_minus]]) {
        //following
        followBtn.titleLabel.font=[UIFont fontWithName:fontIcomoon size:logo_Size_Small];
        followBtn.tintColor=[UIColor whiteColor];
        [followBtn setTitle:[NSString stringWithUTF8String:ICOMOON_USER_ICONPlus] forState:UIControlStateNormal];
        [followBtn setBackgroundColor:[UIColor greenColor]];
    }else{
        followBtn.titleLabel.font=[UIFont fontWithName:fontIcomoon size:logo_Size_Small];
        followBtn.tintColor=[UIColor whiteColor];
        [followBtn setTitle:[NSString stringWithUTF8String:ICOMOON_USERICON_minus] forState:UIControlStateNormal];
        [followBtn setBackgroundColor:[UIColor redColor]];
    }
     [self performSelectorInBackground:@selector(followWebservice) withObject:nil];
    
}

-(void)followWebservice{
    NSString * publicId =_userID;
    NSString * userID =[UserData getUserID];
    NSString *apiURL =  [NSString stringWithFormat:@"%@action=%@&userId=%@&publicId=%@",URL_CONST,ACTION_ADD_FOLLOWER, userID,publicId];
    [[WebHandler sharedHandler]getDataFromWebservice:apiURL];
  
}


- (IBAction)messgeClick:(id)sender {
    WriteMessage_ViewController * vc=[self.storyboard instantiateViewControllerWithIdentifier:@"WriteMessage_ViewController"];
    vc.publicId=_userID;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
