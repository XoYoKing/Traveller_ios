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
    self.navigationController.navigationBarHidden=YES;
    // Do any additional setup after loading the view.
    [self setupView];
    
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
-(void)viewWillAppear:(BOOL)animated{
    // to scroll tableview at bottom
    if (commentTableView.contentSize.height > commentTableView.frame.size.height)
    {
        CGPoint offset = CGPointMake(0, commentTableView.contentSize.height -     commentTableView.frame.size.height);
        [commentTableView setContentOffset:offset animated:YES];
    }
    
    [self.view showLoader];
    [self performSelectorInBackground:@selector(getWholeLikeData) withObject:nil];
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
    closeButton.titleLabel.font=[UIFont fontWithName:fontIcomoon size:25];
    [closeButton setTitle:[NSString stringWithUTF8String:ICOMOON_CROSS] forState:UIControlStateNormal];
    closeButton.layer.cornerRadius=20;
    closeButton.backgroundColor=[UIColor whiteColor];
    [self addShaddowToView:closeButton];
    [bgView layoutIfNeeded];
    [self performSelector:@selector(addShadowTobackground) withObject:nil afterDelay:1];
   
}
#pragma mark - load bottom message sending view
- (void)loadView1{
    
    [self.view layoutIfNeeded];
    
    CGPoint windowPoint = [commentTableView convertPoint:commentTableView.bounds.origin toView:self.view.window];
    
    CGRect Frame = CGRectMake(commentTableView.frame.origin.x, windowPoint.y+15, commentTableView.frame.size.width, commentTableView.frame.size.height) ;
    
    
    containerView = [[UIView alloc] initWithFrame:CGRectMake(20, Frame.size.height+80, commentTableView.frame.size.width, 50)];
    
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
    doneBtn.frame = CGRectMake(containerView.frame.size.width - 69, 8, 63, 27);
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
    
    //Step 1: Define a normal attributed string for non-link texts
    
//    "id":"327",
//    "name":"Nitin",
//    "comment":"hhhh",
//    "image":"http:\/\/trasquare.com\/traveller_api\/userPic\/1458141473.jpg",
//    "is_my":0
    
    NSDictionary * dataDict =[commentArr objectAtIndex:indexPath.row];
    NSString * username=[dataDict valueForKey:@"name"];
    NSString * comment=[dataDict valueForKey:@"comment"];
    NSString * image=[dataDict valueForKey:@"image"];
    int  ismyComment=[[dataDict valueForKey:@"is_my"]intValue];
    
    NSString *string = [NSString stringWithFormat:@"%@ Commented %@",username,comment];
    NSDictionary *attributes = @{NSForegroundColorAttributeName: [UIColor blackColor],NSFontAttributeName: [UIFont fontWithName:font_regular size:font_size_normal_regular]};
    cell.commentLbl.attributedText = [[NSAttributedString alloc]initWithString:string attributes:attributes];
    void(^handler)(FRHyperLabel *label, NSString *substring) = ^(FRHyperLabel *label, NSString *substring){
        if ([substring isEqualToString:username]) {
            [self.view endEditing:YES];
        //    [self openUserProfile];
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
    
}

-(void)addShaddowToView:(UIView *)view{
    view.layer.shadowOffset = CGSizeMake(1, 1);
    view.layer.shadowColor = [[UIColor blackColor] CGColor];
    view.layer.shadowRadius = 4.0f;
    view.layer.shadowOpacity = 0.80f;
}

- (IBAction)dismissClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)openUserProfile{
    ViewProfileController * vc =[self.storyboard instantiateViewControllerWithIdentifier:@"ViewProfileController"];
    [self.navigationController pushViewController:vc animated:YES];
}



@end
