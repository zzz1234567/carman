//
//  ApothecariesCell.h
//  NewsApp
//
//  Created by Zzz on 20.02.16.
//  Copyright © 2016 Zzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PreorderData.h"
#import "DrugstoreDesk.h"

@protocol ApothecariesCellDelegate;

@interface ApothecariesCell : UITableViewCell <DrugstoreDeskDelegate>

// delegating
//Manual Properties
@property (strong, nonatomic) NSIndexPath *buttonIndexPath;
//Delegate
@property (nonatomic, weak) id <ApothecariesCellDelegate> delegate;
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
@property (nonatomic, weak) IBOutlet UITextField *txt;
@property (nonatomic, weak) IBOutlet UILabel *SectionRowHolder;
@property (nonatomic, weak) IBOutlet UIView *OnlineHolder;
@property (nonatomic, weak) IBOutlet UIView *OfflineHolder;
@property (nonatomic, weak) IBOutlet UILabel *OnlineText;
@property (nonatomic, weak) IBOutlet UILabel *OfflineText;
@property (nonatomic, weak) IBOutlet UIView *ProcessingHolder;
@property (nonatomic, weak) IBOutlet UIView *DoneHolder;
@property (nonatomic, weak) IBOutlet UILabel *ProcessingText;
@property (nonatomic, weak) IBOutlet UILabel *DoneText;
@property (nonatomic, weak) IBOutlet UILabel *PresenceText;

@property (nonatomic,weak) NSDictionary *preorderData;
@property (weak, nonatomic) NSString *apothecaryIdNumber;
@property (nonatomic) NSMutableDictionary *preorderResponse;

//- (IBAction)apothRowClicked:(id)sender;

//- (IBAction)changeSwitch:(id)sender;
//- (void)animateIt:(UIView *)objectToAnimate;


//- (IBAction)showUserDataEntryForm:(id)sender;

- (void)stepperValueDidChange:(UIStepper *)stepper;
- (void)theTableReloader;
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;
@end


@protocol ApothecariesCellDelegate <NSObject>

- (void)childViewController:(ApothecariesCell*)viewController
               theCellIndex:(long)index
             apothIdentification:(int)value
             apothecaryData:(NSDictionary *)arrayedData
            preorderDetails:(NSDictionary *)preorderDtls;

- (void)deleteZero_Alerting :(NSIndexPath *)indexPath theCell:(UITableViewCell *)cell obj2remove:(NSMutableDictionary *)obj;

@end


