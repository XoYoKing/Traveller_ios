//
//  MenuViewController.m
//  Traveller_ObjC
//
//  Created by Sagar Shirbhate on 07/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Setup Header ScrollView
-(void)SetupHeaderScrollView{
    
    for (int i=(int) _myScrollView.subviews.count - 1; i>=0; i--)
        [[_myScrollView.subviews objectAtIndex:i] removeFromSuperview];
    
    
    
    CGFloat scrollWidth = 0.f;
    buttonArray=[[NSMutableArray alloc]init];
    for ( int j=0; j<company_worksites.count; j++)
    {
        NSString * name =[[company_worksites objectAtIndex: j]valueForKey:@"location_name"];
        CGSize size = [name sizeWithAttributes:
                       @{NSFontAttributeName: [UIFont fontWithName:font_family_Bold size:17]}];
        CGSize textSize = CGSizeMake(ceilf(size.width), ceilf(size.height));
        CGFloat strikeWidth = textSize.width;
        CGRect frame = CGRectMake(scrollWidth, 10,strikeWidth+20, 40);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTag:j];
        button.frame = frame;
        [button setBackgroundColor:[UIColor whiteColor]];
        button.titleLabel.textColor=[UIColor blackColor];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.textAlignment=NSTextAlignmentCenter;
        [button addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:name forState:UIControlStateNormal];
        
        scrollWidth= scrollWidth+strikeWidth+20;
        
        if (j==selectedIndex) {
            UIView *bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(0, button.frame.size.height - 5, button.frame.size.width, 5)];
            bottomBorder.backgroundColor = kAppThemeRedColor;
            [button addSubview:bottomBorder];
            if (iPhone6||iPhone6plus) {
                button.titleLabel.font=[UIFont fontWithName:font_family_Bold size:17];
            }else {
                button.titleLabel.font=[UIFont fontWithName:font_family_Bold size:15];
            }
        }else {
            if (iPhone6||iPhone6plus) {
                button.titleLabel.font=[UIFont fontWithName:font_family_light size:17];
            }else{
                button.titleLabel.font=[UIFont fontWithName:font_family_light size:15];
            }
        }
        
        [buttonArray addObject:button];
        [_myScrollView addSubview:button];
        
    }
    _myScrollView.contentSize = CGSizeMake(scrollWidth, 50.f);
    _myScrollView.pagingEnabled = NO;
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
            UIView *bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(0, sender.frame.size.height - 5, sender.frame.size.width, 5)];
            bottomBorder.backgroundColor = kAppThemeRedColor;
            [sender addSubview:bottomBorder];
            if (iPhone6||iPhone6plus) {
                sender.titleLabel.font=[UIFont fontWithName:font_family_Bold size:17];
            }else{
                sender.titleLabel.font=[UIFont fontWithName:font_family_Bold size:15];
            }
            NSString * worksiteId = [[company_worksites objectAtIndex:index]valueForKey:@"location_id"];
            event_data=[[NSMutableArray alloc]init];
            [collectionView reloadData];
            HUD = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
            [self performSelector:@selector(LoadBookingdashBordWebservices:) withObject:worksiteId afterDelay:0.1];
            
        }
        else{
            UIButton * btn = (UIButton *) [buttonArray objectAtIndex:i];
            if (iPhone6||iPhone6plus) {
                btn.titleLabel.font=[UIFont fontWithName:font_family_light size:17];
            }else{
                btn.titleLabel.font=[UIFont fontWithName:font_family_light size:15];
            }
            UIView *bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(0, btn.frame.size.height - 5, btn.frame.size.width, 5)];
            bottomBorder.backgroundColor = [UIColor whiteColor];
            [btn addSubview:bottomBorder];
        }
    }
    
    count=[[NSString stringWithFormat:@"%ld",(long)sender.tag]intValue];
    CGRect frame1 = _myScrollView.frame;
    UIButton * bt=(UIButton*)[buttonArray objectAtIndex:index];
    frame1 =bt.frame ;
    [_myScrollView scrollRectToVisible:frame1 animated:YES];
}



@end
