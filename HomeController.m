//
//  HomeController.m
//  NewsApp
//
//  Created by Zzz on 12.02.16.
//  Copyright © 2016 Zzz. All rights reserved.
//

#import "HomeController.h"
#import "SWRevealViewController.h"
#import "PopOverViewController.h"
#import <QuartzCore/QuartzCore.h>

#define tradenamesFile @"forscanner_extended"
#define DIGITALPHA	@"5, 9, H, L, M, N, V, А, Б, В, Г, Д, Е, Ж, З, И, Й, К, Л, М, Н, О, П, Р, С, Т, У, Ф, Х, Ц, Ч, Ш, Э, Ю, Я"
#define kFilename @"data_new.plist"

@interface HomeController ()
    
@end

@implementation HomeController {
    double stepperOldValue;
}

@synthesize barButton = _barButton;
@synthesize medicinesTNList = _medicinesTNList;
@synthesize medicinesTNList_copy = _medicinesTNList_copy;
@synthesize clickedRowIndex = _clickedRowIndex;
@synthesize searchBarOwn;
@synthesize searchIndexKeys = _searchIndexKeys;
@synthesize searchIndexKeys_copy = _searchIndexKeys_copy;
@synthesize rowsCounter = _rowsCounter;
//@synthesize realSection = _realSection;
@synthesize firstLetters = _firstLetters;
@synthesize fLetterArray = _fLetterArray;
@synthesize oldLetter = _oldLetter;
@synthesize tbl;
@synthesize specialIndexer = _specialIndexer;
@synthesize popoverTitle = _popoverTitle;
@synthesize medicinesSelectedBtn = _medicinesSelectedBtn;
@synthesize currentCell = _currentCell;
@synthesize totalMedicinesDIV = _totalMedicinesDIV;
@synthesize totalQuantity = _totalQuantity;
@synthesize barcodeController = _barcodeController;
@synthesize barcodeSubMenu = _barcodeSubMenu;
@synthesize overlayForMainWindow = _overlayForMainWindow;
@synthesize overlayForTopBar = _overlayForTopBar;
@synthesize currentSection = _currentSection;
@synthesize showMap;

- (NSNumber *) currentSection {
    return _currentSection;
}

- (UIView *) overlayForMainWindow {
    return _overlayForMainWindow;
}

- (UIView *) overlayForTopBar {
    return _overlayForTopBar;
}

- (UIView *) barcodeSubMenu {
    return _barcodeSubMenu;
}

- (UIButton *) barcodeController {
    return _barcodeController;
}

- (UILabel *) totalQuantity {
    return _totalQuantity;
}

- (UIView *) totalMedicinesDIV {
    return _totalMedicinesDIV;
}

- (UITableView *) tbl {
    return tbl;
}

- (UIButton *) medicinesSelectedBtn {
    return _medicinesSelectedBtn;
}

-(UIButton *) barButton {
    return _barButton;
}

-(TopicsCell *) currentCell {
    return _currentCell;
}

-(NSArray *)medicinesTNList {
    if (!_medicinesTNList) {
        _medicinesTNList = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:tradenamesFile ofType:@"plist"]];
    }
    return _medicinesTNList;
}

-(NSArray *)medicinesTNList_copy {
    return _medicinesTNList_copy;
}


-(NSNumber *)clickedRowIndex {
    return _clickedRowIndex;
}

-(NSNumber *)rowsCounter {
    return _rowsCounter;
}

//-(NSNumber *)realSection {
//    return _realSection;
//}

-(NSMutableDictionary *)firstLetters {
    return _firstLetters;
}

-(NSMutableArray *)fLetterArray {
    return _fLetterArray;
}

-(NSString *)oldLetter {
    return _oldLetter;
}

-(NSMutableArray *)searchIndexKeys {
    // 29.03.16 - отключаем поисковый индекс
     if (!_searchIndexKeys) {
     NSArray *readyLetters = [DIGITALPHA componentsSeparatedByString:@", "];
     //        NSLog(@"readyLetters: %@", readyLetters);
     NSMutableArray *keyArray = [[NSMutableArray alloc] init];
     [keyArray addObject:UITableViewIndexSearch];
     [keyArray addObjectsFromArray:[readyLetters sortedArrayUsingSelector:@selector(compare:)]];
     _searchIndexKeys = keyArray;
     }
     return _searchIndexKeys;
     //
//    return nil;
}

-(NSMutableArray *)searchIndexKeys_copy {
    return _searchIndexKeys_copy;
}

-(NSNumber *)specialIndexer {
    return _specialIndexer;
}



//-(UIBarButtonItem *) homeTopBarTitle {
//    return _homeTopBarTitle;
//}

-(UIImage *)imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /*
    NSArray *array = [[NSArray alloc] init];
    [array writeToFile:[self dataFilePath] atomically:YES];
    */
    
//    [tbl registerClass:[TableViewHeader class] forHeaderFooterViewReuseIdentifier:@"tblViewHeader"];
    
    [_barButton addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    
//    UIColor *lightGreenColor = [UIColor colorWithRed:0.537 green:0.816 blue:0.247 alpha:1];
//    UIColor *lightGreenColorOpaque = [UIColor colorWithRed:0.537 green:0.816 blue:0.247 alpha:0.8];
    
    UIColor *lightNavyColor = [UIColor colorWithRed:0.278 green:0.545 blue:0.855 alpha:1];
    UIColor *lightNavyColorOpaque = [UIColor colorWithRed:0.278 green:0.545 blue:0.855 alpha:0.8];
    [self.searchBarOwn setImage:[UIImage imageNamed: @"Search-22.png"]
                forSearchBarIcon:UISearchBarIconSearch
                           state:UIControlStateNormal];
//    self.searchBarOwn.layer.borderWidth = 1;
//    self.searchBarOwn.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    UIView *view = [self.searchBarOwn.subviews objectAtIndex:0];
    for (UIView *subView in view.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *cancelButton = (UIButton *)subView;
            [cancelButton setTitleColor:lightNavyColorOpaque forState:UIControlStateNormal];
            [cancelButton setTitleColor:lightNavyColor forState:UIControlStateHighlighted];
        }
    }
    
//    if(IOS_7) {
//        self.searchBarOwn.searchBarStyle = UISearchBarStyleMinimal;
    
//        self.searchBarOwn.backgroundImage = [self imageFromColor:someUIColor];
    
//    }
    

    
    // Замена цвета фона для toolbar
//    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:85.0/255.0 green:143.0/255.0 blue:220.0/255.0 alpha:1.0]];
//    [self.navigationController.navigationBar setTranslucent:NO];
//    [self.navigationItem setTitle:@"Title"];
    //:END
    
//    NSShadow* shadow = [NSShadow new];
//    shadow.shadowOffset = CGSizeMake(0.0f, 1.0f);
//    shadow.shadowColor = [UIColor redColor];
    
//    [[UIBarButtonItem appearanceWhenContainedIn:[UIToolbar class], nil]
//     setTitleTextAttributes:
//  @{NSFontAttributeName : [UIFont fontWithName:@"Helvetica" size:48.0]}
//     forState:UIControlStateNormal];

