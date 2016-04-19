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
}

-(void)viewWillAppear:(BOOL)animated{
    // to scroll tableview at bottom
    if (commentTableView.contentSize.height > commentTableView.frame.size.height)
    {
        CGPoint offset = CGPointMake(0, commentTableView.contentSize.height -     commentTableView.frame.size.height);
        [commentTableView setContentOffset:offset animated:YES];
    }
    

}

-(void)setupView{
    closeButton.titleLabel.font=[UIFont fontWithName:fontIcomoon size:25];
    [closeButton setTitle:[NSString stringWithUTF8String:ICOMOON_CROSS] forState:UIControlStateNormal];
    closeButton.layer.cornerRadius=20;
    closeButton.backgroundColor=[UIColor whiteColor];
    [self addShaddowToView:closeButton];
    [bgView layoutIfNeeded];
    [self performSelector:@selector(addShadowTobackground) withObject:nil afterDelay:1];
    // [self loadView];
}
-(void)addShadowTobackground{
    bgView.layer.cornerRadius=9;
    [self addShaddowToView:bgView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 25;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ComentTableViewCell * cell = [commentTableView dequeueReusableCellWithIdentifier:@"ComentTableViewCell"];
    
    cell.commentLbl.numberOfLines = 0;
    
    //Step 1: Define a normal attributed string for non-link texts
    NSString *string = @"Sagar Shirbhate commented Feels so go Here.. ";
    NSDictionary *attributes = @{NSForegroundColorAttributeName: [UIColor blackColor],NSFontAttributeName: [UIFont fontWithName:font_regular size:12]};
    cell.commentLbl.attributedText = [[NSAttributedString alloc]initWithString:string attributes:attributes];
    
    void(^handler)(FRHyperLabel *label, NSString *substring) = ^(FRHyperLabel *label, NSString *substring){
        if ([substring isEqualToString:@"Sagar Shirbhate"]) {
            [self openUserProfile];
        }
    };
    
    
    //Step 3: Add link substrings
    [cell.commentLbl setLinksForSubstrings:@[@"Tulshibag , Pune", @"Sagar Shirbhate"] withLinkHandler:handler];
    
    return cell;
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
