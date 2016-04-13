//
//  AddPostViewController.m
//  Traveller_ObjC
//
//  Created by Sagar Shirbhate on 13/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import "AddPostViewController.h"

@interface AddPostViewController ()

@end

@implementation AddPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 }

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)segmentSwitch:(UISegmentedControl *)segmentedControl{
  selectedIndex =(int)segmentedControl.selectedSegmentIndex;
    switch (selectedIndex) {
            //==============================1st selected============================
        case 0:
        {
            
        }break;
             //==============================2nd selected============================
        case 1:
        {
            
        }break;
             //==============================3rd selected============================
        case 2:
        {
            
        }break;
             //==============================4th selected============================
        case 3:
        {
            
        }break;
        default:
            break;
    }
}

-(void)viewDidAppear:(BOOL)animated{
    
    txtPlaceSearch.placeSearchDelegate                 = self;
    txtPlaceSearch.strApiKey                           = @"AIzaSyCDi2dklT-95tEHqYoE7Tklwzn3eJP-MtM";
    txtPlaceSearch.superViewOfList                     = self.view;  // View, on which Autocompletion list should be appeared.
    txtPlaceSearch.autoCompleteShouldHideOnSelection   = YES;
    txtPlaceSearch.maximumNumberOfAutoCompleteRows     = 2;
    txtPlaceSearch.autoCompleteRegularFontName =  font_regular;
    txtPlaceSearch.autoCompleteBoldFontName = font_bold;
    txtPlaceSearch.autoCompleteTableCornerRadius=0.0;
    txtPlaceSearch.autoCompleteRowHeight=35;
    txtPlaceSearch.autoCompleteTableCellTextColor=[UIColor blackColor];
    txtPlaceSearch.autoCompleteFontSize=font_size_normal_regular;
    txtPlaceSearch.autoCompleteTableBorderWidth=1.0;
    txtPlaceSearch.autoCompleteTableBorderColor=(__bridge UIColor *)([UIColor lightGrayColor].CGColor);
    [txtPlaceSearch.autoCompleteTableView addShaddow];
    txtPlaceSearch.showTextFieldDropShadowWhenAutoCompleteTableIsOpen=YES;
    txtPlaceSearch.autoCompleteShouldHideOnSelection=YES;
    txtPlaceSearch.autoCompleteShouldHideClosingKeyboard=YES;
    txtPlaceSearch.autoCompleteShouldSelectOnExactMatchAutomatically = YES;
    txtPlaceSearch.autoCompleteTableFrame = CGRectMake((self.view.frame.size.width-txtPlaceSearch.frame.size.width)*0.5, txtPlaceSearch.frame.size.height+100.0, txtPlaceSearch.frame.size.width, 186);
}

#pragma mark - Place search Textfield Delegates

-(void)placeSearch:(MVPlaceSearchTextField*)textField ResponseForSelectedPlace:(GMSPlace*)responseDict{
    [self.view endEditing:YES];
    heightOfMapView.constant=200;
    mapView.hidden=NO;
    [self addPin:responseDict];
}
-(void)placeSearchWillShowResult:(MVPlaceSearchTextField*)textField{
    heightOfMapView.constant=0;
    mapView.hidden=YES;
}
-(void)placeSearchWillHideResult:(MVPlaceSearchTextField*)textField{
    
}
-(void)placeSearch:(MVPlaceSearchTextField*)textField ResultCell:(UITableViewCell*)cell withPlaceObject:(PlaceObject*)placeObject atIndex:(NSInteger)index{
    cell.contentView.backgroundColor = [UIColor whiteColor];
}

-(void)addPin:(GMSPlace *)place{
    
    [mapView removeAnnotations:mapView.annotations];
    
    CLLocationCoordinate2D coord = place.coordinate;
    NSLog(@"%@",place.name);
    NSLog(@"%@", place.formattedAddress);
    
    MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.01);
    MKCoordinateRegion region = {coord, span};
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate:coord];
    [annotation setTitle:place.name];
    [annotation setSubtitle:place.formattedAddress];
    [mapView setRegion:region];
    [mapView addAnnotation:annotation];
}


- (IBAction)btnGalleryClicked:(id)sender
{
    ipc= [[UIImagePickerController alloc] init];
    ipc.delegate = self;
    ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    if(!iPAD)
        [self presentViewController:ipc animated:YES completion:nil];
    else
    {
        ipc.modalPresentationStyle = UIModalPresentationPopover;
        ipc.popoverPresentationController.sourceView = btnGallery;
        [self presentViewController:ipc animated:YES completion:nil];
    }
}

- (IBAction)btnCameraClicked:(id)sender
{
    ipc = [[UIImagePickerController alloc] init];
    ipc.delegate = self;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:ipc animated:YES completion:NULL];
    }
    else
    {
        [self.view makeToast:@"No Camera Available" duration:toastDuration position:toastPositionBottomUp];
    }
}

#pragma mark - ImagePickerController Delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if(!iPAD) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    } else {
        [popover dismissPopoverAnimated:YES];
    }
    postImageView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


# pragma mark  UITextView Delegates
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    switch (selectedIndex) {
        case 0:
        {
            if ([textView.text isEqualToString:@"  Write Message 1"]) {
                textView.text = @"";
                textView.textColor = [UIColor blackColor]; //optional
            }
        }break;
            
        case 1:
        {
            if ([textView.text isEqualToString:@"  Write Message 2"]) {
                textView.text = @"";
                textView.textColor = [UIColor blackColor]; //optional
            }
        }break;
            
        case 2:
        {
            if ([textView.text isEqualToString:@"  Write Message 3"]) {
                textView.text = @"";
                textView.textColor = [UIColor blackColor]; //optional
            }
        }break;
            
        case 3:
        {
            if ([textView.text isEqualToString:@"  Write Message 4"]) {
                textView.text = @"";
                textView.textColor = [UIColor blackColor]; //optional
            }
        }break;
            
        default:
            break;
    }
    [textView becomeFirstResponder];
  
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    switch (selectedIndex) {
        case 0:
        {
            if ([textView.text isEqualToString:@""]) {
                textView.text = @"  Write Message 1";
                textView.textColor = [UIColor lightGrayColor];
            }
        }break;
            
        case 1:
        {
            if ([textView.text isEqualToString:@""]) {
                textView.text = @"  Write Message 2";
                textView.textColor = [UIColor lightGrayColor];
            }
        }break;
            
        case 2:
        {
            if ([textView.text isEqualToString:@""]) {
                textView.text = @"  Write Message 3";
                textView.textColor = [UIColor lightGrayColor];
            }
        }break;
            
        case 3:
        {
            if ([textView.text isEqualToString:@""]) {
                textView.text = @"  Write Message 4";
                textView.textColor = [UIColor lightGrayColor];
            }
            
        }break;
            
        default:
            break;
    }
    [textView resignFirstResponder];
}

#pragma mark ============== Call Webservice ================

- (void)upload {
    
    
    NSDictionary *parameters = @{
                                 @"action": @"addUserActivity",
                                 @"userId": @"3",
                                 @"cityId": @"152",
                                 @"title": @"Shanivar Wada Testing",
                                 @"description": @"Shanivar Wada Testing",
                                 @"activity_type": @"6",
                                 };

    [[WebHandler sharedHandler]uploadDataWithImage:[UIImage imageNamed:@"avatar.jpg"] forKey:@"file1" andParameters:parameters OnUrl:URL_CONST completion:^(NSDictionary * responceDict) {
  
    }];
}



@end
