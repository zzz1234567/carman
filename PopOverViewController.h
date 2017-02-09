//
//  PopOverViewController.h
//  ActionSheetDemo
//
//  Created by Gabriel Theodoropoulos on 23/4/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PopOverViewControllerDelegate

//-(void)userDataChangedWithUsername:(NSString *)username andAgeRange:(NSString *)ageRange andGender:(NSString *)gender;

@end


@interface PopOverViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>

@property (nonatomic, strong) id<PopOverViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *txtName;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerAge;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segGender;


- (IBAction)done:(id)sender;

@end
