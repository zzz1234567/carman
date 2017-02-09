//
//  ApothecariesListController.h
//  NewsApp
//
//  Created by Zzz on 15.02.16.
//  Copyright © 2016 Zzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApothecariesCell.h"
#import "OwnHttpReader.h"
#import "UserAccount.h"
#import "TopicsCell.h"
#import "AppDelegate.h"

//#import "ArticleController.h" // testing only

//@protocol ApothecariesListControllerDelegate <NSObject>
//- (void)showMapDelegation;
//@end

@interface ApothecariesListController : UserAccount <ApothecariesCellDelegate, DrugstoreDeskDelegate, OwnHttpReaderDelegate> {
    BOOL preorderHasSent;
}

//@property (strong, nonatomic) IBOutlet UIButton *askPriceBtn;

//@property (nonatomic, weak) id <ApothecariesListControllerDelegate> delegate;

@property (nonatomic, strong) NSArray *medicinesTNList;
@property (nonatomic,weak) ApothecariesCell *currentCell;
@property (weak, nonatomic) IBOutlet UITableView *articleTbl;
@property (nonatomic) BOOL approvedDeleting;
@property (weak, nonatomic) IBOutlet UIButton *findDrugstore;
@property (weak, nonatomic) IBOutlet UIButton *askThePriceBtn;
@property (nonatomic) BOOL preorderHasSent;

//@property (nonatomic, weak) ViewController *parentObject;

- (IBAction)previousView:(id)sender;
- (IBAction)price_availability:(id)sender;

@end
