//
//  NotificationsViewController.m
//  Traveller_ObjC
//
//  Created by Sagar Shirbhate on 07/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import "NotificationsViewController.h"

@interface NotificationsViewController ()

@end

@implementation NotificationsViewController

-(void)viewWillAppear:(BOOL)animated{
    [self.view showLoader];
    [self performSelectorInBackground:@selector(getAllNotifications) withObject:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"Notifications";
    self.navigationController.navigationBarHidden=NO;
    selectedIndex=0;
    [self addScrollview];
    notificationTableView.tableFooterView=[UIView new];
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont
                                                                           fontWithName:font_bold size:font_size_normal_regular], NSFontAttributeName,
                                [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    self.navigationController.navigationBar.backgroundColor=navigation_background_Color;
    self.navigationController.navigationBar.barTintColor=navigation_background_Color;
    if (_fromMenu==NO) {
    UIButton *btn =  [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.textColor=[UIColor blackColor];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0,0,25,25);
    btn.tintColor=[UIColor whiteColor];
        btn.titleLabel.font=[UIFont fontWithName:fontIcomoon size:logo_Size_Small];
        btn.tintColor=[UIColor whiteColor];
        [btn setTitle:[NSString stringWithUTF8String:ICOMOON_BACK_CIECLE_LEFT] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    self.navigationItem.leftBarButtonItem =   barBtn;
    }
    notificationTableView.estimatedRowHeight=50;
    notificationTableView.rowHeight=UITableViewAutomaticDimension;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addShaddowToView:(UIView *)view{
    view.layer.shadowOffset = CGSizeMake(2, 2);
    view.layer.shadowColor = [[UIColor blackColor] CGColor];
    view.layer.shadowRadius = 4.0f;
    view.layer.shadowOpacity = 0.80f;
}
-(void)removeShaddowToView:(UIView *)view{
    view.layer.shadowOffset = CGSizeMake(0, 0);
    view.layer.shadowColor = [[UIColor blackColor] CGColor];
    view.layer.shadowRadius = 0;
    view.layer.shadowOpacity = 0;
}
-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)addScrollview {
    
    NSArray * namesOfMenus =@[@"Invitation",@"Ask Tips",@"Messages",@"Follow Notifications"];

    CGFloat scrollWidth = 0.f;
    buttonArray=[[NSMutableArray alloc]init];
    for ( int j=0; j<namesOfMenus.count; j++)
    {
        NSString * name =[namesOfMenus objectAtIndex:j];
        CGSize size = [name sizeWithAttributes:
                       @{NSFontAttributeName: [UIFont fontWithName:font_regular size:17]}];
        CGSize textSize = CGSizeMake(ceilf(size.width), ceilf(size.height));
        CGFloat strikeWidth = textSize.width;
        if (iPAD) {
          strikeWidth = self.view.frame.size.width/4;
        }else{
        strikeWidth = textSize.width+20;
        }
        
        CGRect frame = CGRectMake(scrollWidth, 0,strikeWidth+20, 40);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTag:j];
        button.frame = frame;
        [button setBackgroundColor:[UIColor whiteColor]];
        button.titleLabel.textColor=[UIColor whiteColor];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.layer.borderColor=[UIColor whiteColor].CGColor;
        button.titleLabel.textAlignment=NSTextAlignmentCenter;
        [button addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:name forState:UIControlStateNormal];
        scrollWidth= scrollWidth+strikeWidth+20;

        if (j==selectedIndex) {
            button.backgroundColor=segment_selected_Color ;
            [button setTitleColor:segment_disselected_Color forState:UIControlStateNormal];
            [button addLayerAndCornerRadius:2 AndWidth:1 AndColor:segment_disselected_Color];
            [button addShaddow];
            if (iPhone6||iPhone6plus) {
                button.titleLabel.font=[UIFont fontWithName:font_bold size:font_size_normal_regular];
            }else {
                button.titleLabel.font=[UIFont fontWithName:font_bold size:font_size_normal_regular];
            }
        }else {
            button.backgroundColor=segment_disselected_Color;
            [button addLayerAndCornerRadius:2 AndWidth:0 AndColor:segment_disselected_Color];
            [button setTitleColor:segment_selected_Color forState:UIControlStateNormal];
            if (iPhone6||iPhone6plus) {
                button.titleLabel.font=[UIFont fontWithName:font_bold size:font_size_normal_regular];
            }else{
                button.titleLabel.font=[UIFont fontWithName:font_bold size:font_size_normal_regular];
            }
        }
        [buttonArray addObject:button];
        [myScrollView addSubview:button];
        
    }
    myScrollView.contentSize = CGSizeMake(scrollWidth, 30.f);
    myScrollView.pagingEnabled = NO;
    [myScrollView setShowsHorizontalScrollIndicator:NO];
    [myScrollView setShowsVerticalScrollIndicator:NO];
}


#pragma mark - Header Button Action
-(void)buttonEvent:(UIButton*)sender
{
    NSInteger index= sender.tag;
    selectedIndex=index;
    
    for(int i=0;i<buttonArray.count;i++)
    {
        UIButton * button =(UIButton*)[buttonArray objectAtIndex:i];
        if (i==selectedIndex) {
            button.backgroundColor=segment_selected_Color ;
            [button setTitleColor:segment_disselected_Color forState:UIControlStateNormal];
            [button addLayerAndCornerRadius:2 AndWidth:1 AndColor:segment_disselected_Color];
            [button addShaddow];
            if (iPhone6||iPhone6plus) {
                button.titleLabel.font=[UIFont fontWithName:font_bold size:font_size_normal_regular];
            }else {
                button.titleLabel.font=[UIFont fontWithName:font_bold size:font_size_normal_regular];
            }
        }else {
            button.backgroundColor=segment_disselected_Color;
            [button addLayerAndCornerRadius:2 AndWidth:0 AndColor:segment_disselected_Color];
            [button setTitleColor:segment_selected_Color forState:UIControlStateNormal];
            if (iPhone6||iPhone6plus) {
                button.titleLabel.font=[UIFont fontWithName:font_bold size:font_size_normal_regular];
            }else{
                button.titleLabel.font=[UIFont fontWithName:font_bold size:font_size_normal_regular];
            }
        }
    }
    
    
    
    CGRect frame1 = myScrollView.frame;
    UIButton * bt=(UIButton*)[buttonArray objectAtIndex:index];
    frame1 =bt.frame ;
    [myScrollView scrollRectToVisible:frame1 animated:YES];
    [notificationTableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (selectedIndex==0) {
            return invitation.count;
    }else if(selectedIndex==1){
            return ask_for_tip.count;
    }else if (selectedIndex==2){
            return message.count;
    }else {
            return follow.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{   UITableViewCell *cell ;
    if (selectedIndex==0) {
        Notification1TableViewCell * cell =[notificationTableView dequeueReusableCellWithIdentifier:@"Notification1TableViewCell"];
        return cell;
        NSDictionary * dict =[invitation objectAtIndex:indexPath.row];
        
    }else if(selectedIndex==1){
        Notification2TableViewCell * cell =[notificationTableView dequeueReusableCellWithIdentifier:@"Notification2TableViewCell"];
        NSDictionary * dict =[ask_for_tip objectAtIndex:indexPath.row];
        cell.msgLbl.text =[dict valueForKey:@"ask_for_tip"];
        cell.replyButton.tag=indexPath.row;
        [cell.replyButton addTarget:self action:@selector(replyForAskTips:) forControlEvents:UIControlEventTouchUpInside];
        cell.textView.delegate=self;
        return cell;
    }else if (selectedIndex==2){
        Notification2TableViewCell * cell =[notificationTableView dequeueReusableCellWithIdentifier:@"Notification2TableViewCell"];
        NSDictionary * dict =[message objectAtIndex:indexPath.row];
        cell.msgLbl.text =[dict valueForKey:@"message"];
        cell.textView.delegate=self;
        cell.replyButton.tag=indexPath.row;
        [cell.replyButton addTarget:self action:@selector(replyForMsg:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else if (selectedIndex==3){
        Notification4TableViewCell * cell =[notificationTableView dequeueReusableCellWithIdentifier:@"Notification4TableViewCell"];
        NSDictionary * dict =[follow objectAtIndex:indexPath.row];
        cell.lbl.text=[dict valueForKey:@"ask_for_tip"];
        
        return cell;
    }
    return cell;
}

-(void)getAllNotifications{
    NSString * userID =[UserData getUserID];
    NSString * str =[NSString stringWithFormat:@"%@&action=%@&userId=%@",URL_CONST,ACTION_GET_NOTIFICATION,userID];
    NSDictionary * dict = [[WebHandler sharedHandler]getDataFromWebservice:str];
    if (dict!=nil) {
        NSNumber *status = [NSNumber numberWithInteger:[[dict valueForKey:@"status"] intValue] ] ;
        if ( [status isEqual: SUCESS]) {
            int totalCount =[[dict valueForKey:@"tip_count"]intValue];
            [UserData setNotificationCount:totalCount];
            
            invitation =[[NSMutableArray alloc]initWithArray:[dict valueForKey:@"invitation"]];
            ask_for_tip =[[NSMutableArray alloc]initWithArray:[dict valueForKey:@"ask_for_tip"]];
            follow =[[NSMutableArray alloc]initWithArray:[dict valueForKey:@"follow"]];
           message =[[NSMutableArray alloc]initWithArray:[dict valueForKey:@"message"]];
            
            NSDictionary * dict =@{
                                   @"invitation":invitation,
                                   @"ask_for_tip":ask_for_tip,
                                   @"follow":follow,
                                   @"message":message
                                   };
            [UserData setNotificationDict:dict];
            NSDictionary * not_Dict=@{@"tip_count":[NSString stringWithFormat:@"%d",totalCount]};
            [[NSNotificationCenter defaultCenter] postNotificationName:throwNotificationStatus object:not_Dict];
            [self performSelectorOnMainThread:@selector(reloadTableviews) withObject:nil waitUntilDone:YES];
        }else {
              [self performSelectorOnMainThread:@selector(reloadTableviews) withObject:nil waitUntilDone:YES];
        }
    }else
          [self performSelectorOnMainThread:@selector(reloadTableviews) withObject:nil waitUntilDone:YES];
}
-(void)reloadTableviews{
    [notificationTableView reloadData];
    [self.view hideLoader];
}

# pragma mark  UITextView Delegates
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Write Message"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}


- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Write Message";
        textView.textColor = [UIColor lightGrayColor];
    }
    [textView resignFirstResponder];
}

-(void)replyForAskTips:(UIButton *)btn{
    [self.view endEditing:YES];
    NSIndexPath * ip =[NSIndexPath indexPathForRow:btn.tag inSection:0];
    Notification2TableViewCell * cell = [notificationTableView cellForRowAtIndexPath:ip];
    if ( [cell.textView.text isEqualToString:@"Write Message"]) {
        [self.view makeToast:@"Please write message" duration:toastDuration position:toastPositionBottomUp];
    }else{
        
    }
}
-(void)askForTipsWebservice{
    
}
-(void)replyForMsg:(UIButton *)btn{
    [self.view endEditing:YES];
    NSIndexPath * ip =[NSIndexPath indexPathForRow:btn.tag inSection:0];
    Notification2TableViewCell * cell = [notificationTableView cellForRowAtIndexPath:ip];
    if ( [cell.textView.text isEqualToString:@"Write Message"]) {
        [self.view makeToast:@"Please write message" duration:toastDuration position:toastPositionBottomUp];
    }else{
        
    }
}
-(void)msgWebservice{
    
}
@end