//    NSMutableDictionary *titleBarAttributes = [NSMutableDictionary dictionaryWithDictionary: [[UINavigationBar appearance] titleTextAttributes]];
//    [titleBarAttributes setValue:[UIFont fontWithName:@"Helvetica-Bold" size:18] forKey:UITextAttributeFont];
//    [[UINavigationBar appearance] setTitleTextAttributes:titleBarAttributes];

    
//    CGRect frame = CGRectMake(0, 0, 400, 44);
//    UILabel *label = [[UILabel alloc] initWithFrame:frame];
//    label.backgroundColor = [UIColor clearColor];
//    label.font = [UIFont boldSystemFontOfSize:8.0];
//    label.textColor = [UIColor whiteColor];
//    label.text = @"Sample custom Title With small Fonts ";
//    [self.navigationItem setTitleView:label];
    
//    _homeTopBarTitle setTitleTextAttributes:<#(nullable NSDictionary<NSString *,id> *)#> forState:<#(UIControlState)#>
    
        
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

    
//    [self showTotalMedicines];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    if (self.showMap) {
        [self showMapNotDelegation];
    }
    
    [self theViewReloader];
    
//    [self.medicinesSelectedBtn addTarget:self action:@selector(medicinesChoosedListView: forEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    //        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
    //                                                             bundle:nil];
    //        HomeController *homeContent=[storyboard instantiateViewControllerWithIdentifier:@"hController"];
    //        [self presentViewController:homeContent animated:NO completion:nil];
    
    [self showTotalMedicines];
//    [tbl reloadData];
    
    self.searchBarOwn.text = @"";
    [self performSelector:@selector(searchBarCancelButtonClicked:) withObject:self.searchBarOwn afterDelay:0.1];
    
    NSLog(@"Appeared");
//    [self dismissKeyboard];
//    self.searchBarOwn.text = @"";
////    [self searchBar:self.searchBarOwn textDidChange:@""];
//    [self.searchBarOwn resignFirstResponder];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
    NSLog(@"viewDidDisappear");
    _medicinesTNList = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:tradenamesFile ofType:@"plist"]];
    NSArray *readyLetters = [DIGITALPHA componentsSeparatedByString:@", "];
    //        NSLog(@"readyLetters: %@", readyLetters);
    NSMutableArray *keyArray = [[NSMutableArray alloc] init];
    [keyArray addObject:UITableViewIndexSearch];
    [keyArray addObjectsFromArray:[readyLetters sortedArrayUsingSelector:@selector(compare:)]];
    _searchIndexKeys = keyArray;
    
    //    self.title = @"Поиск по препаратам";
}

-(void)theViewReloader {
    _medicinesTNList_copy = [self.medicinesTNList copy];
    _searchIndexKeys_copy = [_searchIndexKeys copy];
    
        NSLog(@"loaded: %@ ", [self.view class]);
    //    NSLog(@"[_medicinesTNList count from load]: %d", (int) [_medicinesTNList count]);
    
    int counter = 0;
    for (NSDictionary *sectionData in _medicinesTNList) {
        NSString *curKey = [[sectionData allKeys] objectAtIndex:0];
        int summand = (int) [[sectionData objectForKey:curKey] count];
        counter = counter + summand;
    }
    
    //    int getCounterForRows = (int) [[[self.medicinesTNList objectAtIndex:section] objectForKey:currentFirstLetter] count];
    
    _rowsCounter = [NSNumber numberWithInt: counter];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(NSInteger)collectionView:(UICollectionView *)collectionView
//    numberOfItemsInSection:(NSInteger)section {
//    return 3;
//}
//
//
//-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return 1;
//}
//
//-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
//                 cellForItemAtIndexPath:(NSIndexPath *)indexPath  {
//    static NSString * CellIdentifier;
//    
//    if (indexPath.row == 0) {
//        CellIdentifier = @"CellFirst";
//    }
//    else if (indexPath.row == 1) {
//        CellIdentifier = @"CellSecond";
//    }
//    else {
//        CellIdentifier = @"CellThird";
//    }
//    UICollectionViewCell *cell = [collectionView
//                                  dequeueReusableCellWithReuseIdentifier:CellIdentifier
//                                  forIndexPath:indexPath];
//    
//    return cell;
//}

- (void) dismissKeyboard {
    [self.searchBarOwn resignFirstResponder];
}

-(void)showLocalAlert:(NSString *) title msg:(NSString *)msg actionText:(NSString *)actionText {
    UIAlertController *myAlertController = [UIAlertController alertControllerWithTitle:title
                                                                               message:msg
                                                                        preferredStyle:UIAlertControllerStyleAlert                   ];
    UIAlertAction *alertView = [UIAlertAction
                                actionWithTitle:actionText
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
//                                    [self dismissViewControllerAnimated:YES completion:nil];
                                    
                                }];
    [myAlertController addAction:alertView];
    [self presentViewController:myAlertController animated:YES completion:nil];
}

