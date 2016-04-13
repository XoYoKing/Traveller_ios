//
//  AddPostViewController.h
//  Traveller_ObjC
//
//  Created by Sagar Shirbhate on 13/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MVPlaceSearchTextField.h"
#import <GoogleMaps/GoogleMaps.h>
@interface AddPostViewController : UIViewController<PlaceSearchTextFieldDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextViewDelegate>
{
    
    int selectedIndex;
    
    __weak IBOutlet MKMapView *mapView;
    
    __weak IBOutlet NSLayoutConstraint *heightOfMapView;
    
    __weak IBOutlet UIImageView *postImageView;
    
    __weak IBOutlet UIButton *btnCamera;
    __weak IBOutlet UIButton *btnGallery;
    __weak IBOutlet UIButton *btnSubmit
    ;
    __weak IBOutlet UILabel *addImageLbl;
    __weak IBOutlet UILabel *addLocationLbl;
    __weak IBOutlet UILabel *addPostDetailsLbl;
    
    __weak IBOutlet UITextView *descriptionTextView;
    
    __weak IBOutlet MVPlaceSearchTextField *txtPlaceSearch;
    
    UIImagePickerController *ipc;
    UIPopoverController *popover;
}
@end
