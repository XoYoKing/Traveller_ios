//
//  WriteMessage ViewController.h
//  Traveller_ObjC
//
//  Created by Sandip Jadhav on 23/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WriteMessage_ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property(nonatomic,strong)NSString * publicId;
- (IBAction)sendButtonClick:(id)sender;
@end
