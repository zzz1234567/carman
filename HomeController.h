//
//  HomeController.h
//  NewsApp
//
//  Created by Zzz on 12.02.16.
//  Copyright © 2016 Zzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeContent.h"
#import "TopicsCell.h"
#import "DescrByNameTblViewController.h"
#import "ArticleController.h"
#import "JLTStepper.h"

@interface HomeController : UIViewController <TopicsCellDelegate, UIActionSheetDelegate, UIPopoverPresentationControllerDelegate, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UIGestureRecognizerDelegate> {
    NSMutableArray *searchIndexKeys;
    NSMutableArray *searchIndexKeys_copy;
    NSArray *medicinesTNList;
    NSArray *medicinesTNList_copy;
    IBOutlet UISearchBar *searchBarOwn;
    NSNumber *rowsCounter;
//    NSNumber *realSection;
    NSMutableArray *fLetterArray;
    NSMutableDictionary *firstLetters;
    NSString *oldLetter;
    NSNumber *specialIndexer;
    
    IBOutlet UIButton *barButton;
//    IBOutlet UIBarButtonItem *homeTopBarTitle;
}

@property (nonatomic, strong) NSArray *medicinesTNList;
@property (nonatomic, strong) NSArray *medicinesTNList_copy;
@property (nonatomic, strong) NSNumber *clickedRowIndex;
@property (nonatomic, strong) NSNumber *rowsCounter;
//@property (nonatomic, retain) NSNumber *realSection;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBarOwn;
@property (nonatomic, strong) NSMutableArray *searchIndexKeys;
@property (nonatomic, strong) NSMutableArray *searchIndexKeys_copy;
@property (nonatomic, strong) NSMutableArray *fLetterArray;
@property (nonatomic, strong) NSMutableDictionary *firstLetters;
@property (nonatomic, strong) NSString *oldLetter;
@property (strong, nonatomic) IBOutlet UITableView *tbl;
@property (strong, nonatomic) NSNumber *specialIndexer;

@property (weak,nonatomic) IBOutlet UIButton *barButton;
//@property (weak,nonatomic) IBOutlet UIBarButtonItem *homeTopBarTitle;

@property (nonatomic, weak) IBOutlet UISwitch *switcher;

@property (nonatomic, retain) NSString *popoverTitle;

- (IBAction)showMenu:(id)sender;
- (IBAction)showBarcodeMenu:(id)sender forEvent:(UIEvent *)event;
- (IBAction)showColorsActionSheet:(id)sender;
- (void)userTappedOnLink:(UIGestureRecognizer*)gestureRecognizer;
- (void)changeSwitch:(id)sender forEvent:(UIEvent *)event;
- (void)medicinesChoosedListView:(id)sender forEvent:(UIEvent *)event;
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchTerm;

@property(nonatomic,retain)UIPopoverPresentationController *dateTimePopover8;
@property(nonatomic,retain) IBOutlet UIButton *medicinesSelectedBtn;

@property(nonatomic,weak) TopicsCell *currentCell;
@property (weak,nonatomic) IBOutlet UIView *totalMedicinesDIV;
@property (weak,nonatomic) IBOutlet UILabel *totalQuantity;
@property (weak,nonatomic) IBOutlet UIButton *barcodeController;
@property (weak,nonatomic) IBOutlet UIView *barcodeSubMenu;
@property (weak,nonatomic) IBOutlet UIView *overlayForMainWindow;
@property (weak,nonatomic) IBOutlet UIView *overlayForTopBar;

@property (weak,nonatomic) NSNumber *currentSection;

@property (nonatomic) BOOL showMap;

-(UIImage *)imageFromColor:(UIColor *)color;


@end