- (IBAction)showColorsActionSheet:(id)sender {
    /*
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Выбрать по штрихкоду с упаковки"
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Ввести вручную", @"Сканировать", nil];
    
//    [[[actionSheet valueForKey:@"_buttons"] objectAtIndex:0] setImage:[UIImage imageNamed:@"manualBarcode.png"] forState:UIControlStateNormal];
//    [[[actionSheet valueForKey:@"_buttons"] objectAtIndex:1] setImage:[UIImage imageNamed:@"autoBarcode.png"] forState:UIControlStateNormal];
    [actionSheet bu]
    for (id button in [actionSheet valueForKey:@"_buttons"]) {
        UIImageView* buttonImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[button titleForState:UIControlStateNormal]]];
        [buttonImage setFrame:CGRectMake(5, 5,35,35)];
        [button addSubview:buttonImage];
    }
    [actionSheet showInView:self.view];
     */
    UIAlertController * view=   [UIAlertController
                                 alertControllerWithTitle:@"Найти описание препарата"
                                 message:@"по штрихкоду на его упаковке"
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* online = [UIAlertAction
                             actionWithTitle:@"Вручную"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 //Do some thing here
                                 [view dismissViewControllerAnimated:YES completion:nil];
                             }];
    UIAlertAction* offline = [UIAlertAction
                              actionWithTitle:@"Камерой"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  [view dismissViewControllerAnimated:YES completion:nil];
                              }];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Закрыть"
                             style:UIAlertActionStyleDestructive
                             handler:^(UIAlertAction * action)
                             {
                             }];
    
    [online setValue:[[UIImage imageNamed:@"manual_icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forKey:@"image"];
    [offline setValue:[[UIImage imageNamed:@"auto_icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forKey:@"image"];
    [view addAction:online];
    [view addAction:offline];
    [view addAction:cancel];
    
    [self presentViewController:view animated:YES completion:nil];
}

- (IBAction)previousView:(id)sender {
    //    [self dismissViewControllerAnimated:YES completion:nil];
    //    [self removeFromParentViewController];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)showBarcodeMenu:(id)sender forEvent:(UIEvent *)event {
//    NSSet *touches = [event touchesForView:sender];
//    UITouch *touch = [touches anyObject];
//    CGPoint touchPoint = [touch locationInView:sender];
//    CGFloat pointX = touchPoint.x;
//    CGFloat pointY = touchPoint.y;
//    NSLog(@" from HomeController: Coordinates are: %f, %f ", pointX, pointY);
//    UIButton *btn = (UIButton *) sender;

    
    if (_barcodeSubMenu.hidden) {
        UIButton *pushedBtn = (UIButton *) sender;
//        UIButton *refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [pushedBtn setFrame:CGRectMake(0,0,76,76)];
        [pushedBtn setImage:[UIImage imageNamed:@"barcodeCtrl.png"] forState:UIControlStateNormal];
//        self.navigationItem.leftBarButtonItem = refreshBarButton;
        [self.navigationController.view addSubview:_overlayForTopBar];
        _overlayForMainWindow.hidden = NO;
        _overlayForTopBar.hidden = NO;
        _barcodeSubMenu.hidden = NO;
    } else {
        [_overlayForTopBar removeFromSuperview];
        _overlayForMainWindow.hidden = YES;
        _overlayForTopBar.hidden = YES;
        _barcodeSubMenu.hidden = YES;
    }
    
    
    
    
    
    /*
    PopOverViewController *dateVC = [[PopOverViewController alloc] initWithNibName:@"PopOverViewController" bundle:nil];
    UINavigationController *destNav = [[UINavigationController alloc] initWithRootViewController:dateVC];        dateVC.preferredContentSize = CGSizeMake(150, 227);
    //    dateVC.preferredContentSize= CGSizeMake(90,1*65-1);
    destNav.modalPresentationStyle = UIModalPresentationPageSheet;
    _dateTimePopover8 = destNav.popoverPresentationController;
    _dateTimePopover8.delegate = self;
    _dateTimePopover8.sourceView = self.view;
    _dateTimePopover8.sourceRect = btn.frame;
//    _dateTimePopover8.sourceRect = CGRectMake(touchPoint.x, touchPoint.y, 70, 100);
    destNav.navigationBarHidden = YES;
    [self presentViewController:destNav animated:YES completion:nil];
    */
    
    /*
    
    float windowWidth = (float) self.view.bounds.size.width;
    float windowY = (float) self.view.bounds.size.height;
    float topBarHeight = (float) self.navigationController.view.bounds.size.height;
    
    float customViewWidth = 100.0f;
    float setX = _barcodeController.center.x - customViewWidth;
    float setY = touchPoint.y + 2 * _barcodeController.center.y;
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(setX, setY, customViewWidth, 250)]; //<- change to where you want it to show.
    
    //Set the customView properties
    customView.alpha = 0.0;
    customView.layer.zPosition = 1000;
    customView.layer.cornerRadius = 5;
    customView.layer.borderWidth = 1.5f;
    customView.layer.borderColor = [[UIColor colorWithRed:0.537 green:0.816 blue:0.247 alpha:1] CGColor];
    customView.layer.masksToBounds = YES;
    
    //Add the customView to the current view
    [self.view addSubview:customView];
    
    //Display the customView with animation
    [UIView animateWithDuration:0.4 animations:^{
        [customView setAlpha:1.0];
    } completion:^(BOOL finished) {}];
    
    */
    
    //    [[self navigationController] setNavigationBarHidden:YES animated:YES]; // скрыть навигацию
    
//    [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:197.0/255.0 green:169.0/255.0 blue:140.0/255.0 alpha:0.5]];
    
    //    [self.navigationItem.titleView.layer setOpacity:0.5f];
//    int indexCounter = 0;
//    for (UINavigationItem *topBarElem in [self.navigationController.navigationItem ]) {
//        if (indexCounter <= 1) {
//            topBarElem.
//        } else {
//            break;
//        }
//        indexCounter++;
//    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"show Home content"]) {
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
//                                                             bundle:nil];
////        HomeContent *homeContent=[storyboard instantiateViewControllerWithIdentifier:@"Home content view"];
//        HomeContent *hContent = segue.destinationViewController;
        
//        NSLog(@"the seque works : %@ ! homeContetnt object: %@ \n", [segue identifier], hContent);
//        
//        [hContent pushViewController:homeContent animated:NO];
        UIViewController *srcViewController = (UIViewController *) self;
//        [srcViewController.parentViewController addChildViewController:hContent];
        
        NSInteger myIndex = [srcViewController.navigationController.viewControllers indexOfObject:self];
        
        NSLog(@"parent (1): %@", [srcViewController.navigationController.viewControllers objectAtIndex:myIndex-1]);
        
//                                                 presentViewController:hContent animated:NO completion:nil];
         
//        [srcViewController.view addSubview:hContent.view];
    }
    
    if ([[segue identifier] isEqualToString:@"ShowMedicineData"]) {
//        NSIndexPath *indexPath = [tbl indexPathForCell:sender];
        NSLog(@"indexPathForCell:sender:%d ! \n", [_currentSection intValue] );
        
//        NSIndexPath *indexPath = [tbl indexPathForCell:sender];
//        int currentSection = 0;
        NSDictionary *frstLevel = [self.medicinesTNList objectAtIndex:[_currentSection intValue]];
        NSString *currentFirstLetter = [[frstLevel allKeys] objectAtIndex:0];
        
        NSLog(@"frstLevel:%@ current fLetter: %@", frstLevel, currentFirstLetter);
        
        NSDictionary *scndLevel = [[frstLevel objectForKey:currentFirstLetter] objectAtIndex:[_clickedRowIndex integerValue]];
        NSLog(@"scndLevel: %@", scndLevel);
        DescrByNameTblViewController *descriptData = segue.destinationViewController;
        descriptData.nomenNumber = [scndLevel valueForKey:@"nomenid"];
        descriptData.eanNumber = [scndLevel valueForKey:@"eancode"];
        descriptData.medicineTitle = [scndLevel valueForKey:@"prepname"];
//        [descriptData checkXML];
    }

    if ([segue.identifier isEqualToString:@"popShow"]) {
        UINavigationController *destNav = segue.destinationViewController;
        //        PopOverViewController *vc = destNav.viewControllers.firstObject;
        
        // This is the important part
        UIPopoverPresentationController *popPC = destNav.popoverPresentationController;
        popPC.delegate = self;
    }
    
    if ([segue.identifier isEqualToString:@"medicineOrderList"]) {
//        NSLog(@"openMedicinesOrderList");
//        ArticleController *articleV = segue.destinationViewController;
//        HomeController *currentCntrl = (HomeController *) self;
//        [articleV setParentObject:currentCntrl];
    }
    
}

- (IBAction)showMenu:(id)sender {
    
//    NSLog(@"clicked");
//    UIViewController *srcViewController = (UIViewController *) self;
//
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
//                                                         bundle:nil];
//    HomeContent *homeContent=[storyboard instantiateViewControllerWithIdentifier:@"Home content view"];
//
//    [srcViewController presentViewController:homeContent animated:(YES) completion:^(void) {
//        [UIView transitionWithView:homeContent.view
//                          duration:0.35f
//                           options:UIViewAnimationOptionTransitionFlipFromLeft
//                        animations:^(void) {
//                            
//                        }
//                        completion:nil];
//    }];
//
    
//    [UIView transitionWithView:self.drugstoresListTblView
//                      duration:0.35f
//                       options:UIViewAnimationOptionTransitionCrossDissolve
//                    animations:^(void) {
//                        
//                    }
//                    completion:nil];
    
//    [srcViewController presentViewController:homeContent animated:YES completion:nil];
//    [homeContent.navigationController presentViewController:<#(nonnull UIViewController *)#> animated:<#(BOOL)#> completion:<#^(void)completion#>
    
}



//- (void) displayContentController: (UIViewController*) content {
//    [self addChildViewController:content];
//    content.view.frame = [self frameForContentController];
//    [self.view addSubview:self.currentClientView];
//    [content didMoveToParentViewController:self];
//}



//
//  tblMedsSearchList.m
//  ScanTest
//
//  Created by Zzz on 18.01.16.
//
//

//#import "tblMedsSearchList.h"
//#import "DescrByNameTblViewController.h"



/*
 //#import "DataFetcher.h"
 //#import "TN.h"
 //#import "FG+DataFromTradenames.h"
 */

//@implementation tblMedsSearchList


- (void)returnFirstLetters {
    _fLetterArray = [[NSMutableArray alloc] init];
    _firstLetters = [NSMutableDictionary dictionary];
    _oldLetter = @"";
    
    int arrayLength = (int)_medicinesTNList.count;
    int counter = 0;
    
    for (NSString *obj in _medicinesTNList) {
        counter++;
        //        NSLog(@"object: %@ \n", [obj valueForKey:@"prepname"]);
        NSString *tempFirstLetter = @"";
        if ([[obj valueForKey:@"prepname"] length] > 0) {
            tempFirstLetter = [[[obj valueForKey:@"prepname"] substringToIndex:1] uppercaseString];
            //            NSLog(@"here if_1: %@", [obj valueForKey:@"prepname"]);
        }
        if ([_oldLetter isEqualToString:tempFirstLetter]) {
            [_fLetterArray addObject:[obj valueForKey:@"prepname"]];
            NSLog(@"here if_2: %@", [obj valueForKey:@"prepname"]);
        }
        else {
            // old != current
            if (_oldLetter == nil ||
                [_oldLetter isEqualToString:@""]) {
                _oldLetter = tempFirstLetter ;
                NSLog(@"here if_3: %@", [obj valueForKey:@"prepname"]);
            }
            else {
                NSLog(@"here else: %@", [obj valueForKey:@"prepname"]);
            }
            [_firstLetters setObject:_fLetterArray forKey:_oldLetter];
            _fLetterArray = [[NSMutableArray alloc] init];
            
            [_fLetterArray addObject:[obj valueForKey:@"prepname"]];
            _oldLetter = tempFirstLetter;
            
            NSLog(@"here else_scnd: %@", [obj valueForKey:@"prepname"]);
            
        }
        
        if (arrayLength == counter) {
            [_firstLetters setObject:_fLetterArray forKey:_oldLetter];
        }
    }
    
    
    // WRITING DICTIONARY TO PLIST (working)
    //    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
    //                                                         NSUserDomainMask, YES);
    //    if ([paths count] > 0) {
    //        NSString  *dictPath = [[paths objectAtIndex:0]
    //        stringByAppendingPathComponent:@"dict.out"];
    //        [_firstLetters writeToFile:dictPath atomically:YES];
    //         NSLog(@"PATH: %@", dictPath);
    //    }
    
    NSLog(@"From ARRAY, ARRAY obj: %@", _firstLetters);
    // :END
}


- (NSArray *) splitString:(NSString *)inpString {
    NSMutableArray *tempArray = [NSMutableArray array];
    [inpString enumerateSubstringsInRange:[inpString rangeOfString:inpString]
                                  options:NSStringEnumerationByComposedCharacterSequences
                               usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                   [tempArray addObject:substring] ;
                               }] ;
    return tempArray;
}



#pragma mark -
#pragma mark Table View Delegate Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    static NSString *CellIdentifier = @"Medicine List Cell"; // было
    static NSString *simpleTableIdentifier = @"TopicsCell"; // с фотографиями
    //    static NSString *simpleTableIdentifier = @"TopicsCell_photo+"; // только текст
    
    
    
    /* было
     //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
     
     //    if (cell == nil) {
     //        cell = [[UITableViewCell alloc]
     //                initWithStyle:UITableViewCellStyleDefault
     //                reuseIdentifier:CellIdentifier];
     //    }
     */
    
    //    int currentRowINdex = (int) [indexPath row];
    //    int isEven = (currentRowINdex % 2);
    //    NSLog(@"INDEX PATH NUMBER: %d even: %d", currentRowINdex, isEven);
    
    int currentSection = (int) indexPath.section;
    NSDictionary *frstLevel = [self.medicinesTNList objectAtIndex:currentSection];
    NSString *currentFirstLetter = [[frstLevel allKeys] objectAtIndex:0];
    NSDictionary *scndLevel = [[frstLevel objectForKey:currentFirstLetter] objectAtIndex:indexPath.row];
    NSString *textLabelText = [NSString stringWithFormat:@"%@", [scndLevel  valueForKey:@"prepname"]];
    
    //    NSLog(@"textLabelTexttextLabelTexttextLabelText: %@ current section number: %d", [self.medicinesTNList objectAtIndex:currentSection], currentSection);
    
    NSString *tempLatinName = [scndLevel valueForKey:@"latinname"];
    int lettersCounter = (int) [tempLatinName length];
    
    if (lettersCounter > 0) {
        textLabelText = [NSString stringWithFormat:@"%@ (%@)", [scndLevel valueForKey:@"prepname"], [scndLevel valueForKey:@"latinname"]];
    }
    
    NSString *detailText = [NSString stringWithFormat:@"%@", [scndLevel valueForKey:@"form"]];
    
//    int rrow = (int)[self indexFromIndexPath:indexPath currentTbl:tableView];
    
    
    //стало (проверить с большим кол-вом данных)
    TopicsCell *cell = (TopicsCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:simpleTableIdentifier owner:self options:nil];
        //        for (id oneObject in nib) if ([oneObject isKindOfClass:[TopicsCell class]])
        //            cell = (TopicsCell *)oneObject;
        cell = (TopicsCell *) [nib objectAtIndex:0];
        //        cell = [nib objectAtIndex:0];
    }
    
    
    
    cell.header.text = textLabelText;
    cell.text.text = detailText;
    
//    if (nil == cell.SectionRowHolder.text || [cell.SectionRowHolder.text isEqualToString:@""])
//        cell.SectionRowHolder.text = [NSString stringWithFormat:@"%ld:%ld",(long)currentSection,(long)indexPath.row];
//    
    //        cell.plusSign.tag = rrow;
    cell.tag = [self indexFromIndexPath:indexPath currentTbl:tableView];
    cell.SectionRowHolder.text = [NSString stringWithFormat:@"%ld", (long)cell.tag];
    
    if ([cell.defaultStepperLabel.text intValue] > 0) {
        cell.quantity.text = [NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"%@", [scndLevel valueForKey:@"quantity"]]];
    }
    
    [cell.defaultStepper addTarget:cell action:@selector(stepperValueDidChange:) forControlEvents:UIControlEventValueChanged];
    [cell.defaultStepper addTarget:self action:@selector(stepperLocalAction:) forControlEvents:UIControlEventValueChanged];
    
    if ([self medicinesAreInTheDataPlist]) {
        NSArray *getData = (NSArray *) [self getContentOfPlist];
        for (NSDictionary *medicineData in getData) {
            int checkSection = [[medicineData valueForKey:@"section"] intValue];
            int checkRow = [[medicineData valueForKey:@"row"] intValue];
            
            NSLog(@"testing sect:%d row: %d = %d", checkSection, checkRow, [[medicineData valueForKey:@"quantity"] intValue]);
            
            if (checkSection == currentSection &&
                checkRow == (int) indexPath.row) {
                //            cell.defaultStepperLabel.text = [NSString stringWithFormat:@"%ld", (long)cell.defaultStepper.value];
                cell.defaultStepperLabel.text = [NSString stringWithFormat:@"%d", [[medicineData valueForKey:@"quantity"] intValue]];
                NSLog(@"section:%d row: %d = %d", checkSection, checkRow, [[medicineData valueForKey:@"quantity"] intValue]);
                
            }
        }
    }
    
    cell.defaultStepper.value = ([cell.defaultStepperLabel.text intValue] != 0) ? [cell.defaultStepperLabel.text intValue] : 0;
    
//    if ([cell.defaultStepperLabel.text intValue] != 0) {
//        cell.SectionRowHolder.text = [NSString stringWithFormat:@"%ld:%ld",(long)currentSection,(long)indexPath.row];
//    }
    
    cell.defaultStepper.minimumValue = 0;
    cell.defaultStepper.maximumValue = 100;
    cell.defaultStepper.stepValue = 1;
    
    
    //    NSLog(@"initialized");
    
    
    //        [cell.plusSign addTarget:self action:@selector(changeSwitch: forEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //    cell.delegate = self; //Setting delegate to self
    //    cell.buttonIndexPath = indexPath;
    
    //    [cell sizeToFit];
    
    _currentCell = cell;
    _currentCell.delegate = self;
    
    
    return cell;
}


