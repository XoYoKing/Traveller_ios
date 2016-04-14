//
//  CitiesViewController.m
//  Traveller_ObjC
//
//  Created by Sandip Jadhav on 08/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import "CitiesViewController.h"
#import "TravellerConstants.h"
#import "CitiesCollectionViewCell.h"
#import "AddPostViewController.h"
@interface CitiesViewController ()

@end

@implementation CitiesViewController

-(void)viewDidAppear:(BOOL)animated{
    if (badgeView==nil) {
        [self addNotificationView];
    }
    if (citiesArray.count==0||citiesArray==nil) {
        [self.view showLoader];
          [self performSelectorInBackground:@selector(getCitiesData) withObject:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    self.title=@"Cities";
    citiesArray=[NSMutableArray new];
    citiesPage=1;
    citiesPagingBoolean=YES;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return citiesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CitiesCollectionViewCell *cell=[citiesCollectionView dequeueReusableCellWithReuseIdentifier:@"CitiesCollectionViewCell" forIndexPath:indexPath];
    cell.contentView.frame = [cell bounds];
    cell.cityImageView.image=[UIImage imageNamed:@"alpes.jpg"];
    [cell.placesButton addTarget:self action:@selector(openPostForm:) forControlEvents:UIControlEventTouchUpInside];
    
    NSDictionary * dataDict =[citiesArray objectAtIndex:indexPath.row];
    
    NSString * city =[dataDict valueForKey:@"city"];
    NSString * country =[dataDict valueForKey:@"country"];
    NSString * state =[dataDict valueForKey:@"state"];
    
    if (![city isKindOfClass:[NSNull class]]&&![state isKindOfClass:[NSNull class]]) {
        
        if (![country isKindOfClass:[NSNull class]]) {
            if ([city isEqualToString:state]) {
                cell.cityNameLbl.text =[NSString stringWithFormat:@" %@ , %@ ",city,country];
            }else {
                cell.cityNameLbl.text =[NSString stringWithFormat:@" %@ , %@ , %@ ",city , state,country];
            }
        }else {
            if ([city isEqualToString:state]) {
                cell.cityNameLbl.text =[NSString stringWithFormat:@" %@ ",city];
            }else {
                cell.cityNameLbl.text =[NSString stringWithFormat:@" %@ , %@ ",city , state];
            }
        }
    }else{
        cell.cityNameLbl.text =@"City Name Not Available Now";
    }
    
    
    
    //Checked for post Image
    NSString * urlStringForImage =[dataDict valueForKey:@"image"];
    if (![urlStringForImage isKindOfClass:[NSNull class]]) {
        NSURL * profileUrl =[NSURL URLWithString:urlStringForImage];
        [cell.cityImageView sd_setImageWithURL:profileUrl placeholderImage:[UIImage imageNamed:@"No_User"]];
    }

    [cell layoutIfNeeded];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width-20, self.view.frame.size.width/2+140);
}

-(void)openPostForm:(UIButton *)btn{
    AddPostViewController * vc =[self.storyboard instantiateViewControllerWithIdentifier:@"AddPostViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)addShaddowToView:(UIView *)view{
    view.layer.shadowOffset = CGSizeMake(2, 2);
    view.layer.shadowColor = [[UIColor blackColor] CGColor];
    view.layer.shadowRadius = 4.0f;
    view.layer.shadowOpacity = 0.80f;
}

-(void)addNotificationView{
    UIButton *  notificationButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    notificationButton.frame = CGRectMake(self.view.frame.size.width-65,self.view.frame.size.height-65,50,50);
    notificationButton.titleLabel.font =[UIFont fontWithName:fontIcomoon size:25];
    notificationButton.titleLabel.textColor=[UIColor whiteColor];
    notificationButton.backgroundColor=[UIColor blackColor];
    notificationButton.layer.cornerRadius=25;
    [notificationButton setTitle:[NSString stringWithUTF8String:ICOMOON_BELL] forState:UIControlStateNormal];
    [notificationButton addTarget:self action:@selector(openNotificationView) forControlEvents:UIControlEventTouchUpInside];
    self.navigationController.navigationBarHidden=NO;
    badgeView = [GIBadgeView new];
    [notificationButton addSubview:badgeView];
    badgeView.badgeValue = 5;
    [self addShaddowToView:notificationButton];
    [self.view addSubview:notificationButton];
    [self.view bringSubviewToFront:notificationButton];
}
-(void)openNotificationView{
    NotificationsViewController* vc =[self.storyboard instantiateViewControllerWithIdentifier:@"NotificationsViewController"];
    vc.fromMenu=NO;
    [self.navigationController pushViewController:vc animated:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getCitiesData{
  
        NSString * userID =[UserData getUserID];
        NSString *apiURL =  [NSString stringWithFormat:@"%@action=%@&userId=%@&page=%d",URL_CONST,ACTION_GET_CITIES,userID,citiesPage];
        NSDictionary * dict = [[WebHandler sharedHandler]getDataFromWebservice:apiURL];
        [citiesArray addObjectsFromArray:[dict valueForKey:@"data"]];
        [self performSelectorOnMainThread:@selector(reloadCollectionView) withObject:nil waitUntilDone:YES];
}
    
    -(void)getCitiesDataPaging{
        NSString * userID =[UserData getUserID];
        NSString *apiURL =  [NSString stringWithFormat:@"%@action=%@&userId=%@&page=%d",URL_CONST,ACTION_GET_CITIES,userID,citiesPage];
        NSDictionary * dict = [[WebHandler sharedHandler]getDataFromWebservice:apiURL];
        NSArray * data =[dict valueForKey:@"data"];
        if (data.count==0) {
            citiesPagingBoolean=NO;
        }else{
            [citiesArray addObjectsFromArray:[dict valueForKey:@"data"]];
            citiesPagingBoolean=YES;
        }
        [self performSelectorOnMainThread:@selector(reloadCollectionView) withObject:nil waitUntilDone:YES];
    }

-(void)reloadCollectionView{
    [citiesCollectionView reloadData];
    [self.view hideLoader];
    if (citiesArray.count==0) {
        [self.view makeToast:@"No Cities Available Right Now" duration:toastDuration position:toastPositionBottomUp];
    }
}


@end
