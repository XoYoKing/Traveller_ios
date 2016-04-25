//
//  LikeViewController.m
//  Traveller_ObjC
//
//  Created by Sandip Jadhav on 10/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import "LikeViewController.h"
#import "ViewProfileController.h"

@interface LikeViewController ()

@end

@implementation LikeViewController

- (IBAction)dismicclick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:Nil];
}

-(void)getWholeLikeData{
    NSString *apiURL =  [NSString stringWithFormat:@"%@action=%@&userId=%@&activity_id=%@&page=%d",URL_CONST,ACTION_GET_LIKE_DETAILS,[UserData getUserID],_activityId,likePage];
    NSDictionary * homefeed = [[WebHandler sharedHandler]getDataFromWebservice:apiURL];
    totalLike =[homefeed valueForKey:@"data"];
    [self performSelectorOnMainThread:@selector(reloadDataOnTable) withObject:nil waitUntilDone:YES];
}
-(void)getWholeLikeDataForPaging{
    NSString *apiURL =  [NSString stringWithFormat:@"%@action=%@&userId=%@&activityId=%@",URL_CONST,ACTION_GET_LIKE_DETAILS,_userId,_activityId];    NSDictionary * homefeed = [[WebHandler sharedHandler]getDataFromWebservice:apiURL];
    NSArray * data =[homefeed valueForKey:@"data"];
    if (data.count==0) {
        likePageShouldDoPaging=NO;
    }else{
        [totalLike addObjectsFromArray:data];
        likePageShouldDoPaging=YES;
    }
    [self performSelectorOnMainThread:@selector(reloadDataOnTable) withObject:nil waitUntilDone:YES];
}
-(void)reloadDataOnTable{
    [likeTableView reloadData];
    [self.view hideLoader];
    likeTableView.tableFooterView=[UIView new];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    likePage=1;
    // Do any additional setup after loading the view.
    [self setupView];
    likeTableView.estimatedRowHeight=90;
    likeTableView.rowHeight=UITableViewAutomaticDimension;
    [self.view showLoader];
    [self performSelectorInBackground:@selector(getWholeLikeData) withObject:nil];
}