//- (NSIndexPath *)tableView:(UITableView *)tableView
//  willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    return indexPath;
//}



- (NSInteger)tableView:(UITableView *)tableView
sectionForSectionIndexTitle:(NSString *)title
               atIndex:(NSInteger)index {
    NSString *key = [self.searchIndexKeys objectAtIndex:index];
    if (key == UITableViewIndexSearch) {
        [tableView setContentOffset:CGPointZero animated:NO];
        return NSNotFound;
    }
    else {
        return index;
    }
}



// СОЗДАЕТ ИНДЕКСНЫЙ УКАЗАТЕЛЬ СПРАВА
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.searchIndexKeys;
}


- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section {
    if ([self.searchIndexKeys count] == 0)
        return nil;
    
    NSMutableArray *tmp = [[NSMutableArray alloc] initWithArray:self.searchIndexKeys];
    [tmp removeObject:UITableViewIndexSearch];
    NSString *key = [tmp objectAtIndex:section];
    
    //    if (key == UITableViewIndexSearch)
    //        return @"5";
    return key;
}


// Return the number of table sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
        NSLog(@"Number of sections: %d", (int) [self.medicinesTNList count]);
    return [self.medicinesTNList count];
    
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    //    NSLog(@"self.medicinesTNList: %@ ", self.medicinesTNList );
    
    //    NSLog(@"REAL section number: %d", (int) section);
    
