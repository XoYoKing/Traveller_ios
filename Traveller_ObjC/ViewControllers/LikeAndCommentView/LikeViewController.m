//
//  LikeViewController.m
//  Traveller_ObjC
//
//  Created by Sandip Jadhav on 10/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import "LikeViewController.h"

@interface LikeViewController ()

@end

@implementation LikeViewController

- (IBAction)dismicclick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:Nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    // Do any additional setup after loading the view.
    [self setupView];
}
-(void)setupView{
    closeButton.titleLabel.font=[UIFont fontWithName:fontIcomoon size:25];
    [closeButton setTitle:[NSString stringWithUTF8String:ICOMOON_UNCHECK] forState:UIControlStateNormal];
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
    return 25;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        LikeTableViewCell * cell = [likeTableView dequeueReusableCellWithIdentifier:@"LikeTableViewCell"];
        return cell;
}

-(void)addShaddowToView:(UIView *)view{
    view.layer.shadowOffset = CGSizeMake(1, 1);
    view.layer.shadowColor = [[UIColor blackColor] CGColor];
    view.layer.shadowRadius = 4.0f;
    view.layer.shadowOpacity = 0.80f;
}
@end
