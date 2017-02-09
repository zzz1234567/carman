//
//  PreorderData.h
//  Навигатор лекарств
//
//  Created by Zzz on 30.05.16.
//  Copyright © 2016 Zzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MedicinesCell.h"
#import "UserAccount.h"
#import "OwnHttpReader.h"

@interface PreorderData: UserAccount <MedicinesCellDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *medicinesTNList;
@property (nonatomic,weak) MedicinesCell *currentCell;
@property (strong, nonatomic) UITableView *preorderTbl;
@property (nonatomic) BOOL approvedDeleting;
@property (nonatomic,weak) IBOutlet UISegmentedControl *segmentControl;
@property (nonatomic,weak) IBOutlet UIView *contentHolder;
@property (nonatomic,weak) IBOutlet UIView *orderBtn;
@property (nonatomic,weak) IBOutlet UIView *quantView;
@property (nonatomic,weak) IBOutlet UIView *sumView;

@property (nonatomic,weak) IBOutlet UITextField *preorderTitleText;
@property (nonatomic,weak) IBOutlet UITextField *preorderViewId;
@property (nonatomic,weak) IBOutlet UILabel *apothecPhone;
@property (nonatomic,weak) IBOutlet UILabel *apothecAddress;
@property (nonatomic,weak) IBOutlet UILabel *apothecWebsite;
@property (nonatomic,weak) IBOutlet UILabel *apothecWorkingHours;

@property (nonatomic,weak) NSDictionary *preorderData;

@property (weak, nonatomic) NSString *apothecaryIdNumber;
@property (nonatomic) NSMutableArray *preorderResponse;

@property (nonatomic,weak) IBOutlet UILabel *totalPrice;
@property (nonatomic,weak) IBOutlet UILabel *totalQuant;

- (IBAction)previousView:(id)sender;
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context;
-(IBAction)orderApprovingSendToUserAccount:(id)sender;

@end