//    _realSection = [NSNumber numberWithInt: (int) section];
    
    //    NSLog(@"section letter as a key: %@", [[self.medicinesTNList objectAtIndex:section] key]);
    NSString *currentFirstLetter = [[[self.medicinesTNList objectAtIndex:section] allKeys] objectAtIndex:0];
    //    NSLog(@"Current first letter: %@", currentFirstLetter);
    
    //    NSLog(@"Thesection number: %d", (int) [[[self.medicinesTNList objectAtIndex:section] objectForKey:currentFirstLetter] count]);
    //
    //    if (![currentFirstLetter isEqualToString:@"search"]) {
    //        NSLog(@"currentFirstLetter: %@ :: Object: %@ \n\n\n\n\n\n\n", currentFirstLetter, [[self.medicinesTNList objectAtIndex:section] objectForKey:currentFirstLetter]  );
    //    }
    //
    
    int getCounterForRows = (int) [[[self.medicinesTNList objectAtIndex:section] objectForKey:currentFirstLetter] count];
    
    //    NSLog(@"counter: %d \n\n\n\n\n\n\n", getCounterForRows);
    
    //    return [[[self.medicinesTNList objectAtIndex:section] objectForKey:currentFirstLetter] count];
    
    return getCounterForRows;
    
}

- (NSUInteger)indexFromIndexPath:(NSIndexPath*)indexPath currentTbl:(UITableView *)tblView {
    NSUInteger index=0;
    for( int i=0; i<indexPath.section; i++ )
        index += [self tableView:tblView numberOfRowsInSection:i];
    index += indexPath.row;
    return index;
}

/*
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *HeaderIdentifier = @"header";
    
    TableViewHeader *myHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderIdentifier];
    if(!myHeader) {
        //    [tableView registerClass:[CustomHeaderView class] forHeaderFooterViewReuseIdentifier:HeaderIdentifier];
        myHeader = [[[NSBundle mainBundle] loadNibNamed:@"tblViewHeader"
                                                  owner:self
                                                options:nil] objectAtIndex:0];
    }
    
    myHeader.textLabel.tintColor = [UIColor redColor]; //here you can change the text color of header.
    myHeader.textLabel.font = [UIFont fontWithName:@"Avenir" size:16.0];
    myHeader.textLabel.font = [UIFont boldSystemFontOfSize:16.0];
    
    return myHeader;
}
*/

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection: (NSInteger)section {
//    UILabel *sectionHeader = [[UILabel alloc] initWithFrame:CGRectNull];
//    sectionHeader.backgroundColor = [UIColor whiteColor];
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
//    header.backgroundColor = [UIColor whiteColor];
    header.textLabel.textColor = [UIColor colorWithRed:0.28 green:0.55 blue:0.85 alpha:1.0];
    header.textLabel.font = [UIFont fontWithName:@"Avenir Book" size:22.0];
//    CGRect headerFrame = header.frame;
//    header.textLabel.frame = headerFrame;
//    headerFrame.
//    header.textLabel.text= @"Table Title";
//    header.textLabel.textAlignment = NSTextAlignmentLeft;
}


#pragma mark -
#pragma mark Plist Delegate Methods

- (void)stepperLocalAction:(JLTStepper *)stepper {
    [self showTotalMedicines];
    NSArray *tmpData = [self getContentOfPlist];
    int innerCounter = (int) [tmpData count];
    
    if (stepper.plusMinusState == JLTStepperPlus) {
        // Plus button pressed
        NSLog(@"the plus");
        if (innerCounter >= 19 && stepper.value == 1) {
            NSLog(@"from first the table counter: %d", (int) innerCounter);
            NSLog(@"before _currentCell.defaultStepper.value: %ld", (long) _currentCell.defaultStepper.value);
            
            [self showLocalAlert:@"Выбор не более 20 препаратов" msg:@"" actionText:@"OK"];
            
            _currentCell.defaultStepper.value = _currentCell.defaultStepper.minimumValue;
            [tbl reloadData];
            
            NSLog(@"_currentCell.defaultStepper.value: %ld", (long) _currentCell.defaultStepper.value);
            
            //            [_currentCell.defaultStepper setValue:0];
            //            [_currentCell.defaultStepperLabel setText:@"0"];
        }

    }
    else if (stepper.plusMinusState == JLTStepperMinus) {
        // Minus button pressed
    } else {
        // Shouldn't happen unless value is set programmatically.
    }
    
    
    NSLog(@"the stepper.value: %lu", (unsigned long)stepper.state);
    if (innerCounter > 0 && stepper.value > stepperOldValue) {
                // Показываем кнопку перехода к списку лекарств под заказ
    }
}

// Somewhere in your implementation file:
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"Will begin dragging: %@", _currentCell.header.text);
    [self dismissKeyboard];
}

- (NSArray *)getContentOfPlist {
    // запись нового значения в plist
    NSString *filePath = [self dataFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSArray *array = [[NSArray alloc] initWithContentsOfFile:filePath];
        NSLog(@"ARRAY from the plist: %@", array);
        return array;
    } else {
        return nil;
    }
}

- (NSString *)dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
                                                         NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:kFilename];
}

// Показать путем затемнения кнопку для перехода в общий список лекарств для заказа
//- (void) showTotalMedicinesBtnOnLoading {
//    
//    NSLog(@"showTotalMedicinesBtn has been loaded");
//    
//    if ([self medicinesAreInTheDataPlist]) {
//        for (UIView *uv in [_totalMedicinesDIV subviews]) {
//            [self fadeIn:uv];
//        }
//    } else {
//        for (UIView *uv in [_totalMedicinesDIV subviews]) {
//            [self fadeOut:uv];
//        }
//    }
//    
//}


