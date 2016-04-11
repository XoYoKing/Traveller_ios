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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"Notifications";
    self.navigationController.navigationBarHidden=NO;
    selectedIndex=0;
    [self addScrollview];
    
    if (_fromMenu==NO) {
    UIButton *btn =  [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0,0,25,25);
    btn.tintColor=[UIColor whiteColor];
    [btn setImage:[UIImage imageNamed:@"back_black"] forState:UIControlStateNormal];
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
                       @{NSFontAttributeName: [UIFont fontWithName:font_family_regular size:17]}];
        CGSize textSize = CGSizeMake(ceilf(size.width), ceilf(size.height));
        CGFloat strikeWidth = textSize.width;
        CGRect frame = CGRectMake(scrollWidth, 5,strikeWidth+20, 40);
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
            button.backgroundColor= Check_All_Button_Color;
            button.layer.borderColor=[UIColor whiteColor].CGColor;
            [self addShaddowToView:button];
            if (iPhone6||iPhone6plus) {
                button.titleLabel.font=[UIFont fontWithName:font_family_regular size:17];
            }else {
                button.titleLabel.font=[UIFont fontWithName:font_family_regular size:15];
            }
        }else {
            button.backgroundColor= [UIColor blackColor];
            [self removeShaddowToView:button];
            button.layer.borderColor=[UIColor whiteColor].CGColor;
            if (iPhone6||iPhone6plus) {
                button.titleLabel.font=[UIFont fontWithName:font_family_regular size:17];
            }else{
                button.titleLabel.font=[UIFont fontWithName:font_family_regular size:15];
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
        if(i==index)
        {
            UIButton * btn = (UIButton *) [buttonArray objectAtIndex:i];
            btn.backgroundColor= Check_All_Button_Color;
            [self addShaddowToView:btn];
            
        }
        else{
            UIButton * btn = (UIButton *) [buttonArray objectAtIndex:i];
            btn.backgroundColor=[UIColor blackColor];
            [self removeShaddowToView:btn];
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
    return 25;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{   UITableViewCell *cell ;
    if (selectedIndex==0) {
        Notification1TableViewCell * cell =[notificationTableView dequeueReusableCellWithIdentifier:@"Notification1TableViewCell"];
        return cell;
    }else if(selectedIndex==1){
        Notification2TableViewCell * cell =[notificationTableView dequeueReusableCellWithIdentifier:@"Notification2TableViewCell"];
        return cell;
    }else if (selectedIndex==2){
        Notification2TableViewCell * cell =[notificationTableView dequeueReusableCellWithIdentifier:@"Notification2TableViewCell"];
        return cell;
    }else if (selectedIndex==3){
        Notification4TableViewCell * cell =[notificationTableView dequeueReusableCellWithIdentifier:@"Notification4TableViewCell"];
        return cell;
    }
    return cell;
}


@end
