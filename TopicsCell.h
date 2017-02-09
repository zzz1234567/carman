//
//  TopicsCell.h
//  NewsApp
//
//  Created by Zzz on 20.02.16.
//  Copyright © 2016 Zzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TopicsCellDelegate <NSObject>
- (void)buttonActionwith :(NSIndexPath *)indexPath sender:(id)sender;
@end

@interface TopicsCell : UITableViewCell

// delegating
//Manual Properties
@property (strong, nonatomic) NSIndexPath *buttonIndexPath;
//Delegate
@property (nonatomic, weak) id <TopicsCellDelegate> delegate;
// :END

@property (nonatomic, strong) UIPopoverController *userDataPopover;

@property (nonatomic, weak) IBOutlet UILabel *header;
@property (nonatomic, weak) IBOutlet UILabel *text;
@property (nonatomic, weak) IBOutlet UITextField *addToTheOrderText;
@property (nonatomic, weak) IBOutlet UISwitch *switcher;
@property (nonatomic, weak) IBOutlet UILabel *quantity;
@property (nonatomic, weak) IBOutlet UIButton *plusSign;
@property (nonatomic, weak) IBOutlet UIButton *minusSign;
@property (nonatomic, weak) IBOutlet UIButton *respToClick;
@property (nonatomic, weak) IBOutlet UIStepper *defaultStepper;
@property (nonatomic, weak) IBOutlet UILabel *defaultStepperLabel;
@property (nonatomic, retain) IBOutlet UITextField *txt;
@property (nonatomic, weak) IBOutlet UILabel *SectionRowHolder;

- (IBAction)showAlert:(id)sender;

//- (IBAction)changeSwitch:(id)sender;
//- (void)animateIt:(UIView *)objectToAnimate;


//- (IBAction)showUserDataEntryForm:(id)sender;

- (void)stepperValueDidChange:(UIStepper *)stepper;

@end
