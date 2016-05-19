//
//  CommentsViewController.m
//  Traveller_ObjC
//
//  Created by Sandip Jadhav on 10/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import "CommentsViewController.h"
#import "ComentTableViewCell.h"
#import "ViewProfileController.h"
@interface CommentsViewController ()

@end

@implementation CommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"Comments";
    // Do any additional setup after loading the view.
    [self setupView];
    [self setUpNavigationBar];
    commentPage=1;
    // Do any additional setup after loading the view.
    [self setupView];
    commentTableView.estimatedRowHeight=90;
    commentTableView.rowHeight=UITableViewAutomaticDimension;
    
    // Notification to Keybord hide and show
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    // for hiding keybord
 UITapGestureRecognizer *  tapper = [[UITapGestureRecognizer alloc]
              initWithTarget:self action:@selector(handleSingleTap)];
    [commentTableView addGestureRecognizer:tapper];
    tapper.cancelsTouchesInView = NO;
    
}
-(void)handleSingleTap{
    [self.view endEditing:YES];
}

-(void)setUpNavigationBar{
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont
                                                                           fontWithName:font_bold size:font_size_normal_regular], NSFontAttributeName,
                                [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.backgroundColor=navigation_background_Color;
    self.navigationController.navigationBar.barTintColor=navigation_background_Color;
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    
    UIButton *btnClose = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnClose setFrame:CGRectMake(0, 0, 30, 30)];
    
    btnClose.titleLabel.font=[UIFont fontWithName:fontIcomoon size:logo_Size_Small];
    btnClose.tintColor=back_btn_Color;
    [btnClose setTitle:[NSString stringWithUTF8String:ICOMOON_CROSS] forState:UIControlStateNormal];
    [btnClose addTarget:self action:@selector(dismissClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftbarButton = [[UIBarButtonItem alloc] initWithCustomView:btnClose];
    self.navigationItem.leftBarButtonItem = leftbarButton;
}



-(void)viewWillAppear:(BOOL)animated{

    self.navigationController.navigationBar.backgroundColor=navigation_background_Color;
    self.navigationController.navigationBar.barTintColor=navigation_background_Color;
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    
    if (commentTableView.contentSize.height > commentTableView.frame.size.height)
    {
        CGPoint offset = CGPointMake(0, commentTableView.contentSize.height -     commentTableView.frame.size.height);
        [commentTableView setContentOffset:offset animated:YES];
    }
    
    [self.view showLoader];
    [self performSelectorInBackground:@selector(getWholeLikeData) withObject:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.backgroundColor=[UIColor clearColor];
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
}

-(void)viewDidAppear:(BOOL)animated{
    if (containerView==nil) {
     [self loadView1];
    }
}

-(void)getWholeLikeData{
    NSString *apiURL =  [NSString stringWithFormat:@"%@action=%@&userId=%@&publicId=%@&activityId=%@&page=%d",URL_CONST,ACTION_GET_COMMENT_DETAILS,[UserData getUserID],_postedById,_activityId,commentPage];
    NSDictionary * homefeed = [[WebHandler sharedHandler]getDataFromWebservice:apiURL];
    commentArr =[homefeed valueForKey:@"data"];
    [self performSelectorOnMainThread:@selector(reloadDataOnTable) withObject:nil waitUntilDone:YES];
}




-(void)getWholeLikeDataForPaging{
    NSString *apiURL =  [NSString stringWithFormat:@"%@action=%@&userId=%@&publicId=%@&activityId=%@&page=%d",URL_CONST,ACTION_GET_COMMENT_DETAILS,[UserData getUserID],_postedById,_activityId,commentPage];
    NSDictionary * homefeed = [[WebHandler sharedHandler]getDataFromWebservice:apiURL];
    NSArray * data =[homefeed valueForKey:@"data"];
    if (data.count==0) {
        commentPageShouldDoPaging=NO;
    }else{
        [commentArr addObjectsFromArray:data];
        commentPageShouldDoPaging=YES;
    }
    [self performSelectorOnMainThread:@selector(reloadDataOnTable) withObject:nil waitUntilDone:YES];
}



-(void)reloadDataOnTable{
    [commentTableView reloadData];
    [self.view hideLoader];
}


-(void)setupView{
  commentTableView.tableFooterView=[UIView new];
}
#pragma mark - load bottom message sending view
- (void)loadView1{
    
    [self.view layoutIfNeeded];
    

    

    containerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-60, self.view.frame.size.width, 60) ];
    containerView.backgroundColor=[UIColor whiteColor];
    containerView.layer.borderWidth=1;
    messageInputView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(6, 3, containerView.frame.size.width-60, 44)];
    messageInputView.isScrollable = NO;
    messageInputView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    messageInputView.minNumberOfLines = 1;
    messageInputView.maxNumberOfLines = 6;
    messageInputView.returnKeyType = UIReturnKeyDefault;
    messageInputView.font = [UIFont fontWithName:font_regular size:font_size_normal_regular];
    messageInputView.delegate = self;
    messageInputView.textColor=[UIColor blackColor];
    messageInputView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
    messageInputView.backgroundColor = [UIColor whiteColor];
    messageInputView.placeholder = @"Type your message here";
    [self.view addSubview:containerView];
    
    UIImage *rawEntryBackground = [UIImage imageNamed:@"MessageEntryInputField.png"];
    UIImage *entryBackground = [rawEntryBackground stretchableImageWithLeftCapWidth:13 topCapHeight:22];
    UIImageView *entryImageView = [[UIImageView alloc] initWithImage:entryBackground];
    entryImageView.frame = CGRectMake(5, 0, 248, 40);
    entryImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    UIImage *rawBackground = [UIImage imageNamed:@"MessageEntryBackground.png"];
    UIImage *background = [rawBackground stretchableImageWithLeftCapWidth:13 topCapHeight:22];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:background];
    imageView.frame = CGRectMake(0, 0, containerView.frame.size.width, containerView.frame.size.height);
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    messageInputView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    [containerView addSubview:messageInputView];
    
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    doneBtn.frame = CGRectMake(containerView.frame.size.width - 69, 8, 63, 35);
    [doneBtn addBlackLayerAndCornerRadius:5 AndWidth:1];
    doneBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    doneBtn.titleLabel.font=[UIFont fontWithName:font_button size:font_size_button];
    doneBtn.tintColor=userShouldDOButoonColor;
    [doneBtn setBackgroundColor:segment_disselected_Color];
    [doneBtn setTitle:@"Send" forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    [doneBtn addTarget:self action:@selector(sendButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [containerView addSubview:doneBtn];
    containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
}

-(void)sendButtonClick{
    if([messageInputView.text isEqualToString:@""]){
        [self.view makeToast:@"Comment should not be empty" duration:toastDuration position:toastPositionBottomUp];
    }else{
        userInputtedMsg=messageInputView.text;
        messageInputView.text=@"";
        NSDictionary * dict =@{
                               @"id":@"12345678",
                               @"name": [UserData getUserName] ,
                               @"comment":userInputtedMsg,
                               @"image":[UserData getUserImageUrl],
                               @"is_my":@"1"
                               };
        [commentArr addObject:dict];
        [self performSelectorInBackground:@selector(addCommentWebservice) withObject:nil];
        [commentTableView reloadData];
        NSDictionary * not_Dict=@{};
        [[NSNotificationCenter defaultCenter] postNotificationName:throwRefreshComment object:not_Dict];
      
    }
}
-(void)addCommentWebservice{
    NSString *apiURL =  [NSString stringWithFormat:@"%@action=%@&userId=%@&publicID=%@&activityId=%@&comment=%@",URL_CONST,ACTION_COMMENT_ADD,[UserData getUserID],_postedById,_activityId,userInputtedMsg];
    NSDictionary * dict =[[WebHandler sharedHandler]getDataFromWebservice:apiURL];
    if (dict!=nil) {
        NSDictionary * dict1 =@{
                               @"id":[dict valueForKey:@"comment_id"],
                               @"name": [UserData getUserName] ,
                               @"comment":userInputtedMsg,
                               @"image":[UserData getUserImageUrl],
                               @"is_my":@"1"
                               };
      int index =commentArr.count-1;
        [commentArr replaceObjectAtIndex:index withObject:dict1];
    }
}

#pragma mark - Keybord Hide and show methods
-(void) keyboardWillShow:(NSNotification *)note{
    
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // Need to translate the bounds to account for rotation.
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    
    // get a rect for the textView frame
    CGRect containerFrame = self.view.frame;
    containerFrame.origin.y = self.view.bounds.size.height - (keyboardBounds.size.height + containerFrame.size.height);
    NSString * str =[NSString stringWithFormat:@"%f",containerFrame.origin.y];
    NSNumber * number = [NSNumber numberWithDouble:fabs([str doubleValue])];
    str =[NSString stringWithFormat:@"%@",number];
//    tableviewUpperConstraint.constant=[str integerValue];
 //   [chatTableView layoutIfNeeded];
    // animations settings
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    self.view.frame = containerFrame;
    [UIView commitAnimations];
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

-(void) keyboardWillHide:(NSNotification *)note{
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // get a rect for the textView frame
    CGRect containerFrame = self.view.frame;
    containerFrame.origin.y = self.view.bounds.size.height - containerFrame.size.height;
    
  //  tableviewUpperConstraint.constant=containerFrame.origin.y;
   // [chatTableView layoutIfNeeded];
    
    // animations settings
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
    // set views with new info
    self.view.frame = containerFrame;
    
    // commit animations
    [UIView commitAnimations];
}

#pragma mark - growing textview delegate and datasource

- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
    float diff = (growingTextView.frame.size.height - height);
    
    CGRect r = containerView.frame;
    r.size.height -= diff;
    r.origin.y += diff;
    containerView.frame = r;
    tableViewBottomConstraint.constant=containerView.frame.size.height;
    [commentTableView layoutIfNeeded];
    
    if (commentTableView.contentSize.height > commentTableView.frame.size.height)
    {
        CGPoint offset = CGPointMake(0, commentTableView.contentSize.height -     commentTableView.frame.size.height);
        [commentTableView setContentOffset:offset animated:YES];
    }
    
}


-(void)addShadowTobackground{
    bgView.layer.cornerRadius=9;
    [self addShaddowToView:bgView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return commentArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ComentTableViewCell * cell = [commentTableView dequeueReusableCellWithIdentifier:@"ComentTableViewCell"];
    
    cell.commentLbl.numberOfLines = 0;
    NSDictionary * dataDict =[commentArr objectAtIndex:indexPath.row];
    NSString * username=[dataDict valueForKey:@"name"];
    NSString * comment=[dataDict valueForKey:@"comment"];
    NSString * userId =[dataDict valueForKey:@"id"];
    NSString * image=[dataDict valueForKey:@"image"];
    int  ismyComment=[[dataDict valueForKey:@"is_my"]intValue];
    
    NSString *string = [NSString stringWithFormat:@"%@ : %@",username,comment];
    NSDictionary *attributes = @{NSForegroundColorAttributeName: [UIColor blackColor],NSFontAttributeName: [UIFont fontWithName:font_regular size:font_size_normal_regular]};
    cell.commentLbl.attributedText = [[NSAttributedString alloc]initWithString:string attributes:attributes];
    void(^handler)(FRHyperLabel *label, NSString *substring) = ^(FRHyperLabel *label, NSString *substring){
        if ([substring isEqualToString:username]) {
            [self.view endEditing:YES];
          //  [self openUserProfile:userId :username :image];
        }
    };
    [cell.commentLbl setLinksForSubstrings:@[username] withLinkHandler:handler];
    
    //Checked for post Image
    if (![image isKindOfClass:[NSNull class]]) {
        NSURL * profileUrl =[NSURL URLWithString:image];
        [cell.profileImageView sd_setImageWithURL:profileUrl placeholderImage:[UIImage imageNamed:@"No_User"]];
    }
    
    if (ismyComment==1) {
        cell.deleteButton.hidden=NO;
    }else{
        cell.deleteButton.hidden=YES;
    }
    cell.deleteButton.tag=indexPath.row;
    [cell.deleteButton addTarget:self action:@selector(deleteComentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

-(void)deleteComentBtnClick:(UIButton *)btn{
    commentToDelete=[commentArr objectAtIndex:btn.tag];
    
    [commentArr removeObjectAtIndex:btn.tag];
    NSIndexPath * ip =[NSIndexPath indexPathForRow:btn.tag inSection:0];
    [commentTableView beginUpdates];
    [commentTableView deleteRowsAtIndexPaths:@[ip] withRowAnimation:UITableViewRowAnimationNone];
    [commentTableView endUpdates];
    
    
    NSDictionary * not_Dict=@{};
    [[NSNotificationCenter defaultCenter] postNotificationName:throwRefreshComment object:not_Dict];
    [self performSelectorInBackground:@selector(deleteCommentwebservice) withObject:nil];
}
-(void)deleteCommentwebservice{
    //action,userId,taskId,type
 //   parameter.put("userId", mPref.getString(Constant.user_id, ""));
			//	parameter.put("action", "removeComment");
			//	parameter.put("commentId", uniqueID);
    
    NSString * userid=[UserData getUserID];
NSString *taskid= [commentToDelete valueForKey:@"id"];
  
    NSString *apiURL =  [NSString stringWithFormat:@"%@action=%@&userId=%@&commentId=%@",URL_CONST,ACTION_REMOVE_COMMENT,userid,taskid];
   [[WebHandler sharedHandler]getDataFromWebservice:apiURL];
        [self.view makeToast:@"Comment succesfully deleted" duration:toastDuration position:toastPositionBottomUp];
}
//
//parameter.put("action", "inviteToJoin");
//parameter.put("userId", mPref.getString(Constant.user_id, ""));
//parameter.put("publicId", uniqueID);
//parameter.put("cityId", cityid);
//
//parameter.put("action","editActivities");
//parameter.put("userId", mPref.getString(Constant.user_id, ""));
//parameter.put("cityId", uniqueID);
//parameter.put("activityId", activity_id);
//parameter.put("activity_type", activity_type);
////	parameter.put("title", placename2);
//parameter.put("description", description2);





//deletnotification
//parameter.put("action", "delete");
//parameter.put("userId", mPref.getString(Constant.user_id, ""));
//parameter.put("taskId", uniqueID);
//parameter.put("type", type);

-(void)addShaddowToView:(UIView *)view{
    view.layer.shadowOffset = CGSizeMake(1, 1);
    view.layer.shadowColor = [[UIColor blackColor] CGColor];
    view.layer.shadowRadius = 4.0f;
    view.layer.shadowOpacity = 0.80f;
}

- (IBAction)dismissClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
 //   [self.navigationController popViewControllerAnimated:YES];
}
-(void)openUserProfile{
    ViewProfileController * vc =[self.storyboard instantiateViewControllerWithIdentifier:@"ViewProfileController"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark====================Open User Profile=============================
//-(void)openUserProfile:(NSString * )userId :(NSString *)userName :(NSString *)urlStringForProfileImage {
//    if (![userId isEqualToString:[UserData getUserID]]) {
//        ViewProfileController * vc =[self.storyboard instantiateViewControllerWithIdentifier:@"ViewProfileController"];
//        NSLog(@"%@",userId);
//        NSLog(@"%@",userName);
//        vc.userId=userId;
//        vc.name=userName;
//        vc.imageUrl=urlStringForProfileImage;
//        [self.navigationController pushViewController:vc animated:YES];
//    }
//}

@end