// Показать путем затемнения кнопку для перехода в общий список лекарств для заказа
- (void) showTotalMedicines {
    UIView *testingTheView = [[_totalMedicinesDIV subviews] objectAtIndex:0];
    if (![self medicinesAreInTheDataPlist]) {
        if (testingTheView.layer.opacity == 1) {
            for (UIView *uv in [_totalMedicinesDIV subviews]) {
                [self fadeOut:uv];
            }
            _totalMedicinesDIV.hidden = YES;
        }
    } else {
        if (_totalMedicinesDIV.hidden == YES) {
            _totalMedicinesDIV.hidden = NO;
            for (UIView *uv in [_totalMedicinesDIV subviews]) {
                [self fadeIn:uv];
            }
        }
    }
    
    
    
}

// Подсчет есть ли препараты в списке под заказ (если да: показываем кнопку перехода; нет - не показываем кнопку перехода)
- (BOOL) medicinesAreInTheDataPlist {
    NSMutableArray *tmpData = (NSMutableArray *) [self getContentOfPlist];
    int innerCounter = (int) [tmpData count];
    if (innerCounter > 0) {
        if (innerCounter >= 20) {
            NSLog(@"from the table counter: %d + stepper value: %d", (int) innerCounter, (int)_currentCell.defaultStepper.value);
            [tmpData removeLastObject];
            [tmpData writeToFile:[self dataFilePath] atomically:YES];
        } else {
            NSLog(@"counter: %d", innerCounter);
            _totalQuantity.text = [NSString stringWithFormat:@"%d", innerCounter];
        }
//        _totalQuantity.text = [NSString stringWithFormat:@"%d", innerCounter];
        return YES;
        // Показываем кнопку перехода к списку лекарств под заказ
    } else {
        // Скрываем кнопку перехода к списку лекарств под заказ
        
    }
    return NO;

}


// retrieve the table view from self
- (UITableView *)getTableView {
    UIView *superView = self.view;
    while (superView && ![superView isKindOfClass:[UITableView class]]) {
        superView = superView.superview;
    }
    if (superView) {
        return (UITableView *)superView;
    }
    return nil;
}



- (void)medicinesChoosedListView:(id)sender forEvent:(UIEvent *)event {
    NSSet *touches = [event touchesForView:sender];
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:sender];
    CGFloat pointX = touchPoint.x;
    CGFloat pointY = touchPoint.y;
    NSLog(@" from HomeController: Coordinates are: %f, %f ", pointX, pointY);
    
//    UIButton *btn = (UIButton *) sender;
    
    PopOverViewController *dateVC = [[PopOverViewController alloc] initWithNibName:@"PopOverViewController" bundle:nil];
    UINavigationController *destNav = [[UINavigationController alloc] initWithRootViewController:dateVC];/*Here dateVC is controller you want to show in popover*/
    //    dateVC.preferredContentSize = CGSizeMake(313, 227);
    //    dateVC.preferredContentSize= CGSizeMake(90,1*65-1);
    destNav.modalPresentationStyle = UIModalPresentationPageSheet;
    _dateTimePopover8 = destNav.popoverPresentationController;
    _dateTimePopover8.delegate = self;
    _dateTimePopover8.sourceView = self.view;
    //    _dateTimePopover8.sourceRect = btn.frame;
    _dateTimePopover8.sourceRect = CGRectMake(touchPoint.x, touchPoint.y, 250, 227);
    destNav.navigationBarHidden = YES;
    [self presentViewController:destNav animated:YES completion:nil];
    
}

- (void)changeSwitch:(id)sender forEvent:(UIEvent *)event {
    NSSet *touches = [event touchesForView:sender];
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:sender];
    CGFloat pointX = touchPoint.x;
    CGFloat pointY = touchPoint.y;
    NSLog(@" from HomeController: Coordinates are: %f, %f ", pointX, pointY);
    
//    UIButton *btn = (UIButton *) sender;
    
//    TopicsCell *curCell = (TopicsCell *) [[sender superview] superview];
//    _popoverTitle = [NSString stringWithFormat:@"%@ (%@)", curCell.header.text, curCell.text.text];
    
//    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(25, 250, 100, 50)]; //<- change to where you want it to show.
//    
//    //Set the customView properties
//    customView.alpha = 0.0;
//    customView.layer.cornerRadius = 5;
//    customView.layer.borderWidth = 1.5f;
//    customView.layer.masksToBounds = YES;
//    
//    //Add the customView to the current view
//    [self.view addSubview:customView];
//    
//    //Display the customView with animation
//    [UIView animateWithDuration:0.4 animations:^{
//        [customView setAlpha:1.0];
//    } completion:^(BOOL finished) {}];
    
    PopOverViewController *dateVC = [[PopOverViewController alloc] initWithNibName:@"PopOverViewController" bundle:nil];
    UINavigationController *destNav = [[UINavigationController alloc] initWithRootViewController:dateVC];/*Here dateVC is controller you want to show in popover*/
//    dateVC.preferredContentSize = CGSizeMake(313, 227);
//    dateVC.preferredContentSize= CGSizeMake(90,1*65-1);
    destNav.modalPresentationStyle = UIModalPresentationPopover;
    _dateTimePopover8 = destNav.popoverPresentationController;
    _dateTimePopover8.delegate = self;
    _dateTimePopover8.sourceView = self.view;
//    _dateTimePopover8.sourceRect = btn.frame;
    _dateTimePopover8.sourceRect = CGRectMake(touchPoint.x, touchPoint.y, 250, 227);
    destNav.navigationBarHidden = YES;
    [self presentViewController:destNav animated:YES completion:nil];
    
//    int rrow = (int) btn.tag;
//    NSLog(@"rrow: %d", (int) btn.tag);
//    UIView *holdingView = (UIView *) [sender superview];
//    NSLog(@"[holdingView subviews]: %@", [holdingView subviews]);
//    UILabel *lbl = (UILabel *) [[holdingView subviews] objectAtIndex:1];
//    [lbl setText:@"www"];
    
//    TopicsCell *tc = (TopicsCell *) [[[sender superview] superview] viewWithTag:btn.tag];
//    [self addLabel:tc x:100 y:100 w:100 h:100 txt:@"bnm,./"];
    
    
//    [clickedTable reloadData];

//    [clickedTable reloadData];
    
//    TopicsCell *cl = (TopicsCell *) [clickedTable viewWithTag:btn.tag];
    
//    TopicsCell *curCell = (TopicsCell *) [[sender superview] superview];
//    if (curCell.quantity.tag == rrow) {
//        [[curCell.quantity viewWithTag:rrow] setText:@"1"];
//    }
//    
//    [[self getTableView] reloadData];
    
    
    
//    UILabel *labelTmp = (UILabel *)[cl viewWithTag:4];
//    [labelTmp setText:@"1"];
    