-(void)setupView{
    closeButton.titleLabel.font=[UIFont fontWithName:fontIcomoon size:25];
    [closeButton setTitle:[NSString stringWithUTF8String:ICOMOON_CROSS] forState:UIControlStateNormal];
    closeButton.layer.cornerRadius=20;
    closeButton.backgroundColor=[UIColor whiteColor];
    [self addShaddowToView:closeButton];
    [bgView layoutIfNeeded];
    [self performSelector:@selector(addShadowTobackground) withObject:nil afterDelay:0];
}
-(void)addShadowTobackground{
    bgView.layer.cornerRadius=9;
    [self addShaddowToView:bgView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return totalLike.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        LikeTableViewCell * cell = [likeTableView dequeueReusableCellWithIdentifier:@"LikeTableViewCell"];
    NSDictionary * dict =[totalLike objectAtIndex:indexPath.row];
//    city = Pune;
//    country = India;
//    follow = 1;
//    id = 3;
//    image = "http://trasquare.com/traveller_api/userPic/1460801971.jpg";
//    name = Satish;
    
 //   profileImageView;
    cell.nameLbl.text=[dict valueForKey:@"name"];
    cell.adressLbl.text=[dict valueForKey:@"city"];

    if ([[UserData getUserID] isEqualToString:[dict valueForKey:@"id"]]) {
        
        cell.followBtn.titleLabel.tintColor=[UIColor redColor];
        cell.followBtn.titleLabel.font=[UIFont fontWithName:fontIcomoon size:logo_Size_Small];
        [cell.followBtn setTitle:[NSString stringWithUTF8String:ICOMOON_HEART_UNCHECK] forState:UIControlStateNormal] ;
        cell.followBtn.backgroundColor=[UIColor clearColor];
        [cell.followBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cell.dislikeLbl.hidden=NO;
        cell.followBtn.tag =indexPath.row;
         [ cell.followBtn removeTarget:self action:@selector(followBtn:) forControlEvents:UIControlEventTouchUpInside];
        [ cell.followBtn addTarget:self action:@selector(likeBtn:) forControlEvents:UIControlEventTouchUpInside];
       
   
    }else{
        
        cell.followBtn.tag =indexPath.row;
        cell.followBtn.titleLabel.tintColor=[UIColor lightGrayColor];
        cell.followBtn.titleLabel.font=[UIFont fontWithName:font_button size:font_size_button];
           [cell.followBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
         cell.dislikeLbl.hidden=YES;
              [ cell.followBtn removeTarget:self action:@selector(likeBtn:) forControlEvents:UIControlEventTouchUpInside];
        [ cell.followBtn addTarget:self action:@selector(followBtn:)  forControlEvents:UIControlEventTouchUpInside];

        if ( [[dict valueForKey:@"follow"]intValue]==1){
            [cell.followBtn setTitle:@"Following" forState:UIControlStateNormal] ;
            cell.followBtn.backgroundColor=userShouldDOButoonColor;
        }
       else{
           [cell.followBtn setTitle:@"Follow" forState:UIControlStateNormal] ;
           cell.followBtn.backgroundColor=userShouldDOButoonColor;
         }
         }
    
    //Checked for post Image
    NSString * urlStringForImage =[dict valueForKey:@"image"];
    if (![urlStringForImage isKindOfClass:[NSNull class]]) {
        NSURL * profileUrl =[NSURL URLWithString:urlStringForImage];
        [cell.profileImageView sd_setImageWithURL:profileUrl placeholderImage:[UIImage imageNamed:@"No_User"]];
    }
return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * dict =[totalLike objectAtIndex:indexPath.row];
    if (![[UserData getUserID] isEqualToString:[dict valueForKey:@"id"]]) {
        NSString * uiD=[dict valueForKey:@"id"];
        NSString * image=[dict valueForKey:@"image"];
        NSString * name=[dict valueForKey:@"name"];
        [self openUserProfile:uiD  :name :image];
    }
}
-(void)followBtn:(UIButton *)btn{
    selectedUserIdex =(int)btn.tag;
    [self.view showLoader];
    [self performSelectorInBackground:@selector(followWebservice) withObject:nil];
}
-(void)followWebservice{
    NSDictionary * dataDict ;
    dataDict =[totalLike objectAtIndex:selectedUserIdex];
    NSString * publicId =[dataDict valueForKey:@"id"];
    NSString * userID =[UserData getUserID];
    NSString *apiURL =  [NSString stringWithFormat:@"%@action=%@&userId=%@&publicId=%@",URL_CONST,ACTION_ADD_FOLLOWER, userID,publicId];
    NSDictionary * homefeed = [[WebHandler sharedHandler]getDataFromWebservice:apiURL];
    [self performSelectorOnMainThread:@selector(reloadTableRow:) withObject:homefeed waitUntilDone:YES];
}

-(void)reloadTableRow:(NSDictionary *)homefeed{
    NSDictionary * dataDict =[totalLike objectAtIndex:selectedUserIdex];
        if (homefeed) {
            if ([[homefeed valueForKey:@"message"]isEqualToString:@"you are now following the user"]) {
                NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
                [newDict addEntriesFromDictionary:dataDict];
                [newDict setObject:@"1" forKey:@"follow"];
                [totalLike replaceObjectAtIndex:selectedUserIdex withObject:newDict];
                [self.view makeToast:@"You are now following the user"duration:toastDuration position:toastPositionBottomUp];
            }else{
                NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
                [newDict addEntriesFromDictionary:dataDict];
                [newDict setObject:@"0" forKey:@"follow"];
                [totalLike replaceObjectAtIndex:selectedUserIdex withObject:newDict];
                [self.view makeToast:@"You are NOT following the user now"duration:toastDuration position:toastPositionBottomUp];
            }
        }
    NSIndexPath * ip = [NSIndexPath indexPathForRow:selectedUserIdex inSection:0];
        [likeTableView reloadRowsAtIndexPaths:@[ip] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.view hideLoader];
        
}

-(void)likeBtn:(UIButton *)btn{
    NSIndexPath * ip =[NSIndexPath indexPathForRow:btn.tag inSection:0];
      [totalLike removeObjectAtIndex:ip.row];
    [likeTableView beginUpdates];
    [likeTableView deleteRowsAtIndexPaths:@[ip] withRowAnimation:UITableViewRowAnimationNone];
    [likeTableView endUpdates];
  
    NSDictionary * not_Dict=@{};
    [[NSNotificationCenter defaultCenter] postNotificationName:throwRefreshLike object:not_Dict];
    
    
    [self performSelectorInBackground:@selector(likeWebservice) withObject:nil];
}
-(void)likeWebservice{
    NSString *apiURL =  [NSString stringWithFormat:@"%@action=%@&userId=%@&publicID=%@&activityId=%@",URL_CONST,ACTION_ADD_LIKE,[UserData getUserID],_userId,_activityId];
     [[WebHandler sharedHandler]getDataFromWebservice:apiURL];
}

-(void)addShaddowToView:(UIView *)view{
    view.layer.shadowOffset = CGSizeMake(1, 1);
    view.layer.shadowColor = [[UIColor blackColor] CGColor];
    view.layer.shadowRadius = 4.0f;
    view.layer.shadowOpacity = 0.80f;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //1. Setup the CATransform3D structure
    CATransform3D rotation;
    rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
    rotation.m34 = 1.0/ -600;
    
    
    //2. Define the initial state (Before the animation)
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    
    cell.layer.transform = rotation;
    cell.layer.anchorPoint = CGPointMake(0, 0.5);
    
    
    //3. Define the final state (After the animation) and commit the animation
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:0.8];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
    
}
#pragma mark====================Open User Profile=============================
-(void)openUserProfile:(NSString * )userId :(NSString *)userName :(NSString *)urlStringForProfileImage {
    if (![userId isEqualToString:[UserData getUserID]]) {
        ViewProfileController * vc =[self.storyboard instantiateViewControllerWithIdentifier:@"ViewProfileController"];
        vc.userId=userId;
        vc.name=userName;
        vc.imageUrl=urlStringForProfileImage;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
