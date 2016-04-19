//
//  WIshedToViewController.m
//  Traveller_ObjC
//
//  Created by Sagar Shirbhate on 14/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import "WIshedToViewController.h"
#import "FollowingTableViewCell.h"
@interface WIshedToViewController ()

@end

@implementation WIshedToViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationBar];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{
    [self.view showLoader];
    [self performSelectorInBackground:@selector(getWishToData) withObject:nil];
}

-(void)setUpNavigationBar{
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont
                                                                           fontWithName:font_bold size:22], NSFontAttributeName,
                                back_btn_Color, NSForegroundColorAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    UIButton *btnClose = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnClose setFrame:CGRectMake(0, 0, 30, 30)];
    
    btnClose.titleLabel.font=[UIFont fontWithName:fontIcomoon size:logo_Size_Small];
    btnClose.tintColor=back_btn_Color;
    //  [btnClose setTitle:[FontIcon iconString:ICON_CANCEL] forState:UIControlStateNormal];
    [btnClose addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftbarButton = [[UIBarButtonItem alloc] initWithCustomView:btnClose];
    self.navigationItem.leftBarButtonItem = leftbarButton;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return wishedToData.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UINib *nib = [UINib nibWithNibName:@"FollowingTableViewCell" bundle:nil];
    [wishTableView registerNib:nib forCellReuseIdentifier:@"FollowingTableViewCell"];
    FollowingTableViewCell *cell =  [wishTableView dequeueReusableCellWithIdentifier:@"FollowingTableViewCell"];
    
    NSDictionary * dataDict =[wishedToData objectAtIndex:indexPath.row];
    NSString * name =[dataDict valueForKey:@"name"];
     NSString * city =[dataDict valueForKey:@"city"];
    if (![name isKindOfClass:[NSNull class]]) {
        cell.nameLbl.text=name;
    }else {
        cell.nameLbl.text=@"Name Is Not Available Now";
    }
    
    if (![city isKindOfClass:[NSNull class]]) {
        cell.addressLbl.text=city;
    }else {
        cell.addressLbl.text=@"City Is Not Available Now";
    }
    
    
    
    int followStatus =[[dataDict valueForKey:@"follow"]intValue];
    if (followStatus==1) {
        [cell.followButton setHidden:NO];
    }else{
        [cell.followButton setHidden:YES];
    }
    
    [cell.followButton addTarget:self action:@selector(followButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //Checked for post Image
    NSString * urlStringForImage =[dataDict valueForKey:@"image"];
    if (![urlStringForImage isKindOfClass:[NSNull class]]) {
        NSURL * profileUrl =[NSURL URLWithString:urlStringForImage];
        [cell.profileImageView sd_setImageWithURL:profileUrl placeholderImage:[UIImage imageNamed:@"No_User"]];
    }
    
    return cell;
}

-(void)followButtonClick:(UIButton *)btn{
    selectedUserIndex =(int)btn.tag;
    [self.view showLoader];
    [self performSelectorInBackground:@selector(followWebservice) withObject:nil];
}

-(void)followWebservice{
    NSDictionary * dataDict =[wishedToData objectAtIndex:selectedUserIndex];
    NSString * publicId =[dataDict valueForKey:@"id"];
    NSString * userID =[UserData getUserID];
    NSString *apiURL =  [NSString stringWithFormat:@"%@action=%@&userId=%@&publicId=%@",URL_CONST,ACTION_ADD_FOLLOWER, userID,publicId];
    NSDictionary * homefeed = [[WebHandler sharedHandler]getDataFromWebservice:apiURL];
    if (homefeed) {
        if ([[homefeed valueForKey:@"message"]isEqualToString:@"you are now following the user"]) {
            NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
            [newDict addEntriesFromDictionary:dataDict];
            [newDict setObject:@"1" forKey:@"follow"];
            [wishedToData replaceObjectAtIndex:selectedUserIndex withObject:newDict];
            [self.view makeToast:@"You are now following the user"duration:toastDuration position:toastPositionBottomUp];
        }else{
            NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
            [newDict addEntriesFromDictionary:dataDict];
            [newDict setObject:@"0" forKey:@"follow"];
            [wishedToData replaceObjectAtIndex:selectedUserIndex withObject:newDict];
            [self.view makeToast:@"You are NOT following the user now"duration:toastDuration position:toastPositionBottomUp];
        }
    }
    [self performSelectorOnMainThread:@selector(reloadTableRow) withObject:nil waitUntilDone:YES];
}

-(void)reloadTableRow{
    NSIndexPath * path =[NSIndexPath indexPathForRow:selectedUserIndex inSection:0];
    [wishTableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.view hideLoader];
}


#pragma mark====================Get Follow List Data From Webservice=============================

-(void)getWishToData{
    NSString * userID =[UserData getUserID];
    NSString *apiURL =  [NSString stringWithFormat:@"%@action=%@&userId=%@&page=%d",URL_CONST,ACTION_GET_WISH_TO, userID,wishPage];
    NSDictionary * homefeed = [[WebHandler sharedHandler]getDataFromWebservice:apiURL];
        [wishedToData addObjectsFromArray:[homefeed valueForKey:@"data"]];
    [self performSelectorOnMainThread:@selector(reloadTable) withObject:nil waitUntilDone:YES];
}


-(void)getWishToDataForPaging{
    NSString * userID =[UserData getUserID];
    NSString *apiURL =  [NSString stringWithFormat:@"%@action=%@&userId=%@&page=%d",URL_CONST,ACTION_GET_WISH_TO, userID,wishPage];
    NSDictionary * homefeed = [[WebHandler sharedHandler]getDataFromWebservice:apiURL];
    NSArray * data =[homefeed valueForKey:@"data"];
    if (data.count==0) {
        shouldDoPaging=NO;
    }else{
        [wishedToData addObjectsFromArray:data];
        shouldDoPaging=YES;
    }
    [self performSelectorOnMainThread:@selector(reloadTable) withObject:nil waitUntilDone:YES];
}



-(void)reloadTable{
    [wishTableView reloadData];
    [self.view hideLoader];
    
    if (wishedToData.count==0) {
        [self.view makeToast:@"No one visited this place yet" duration:toastDuration position:toastPositionBottomUp];
        [self performSelector:@selector(backClick) withObject:nil afterDelay:2];
    }
}


-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