//    UISwitch *switcherChanged = (UISwitch *) sender;
//    int currentRow = (int) switcherChanged.tag;
//    
//    TopicsCell *clickedCell = (TopicsCell *)[[sender superview] superview];
//    TopicsCell *clkCell = (TopicsCell *)[[self getTableView].subviews objectAtIndex:currentRow];
//    
//    //    UITableView* table = (UITableView *)[clickedCell superview];
//    NSIndexPath *clickedButtonIndexPath = [[self getTableView] indexPathForCell:clickedCell];
////    NSUInteger realIndex = [self indexFromIndexPath:clickedButtonIndexPath];
//    
//    
//    // Change the actual data value in the layer to the final value.
//    
//    if([sender isOn]){
//        NSLog(@"sender: %@ \n Switch is ON: %lu currentRow: %lu", sender, [clickedCell.contentView.subviews count], switcherChanged.tag);
//        
//        UIView *view = [clkCell.contentView.subviews objectAtIndex:currentRow];
//        UITableViewCell *cl = (UITableViewCell *)[[self getTableView] cellForRowAtIndexPath:clickedButtonIndexPath];
//        
//        UIButton *plusBtnTmp = (UIButton *) [clkCell.contentView viewWithTag:3];
//        plusBtnTmp.hidden = NO;
//        
//        UIButton *minusBtnTmp = (UIButton *)[view viewWithTag:5];
//        
//        //        minusBtnTmp.hidden = NO;
    
//    TopicsCell *curCell = (TopicsCell *) [[sender superview] superview];

//    for (UIView *view in curCell.subviews){
//        if ([view isKindOfClass:[UIButton class]]){
//            UIButton *btnTmp = (UIButton *)view;
//            btnTmp.hidden = YES;
//        } else if ([view isKindOfClass:[UILabel class]]){
//            UILabel* labelTmp = (UILabel *)view;
//            if (labelTmp.tag == 4) {
//                // quantity text
//                //                    [self fadeIn:labelTmp];
//                labelTmp.hidden = NO;
//                [labelTmp setText:@"1"];
//            }
//        } else if ([view isKindOfClass:[UITextField class]]){
//            UITextField* txtFieldTmp = (UITextField *)view;
//            if (txtFieldTmp.tag == 6) {
//                // add to the order text
//                //                    [self fadeOut:txtFieldTmp];
//                txtFieldTmp.hidden = YES;
//            }
//        } else if ([view isKindOfClass:[UISwitch class]]){
//            UISwitch* switchTmp = (UISwitch *)view;
//            //                [self fadeOut:switchTmp];
//            switchTmp.hidden = YES;
//        }
//    }

    
////        if (plusBtnTmp.tag == 3)
////        [cl.contentView addSubview:plusBtnTmp];
////        [[self getTableView] reloadData];
//        //        _plusSign.hidden = NO;
//        //        _minusSign.hidden = NO;
//        //        _quantity.hidden = NO;
//        //        [_quantity setText:@"1"];
//        //        _addToTheOrderText.hidden = YES;
//        //        _switcher.hidden = YES;
//    } else{
//        NSLog(@"Switch is OFF");
//    }
    
//    _medicinesTNList = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:tradenamesFile ofType:@"plist"]];
//    [self theViewReloader];
//    [tbl reloadData];
    
}



- (NSArray *)readQuantityFromPlist {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"quantity.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath: path]) {
        return nil;
    } else {
        NSArray *list = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"quantity" ofType:@"plist"]];
        return list;
    }
}

- (void)writeQuantityIntoPlist:(int)levelFirst lvlScn:(int)levelSecond qnt:(int)quantity fletter:(NSString *)firstLetter {
    
    // 1) Создаем файл "quantity.plist"
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"quantity.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath: path]) {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"quantity" ofType:@"plist"];
        [fileManager copyItemAtPath:bundle toPath: path error:&error];
    }
    // :END
    
    // 1.1) Записываем данные
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    [data setObject:[NSNumber numberWithInt:levelFirst] forKey:@"levelFirst"];
    [data setObject:[NSNumber numberWithInt:levelSecond] forKey:@"levelSecond"];
    [data setObject:firstLetter forKey:@"firstLetter"];
    [data setObject:[NSNumber numberWithInt:quantity] forKey:@"quantity"];
    
    NSMutableArray *medicinesList = [[NSMutableArray alloc] initWithObjects:data, nil];
    [medicinesList writeToFile: path atomically:YES];
    
}

- (UIModalPresentationStyle) adaptivePresentationStyleForPresentationController: (UIPresentationController * ) controller {
    return UIModalPresentationNone;
}

- (void)userTappedOnLink:(UIGestureRecognizer*)gestureRecognizer {
    NSLog(@"alert");
}

-(void)fadeOut:(UIView *)objectToAnimate {
    CABasicAnimation* fadeAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAnim.fromValue = [NSNumber numberWithFloat:1.0];
    fadeAnim.toValue = [NSNumber numberWithFloat:0.0];
    fadeAnim.duration = 1.0;
    [objectToAnimate.layer addAnimation:fadeAnim forKey:@"opacity"];
}

-(void)fadeIn:(UIView *)objectToAnimate {
    CABasicAnimation* fadeAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAnim.fromValue = [NSNumber numberWithFloat:0.0];
    fadeAnim.toValue = [NSNumber numberWithFloat:1.0];
    fadeAnim.duration = 1.0;
    [objectToAnimate.layer addAnimation:fadeAnim forKey:@"opacity"];
    //    NSLog(@"fading the object: %@", objectToAnimate);
}


#pragma mark -
#pragma mark Search Bar Delegate Methods
/*
 - (void)resetSearch {
 
 //    self.namesDescs получает на вход словарь с ключом:заглавная буква и значением:словарь торг названий/русских названий
 //    self.names ожидало на вход словарь с ключом:заглавная буква и значением:массив торг названий
 
 NSLog(@"reset search _firstLetters: %@ \n", _firstLetters); // bad result
 
 self.namesDescs = [_firstLetters mutableDeepCopy];
 
 NSLog(@"reset search namedescs: %@ \n", self.namesDescs); // bad result
 
 NSMutableArray *keyArray = [[NSMutableArray alloc] init];
 [keyArray addObject:UITableViewIndexSearch];
 //    [keyArray addObjectsFromArray:[_firstLetters allKeys]];
 [keyArray addObjectsFromArray:[[_firstLetters allKeys]
 sortedArrayUsingSelector:@selector(compare:)]];
 //    NSLog(@"first letters: %@", _firstLetters);
 self.keys = keyArray;
 //    self.staticKeys = keyArray;
 
 // [table reloadData];
 NSLog(@"From NAMES obj: %@", self.keys);
 }
 */

- (void)operateSingleLetter:(NSString *)currentLetterAsKey indexer:(NSNumber *)indexer {
    NSMutableDictionary *medicalDictionary = [NSMutableDictionary dictionary];
    // Массив внутренний:
    NSArray *medicalDrugs = [[_medicinesTNList_copy objectAtIndex:[indexer intValue]] objectForKey:currentLetterAsKey];
    // Словарь:
    [medicalDictionary setValue:medicalDrugs forKey:currentLetterAsKey];
    //    NSLog(@"medicalDictionary: %@", medicalDictionary);
    // Массив внешний:
    _medicinesTNList = [[NSMutableArray alloc] initWithObjects:medicalDictionary, nil];
    _searchIndexKeys = [[NSMutableArray alloc] initWithObjects:currentLetterAsKey, nil];
    //            _medicinesTNList
        NSLog(@"indexer: %d _medicinesTNList: %@", [indexer intValue], _medicinesTNList);
}

- (void)handleSearchForTerm:(NSString *)searchTerm {
    int numberOfLetters = (int) searchTerm.length;
    searchTerm = [searchTerm capitalizedString];
    NSString *currentFLetter = [searchTerm substringToIndex:1] ;
    //    NSMutableArray *sectionsToRemove = [[NSMutableArray alloc] init];
    //    BOOL hasLetter = [self.searchIndexKeys containsObject:currentFLetter];
    //    NSMutableArray *toRemove = [[NSMutableArray alloc] init];
    //    NSLog(@"handling the searching on the word/letter: %@ number of letters: %d", searchTerm, (int) numberOfLetters);
    
    // 1. ВЫБОРКА ПРЕПАРАТОВ, НАЧИНАЮЩИХСЯ НА БУКВУ "currrentFLetter":
    //    [self startUpdateAnimation:@"Поиск по препаратам..."];
    //    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    //    [self resetSearch];
    //    NSMutableArray *allKeys = [[NSMutableArray alloc] init];
    
    if (numberOfLetters <= 1) {
//        NSLog(@"One symbol selected: %@", _medicinesTNList_copy);
        _specialIndexer = [NSNumber numberWithInt: 0];
        for (NSDictionary *listEntry in _medicinesTNList_copy) {
            NSString *currentLetterAsKey = [[listEntry allKeys] objectAtIndex:0];
//                        NSLog(@"letter: %@ currentFLetter: %@", currentLetterAsKey, currentFLetter);
            if ([currentFLetter isEqualToString:currentLetterAsKey]) {
                [self operateSingleLetter:currentFLetter indexer:_specialIndexer];
                break;
            }
            int converted = [_specialIndexer intValue];
            converted++;
            _specialIndexer = [NSNumber numberWithInt:converted];
        }
    }
    
    // 2. ВЫБОРКА ПРЕПАРАТОВ ПО БОЛЕЕ ЧЕМ ОДНОЙ БУКВЕ
    if (numberOfLetters > 1) {
        [self operateSingleLetter:currentFLetter indexer:_specialIndexer]; // Получение всех препаратов на указанную букву ("обнуление" данных)
        if ([_medicinesTNList count] > 0) {
            NSArray *caughtMedicines = [[_medicinesTNList objectAtIndex:0] objectForKey:currentFLetter];
            NSMutableArray *foundPrefixedElements = [[NSMutableArray alloc] init];
            for (NSDictionary *singleMedicine in caughtMedicines) {
                NSString *prepName = [[singleMedicine valueForKey:@"prepname"] capitalizedString];
                NSString *enteredText = [[searchTerm stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]] capitalizedString];
                if ([prepName hasPrefix:enteredText]) {
                    [foundPrefixedElements addObject:singleMedicine];
                }
            }
            NSMutableDictionary *midDictionary = [NSMutableDictionary dictionary];
            //        midDictionary = [_medicinesTNList objectAtIndex:0];
            [midDictionary setValue:foundPrefixedElements forKey:@"К"];
            _medicinesTNList = [[NSMutableArray alloc] initWithObjects:midDictionary, nil];
            //        NSLog(@"indexer > 1: %d current 0pLetter: %@ => %@", (int) self.specialIndexer, currentFLetter, _medicinesTNList);
        }
    }
    
    
    
    /*
     //    for (NSString *key in self.searchIndexKeys) {
     // выбрать все на искомую букву
     if (hasLetter) {
     NSIndexSet *ix = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, _medicinesTNList.count - 1)];
     NSMutableArray *array = [[NSMutableArray alloc] initWithArray:[_medicinesTNList objectsAtIndexes:ix]];
     //            NSLog(@"names descs: %@", array);
     NSUInteger counter = [array count];
     for (NSUInteger i = 0; i < counter; i++) {
     NSDictionary *namesDict = [array objectAtIndex:i];
     NSString *name = [array objectAtIndex:i];
     name = [name uppercaseString];
     if (![name hasPrefix:[searchTerm uppercaseString]]) {
     NSLog(@"name name: %@ search term: %@ namesdict: %@", name, searchTerm, namesDict);
     [toRemove addObject:namesDict];
     }
     }
     [array removeObjectsInArray:toRemove];
     }
     else {
     [sectionsToRemove addObject:key];
     }
     //    }
     [self.searchIndexKeys removeObjectsInArray:sectionsToRemove];
     //        dispatch_async(dispatch_get_main_queue(), ^{
     //    [table reloadData];
     //    NSLog(@"keys keys \n: %@ :: %@ \n", self.keys, namesDescs);
     //            [self stopUpdateAnimation];
     //        });
     //    });
     //
     //    [table reloadData];
     */
    
    [tbl reloadData];
    
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"searchBarSearchButtonClicked: \n");
    //    NSString *searchTerm = [searchBar text];
    //    [self handleSearchForTerm:searchTerm];
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    NSLog(@"searchBarTextDidBeginEditing: \n");
    //    isSearching = YES;
    //    [table reloadData];
    //    CGFloat x = 0;
    //    CGFloat y = 50;
    //    CGFloat width = self.view.frame.size.width;
    //    CGFloat height = self.view.frame.size.height - 50;
    //    CGRect tableFrame = CGRectMake(x, y, width, height);
    //    self.tblMedicamentsSearchList = [[UITableView alloc]initWithFrame:tableFrame style:UITableViewStylePlain];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchTerm {
    NSLog(@"text did change: %@ \n", searchTerm);
    if ([searchTerm length] == 0) {
        _medicinesTNList = _medicinesTNList_copy;
        _searchIndexKeys = _searchIndexKeys_copy;
        [tbl reloadData];
        return;
    }
    [self handleSearchForTerm:searchTerm];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    _medicinesTNList = _medicinesTNList_copy;
    _searchIndexKeys = _searchIndexKeys_copy;
    [tbl reloadData];
    [searchBar resignFirstResponder];
}

#pragma mark - SwipeableCellDelegate
- (void)buttonActionwith:(NSIndexPath *)indexPath sender:(id)sender { //Delegate method
//    UIButton *clickedButton = (UIButton *) sender;
//    NSIndexPath *ixPath = [NSIndexPath indexPathForRow:clickedButtonIndexPath.row inSection:clickedButton.section];
//    TopicsCell *tc = (TopicsCell *) [sender superview];
//    tc.
////    bool set = NO;
//    NSMutableArray *labels = [[NSMutableArray alloc] initWithObjects:@"", nil];
//    for (TopicsCell *cell in tbl.subviews) {
////        if ([view isKindOfClass:[UILabel class]]) {
////            UILabel *lbl = (UILabel *)[view viewWithTag:4];
////            if (lbl)
////                [labels insertObject:lbl atIndex:0];
////            NSLog(@"set\n");
//////            [tbl reloadData];
//////            break;
////        }
//        
//    }
    
    
//    UILabel *l = (UILabel *) [labels objectAtIndex:0];
//    l.text = @"ghjkl;";
    
//    tc.quantity.text = @"####";
    
   
    
    NSLog(@"Button Clicks at index %ld",(long)indexPath.row);
    
    _currentSection = [NSNumber numberWithLong:(long)indexPath.section];
    _clickedRowIndex = [NSNumber numberWithInt:(int)indexPath.row];
    
    
    
//    NSIndexPath *indexPath = [tbl indexPathForCell:sender];
    [self performSegueWithIdentifier:@"ShowMedicineData" sender:sender];
    
    
    
}

- (void)showMapNotDelegation {
    NSLog(@"runned delegate");
    [self.tabBarController setSelectedIndex:1];
}

-(void) addLabel:(TopicsCell *)currentcell x:(float)x y:(float)y w:(float)width h:(float)height txt:(NSString *)text {
    UILabel *mycoollabel=[[UILabel alloc]initWithFrame:CGRectMake(x,y,width,height)];
    mycoollabel.text=text;
    mycoollabel.numberOfLines=0;
    [currentcell.contentView addSubview:mycoollabel];
}




@end


