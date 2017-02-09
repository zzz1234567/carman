//
//  PreorderData.m
//  Навигатор лекарств
//
//  Created by Zzz on 30.05.16.
//  Copyright © 2016 Zzz. All rights reserved.
//


#define kFilename @"data_new.plist" // plist для препаратов
#define kApothecary @"drugstoresList.plist" // для аптек
#define kUserCredent @"user_mobile_account.plist"

#define kPreorderList @"preorder.plist" // plist для предзаказа

#import "PreorderData.h"

@implementation PreorderData {
    float ttlPrice;
    int ttlQuant;
}
@synthesize medicinesTNList = _medicinesTNList;
@synthesize currentCell = _currentCell;
@synthesize preorderTbl = _preorderTbl;
@synthesize segmentControl = _segmentControl;
@synthesize contentHolder = _contentHolder;
@synthesize orderBtn = _orderBtn;
@synthesize quantView = _quantView;
@synthesize sumView = _sumView;
@synthesize preorderTitleText = _preorderTitleText;
@synthesize apothecPhone = _apothecPhone;
@synthesize apothecAddress = _apothecAddress;
@synthesize apothecWebsite = _apothecWebsite;
@synthesize apothecWorkingHours = _apothecWorkingHours;
@synthesize preorderData = _preorderData;
@synthesize preorderViewId = _preorderViewId;
@synthesize apothecaryIdNumber = _apothecaryIdNumber;
@synthesize preorderResponse = _preorderResponse;
@synthesize totalPrice = _totalPrice;
@synthesize totalQuant = _totalQuant;

-(MedicinesCell *) currentCell {
    return _currentCell;
}

-(NSMutableArray *)preorderResponse {
    return _preorderResponse;
}

-(NSString *) apothecaryIdNumber {
    return _apothecaryIdNumber;
}

- (UITextField *) preorderViewId {
    return _preorderViewId;
}

-(NSDictionary *) preorderData {
    return _preorderData;
}

-(UILabel *) apothecWorkingHours {
    return _apothecWorkingHours;
}

-(UILabel *) apothecWebsite {
    return _apothecWebsite;
}

-(UILabel *) apothecAddress {
    return _apothecAddress;
}

-(UILabel *) apothecPhone {
    return _apothecPhone;
}

-(UITextField *) preorderTitleText {
    return _preorderTitleText;
}

-(UITableView *) preorderTbl {
    return _preorderTbl;
}

-(UIView *) orderBtn {
    return _orderBtn;
}

-(UIView *) quantView {
    return _quantView;
}

-(UIView *) sumView {
    return _sumView;
}


-(BOOL) approvedDeleting {
    return _approvedDeleting;
}

- (UIView *) contentHolder {
    return _contentHolder;
}

- (UISegmentedControl *) segmentControl{
    return _segmentControl;
}

-(NSArray *)medicinesTNList {
    //    if (!_medicinesTNList) {
    //        _medicinesTNList = [self getContentOfPlist];
    //    }
    return _medicinesTNList;
}


-(void)viewDidLoad {
    [super viewDidLoad];
    [_segmentControl addObserver:self forKeyPath:@"selectedSegmentIndex" options:NSKeyValueObservingOptionInitial context:nil];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:NO];
    [_segmentControl removeObserver:self forKeyPath:@"selectedSegmentIndex"];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [[self navigationController] setNavigationBarHidden:NO animated:YES];
//    UINavigationBar *nav = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
//    nav.topItem.title = @"1234567890";
//    [self.view addSubview:nav];
//    self.navigationController.navigationBarHidden = NO;
    
    
    
    [self styleNavBar];
    _orderBtn = [self addShadowAndRoundedCorners:_orderBtn corner:24.0f borderW:0.5f];
    _preorderTbl.hidden = YES;
    _contentHolder.hidden = NO;
    _orderBtn.hidden = YES;
    _quantView.hidden = YES;
    _sumView.hidden = YES;
    if ([self plistIsEmpty:kFilename]) {
        [self showAlert:@"Нет выбранных лекарств" msg:@"" actionText:@"OK. Перейти к выбору лекарств"];
    } else {
        _medicinesTNList = [self getContentOfPlist:kFilename];
        NSLog(@"_medicinesTNList: %@", _medicinesTNList);
    }
    _approvedDeleting = NO;
    [self checkIfAccountCredentialsAreInPlist];
    
    NSArray *getData = (NSArray *) [self getContentOfPlist:kApothecary];
    NSDictionary *apothecData = [getData objectAtIndex: [_preorderViewId.text intValue]];
    NSLog(@"apothecData: %@", apothecData);
    
    _apothecAddress.text = (![apothecData valueForKey:@"address"]) ? @"---" : [apothecData valueForKey:@"address"];
    _apothecWorkingHours.text = (![apothecData valueForKey:@"hours"]) ? @"---" : [apothecData valueForKey:@"hours"];
    _apothecWebsite.text = (![apothecData valueForKey:@"url"]) ? @"---" : [apothecData valueForKey:@"url"];
    _apothecPhone.text = (![apothecData valueForKey:@"phone"]) ? @"---" : [apothecData valueForKey:@"phone"];
    
    _apothecaryIdNumber = [apothecData valueForKey:@"drugstoreid"];
    
    
    
}

-(void)showAlert:(NSString *) title msg:(NSString *)msg actionText:(NSString *)actionText {
    UIAlertController *myAlertController = [UIAlertController alertControllerWithTitle:title
                                                                               message:msg
                                                                        preferredStyle:UIAlertControllerStyleAlert                   ];
    UIAlertAction *alertView = [UIAlertAction
                                actionWithTitle:actionText
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    [self dismissViewControllerAnimated:YES completion:nil];
                                    
                                }];
    [myAlertController addAction:alertView];
    [self presentViewController:myAlertController animated:YES completion:nil];
}

-(void)showCustomAlert:(NSString *) title msg:(NSString *)msg actionText:(NSString *)actionText showCancel:(BOOL)showCancel cancelText:(NSString *)cancelText obj2remove:(NSMutableDictionary *)obj {
    UIAlertController *myAlertController = [UIAlertController alertControllerWithTitle:title
                                                                               message:msg
                                                                        preferredStyle:UIAlertControllerStyleAlert                   ];
    UIAlertAction *alertView = [UIAlertAction
                                actionWithTitle:actionText
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    //Do some thing here, eg dismiss the alertwindow
                                    _approvedDeleting = YES;
                                    
                                    NSMutableArray *array = [[NSMutableArray alloc] initWithArray: [self getContentOfPlist:kFilename]];
                                    [array removeObject:obj];
                                    [array writeToFile:[self dataFilePath:kFilename] atomically:YES];
                                    
                                    _medicinesTNList = [self getContentOfPlist:kFilename];
                                    NSLog(@"_medicinesTNList: %@", _medicinesTNList);
                                    [_currentCell theTableReloader];
                                    
                                    int arrayCapacity = (int) [array count];
                                    NSLog(@"alertView completion: %d obj: %@ array capacity: %d", _approvedDeleting, obj, arrayCapacity);
                                    if (arrayCapacity <= 0) {
                                        //                                        [self dismissViewControllerAnimated:YES completion:nil];
                                        [self.navigationController popViewControllerAnimated:YES];
                                    }
                                    
                                    //                                    [self dismissViewControllerAnimated:NO completion:nil];
                                    //                                    [[myAlertController.view superview] reloadInputViews];
                                }];
    [myAlertController addAction:alertView];
    if (showCancel) {
        UIAlertAction* cancel = [UIAlertAction
                                 actionWithTitle:cancelText
                                 style:UIAlertActionStyleDestructive
                                 handler:^(UIAlertAction * action)
                                 {
                                     _approvedDeleting = NO;
                                     _currentCell.defaultStepper.value++;
                                     _currentCell.defaultStepperLabel.text = [NSString stringWithFormat:@"%ld", (long)_currentCell.defaultStepper.value];
                                     [myAlertController dismissViewControllerAnimated:YES completion:nil];
                                 }];
        [myAlertController addAction:cancel];
    }
    
    [self presentViewController:myAlertController animated:YES completion:nil];
}


-(BOOL)plistIsEmpty:(NSString *)fName {
    if (nil == [self getContentOfPlist:fName] || [[self getContentOfPlist:fName] count] == 0) {
        return YES;
    } else {
        return NO;
    }
}

- (UIBarButtonItem *)setCustomNavigationBackButton {
    UIButton *refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [refreshButton setFrame:CGRectMake(0,0,30,30)];
    refreshButton.userInteractionEnabled = YES;
    [refreshButton setImage:[UIImage imageNamed:@"Back-22"] forState:UIControlStateNormal];
    [refreshButton addTarget:self action:@selector(previousView:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *refreshBarButton = [[UIBarButtonItem alloc] initWithCustomView:refreshButton];
    return refreshBarButton;
}

- (void)styleNavBar {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    UINavigationBar *newNavBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 64.0)];
    [newNavBar setTintColor:[UIColor whiteColor]];
    [newNavBar setBackgroundColor:[UIColor whiteColor]];
    

    
//    UIBarButtonItem* backItem = [self setCustomNavigationBackButton];
    
    // :END
    
    
    
       
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont
                                                                           fontWithName:@"Avenir Book" size:22], NSFontAttributeName,
                                [UIColor colorWithRed:0.278 green:0.545 blue:0.855 alpha:0.8], NSForegroundColorAttributeName, nil];
    [[UINavigationBar appearance] setTitleTextAttributes:attributes];
    
    UINavigationItem *newItem = [[UINavigationItem alloc] init];
    newItem.title = self.preorderTitleText.text;
    newItem.leftBarButtonItem = [self setCustomNavigationBackButton];
    // add to toolbar, or to a navbar (you should only have one of these!)
    [newNavBar setItems:[NSArray arrayWithObjects:newItem, nil]];
    
//    newItem.leftBarButtonItem = backItem;
//    [newNavBar setItems:@[newItem]];
    
    
    
//    self.navigationController.navigationItem.backBarButtonItem = backBarButtonItem;
    
    [self.view addSubview:newNavBar];
}

//- (UIViewController *)backViewController {
//    NSInteger numberOfViewControllers = self.navigationController.viewControllers.count;
//    
//    if (numberOfViewControllers < 2)
//        return nil;
//    else
//        return [self.navigationController.viewControllers objectAtIndex:numberOfViewControllers - 2];
//}

- (IBAction)previousView:(id)sender {
//    NSLog(@"previous view click");
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark Table View Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // decoder (because there is a string:
    NSData *data = [[_preorderData valueForKey:@"json_medicine_name_quant"] dataUsingEncoding:NSUTF8StringEncoding];
    // Масссив
    _preorderResponse = [[NSMutableArray arrayWithObjects:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil],nil] objectAtIndex:0];
    NSLog(@"_preorderResponse: %@ \n ", _preorderResponse);
    // :END
    ttlPrice = 0.0;
    ttlQuant = 0;
    for (NSDictionary *dctnr in _preorderResponse) {
        float priceValue = [[dctnr valueForKey:@"medPrice"] floatValue];
        int quantityValue = [[dctnr valueForKey:@"medQuantity"] intValue];
        ttlPrice += priceValue;
        ttlQuant += quantityValue;
    }
    self.totalQuant.text = [NSString stringWithFormat:@"%d", ttlQuant];
    self.totalPrice.text = [NSString stringWithFormat:@"%.02f", ttlPrice];
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
//    return (int) [[self getContentOfPlist:kFilename] count];
    NSLog(@"the table counter: %d", (int)[_preorderResponse count]);
    return (int)[_preorderResponse count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"MedicinesCell";
    int currentRow = (int) indexPath.row;
//    NSDictionary *frstLevel = [self.medicinesTNList objectAtIndex:currentRow];
    NSDictionary *frstLevel = [_preorderResponse objectAtIndex:currentRow];
    
//    NSArray *tmp = [self getContentOfPlist:kPreorderList];
//    NSLog(@"tmp: %@", _preorderData);
    
    
    NSLog(@"preorder level: %@", frstLevel);
    NSLog(@"preorder name: %@", [frstLevel valueForKey:@"medName"]);
    
//    NSLog(@"preorderdata from the first segment: %@", _preorderData);
//    NSLog(@"json_medicine_name_quant: %@", [[_preorderData valueForKey:@"json_medicine_name_quant"] className]);
//
    // decoder (because there is a string:
//    NSData *data = [[_preorderData valueForKey:@"json_medicine_name_quant"] dataUsingEncoding:NSUTF8StringEncoding];
//    NSArray *arrayJson = [NSArray arrayWithObjects:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil],nil];
//    
//    NSLog(@"arrayJson: %@ \n ", [[[arrayJson objectAtIndex:0] objectAtIndex:0] className]);
//    
//    for (NSDictionary *preorderRow in [arrayJson objectAtIndex:0]) {
//        NSLog(@"rowValue: %@  \n", [preorderRow valueForKey:@"medName"]);
//    }
//    NSStringEncoding *encoding = [NSUTF8StringEncoding]
//    NSString *str = @"The weather on \U0001F30D is \U0001F31E today.";
    
    NSString *str = [frstLevel  valueForKey:@"medName"];
//    NSString *str = @"\u00ae";
//    NSString *strRepl = [str stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];

//    NSString *strRepl = [str string
//    NSString *correctString =
//    const char *str = [[frstLevel  valueForKey:@"medName"] cStringUsingEncoding:NSUTF8StringEncoding];
    NSString *replstr = [str stringByReplacingOccurrencesOfString:@"\u00ae" withString:@"®"];
    NSString *textLabelText = [NSString stringWithFormat:@"%@", replstr];
    
//    NSString *tempLatinName = [frstLevel valueForKey:@"latinname"];
//    int lettersCounter = (int) [tempLatinName length];
    
//    if (lettersCounter > 0) {
//        textLabelText = [NSString stringWithFormat:@"%@ (%@)", [frstLevel valueForKey:@"prepname"], [frstLevel valueForKey:@"latinname"]];
//    }
    
//    NSString *detailText = [NSString stringWithFormat:@"%@", [frstLevel valueForKey:@"form"]];
    //    int rrow = (int)[self indexFromIndexPath:indexPath currentTbl:tableView];
    MedicinesCell *cell = (MedicinesCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:simpleTableIdentifier owner:self options:nil];
        cell = (MedicinesCell *) [nib objectAtIndex:0];
    }
    
    
//    NSString *medQunatity = [realJSON    valueForKey:@"medQuantity"];
//        NSString *medName = [jsonPart valueForKey:@"medName"];
//        NSString *medPresense = [jsonPart valueForKey:@"medPresense"];
//        NSString *medPrice = [jsonPart valueForKey:@"medPrice"];
//        
//    }
//
    
    cell.header.text = textLabelText;
//    cell.text.text = detailText;
    
    //    NSString *tmpTagAsSectionRow = [NSString stringWithFormat:@"%@100%@", [frstLevel valueForKey:@"section"], [frstLevel valueForKey:@"row"]];
    //    NSInteger setTagAsSectionRow = [tmpTagAsSectionRow integerValue];
    //    cell.tag = setTagAsSectionRow;
    
    NSLog(@"the Cell tag: %lu", (long)cell.tag);
    
    //    cell.SectionRowHolder.text = [frstLevel valueForKey:@"sectionrow"];
    cell.quantity.text = [NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"%@", [frstLevel valueForKey:@"medQuantity"]]];
    cell.price.text = [NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"%@", [frstLevel valueForKey:@"medPrice"]]];
    
    
    
//    [cell.defaultStepper addTarget:cell action:@selector(stepperValueDidChange:) forControlEvents:UIControlEventValueChanged];
    //    [cell.defaultStepper addTarget:self action:@selector(stepperLocalAction:) forControlEvents:UIControlEventValueChanged];
    //
//    if (![self plistIsEmpty:kFilename]) {
//        NSArray *getData = (NSArray *) [self getContentOfPlist:kFilename];
//        for (NSDictionary *medicineData in getData) {
//            int checkSection = [[medicineData valueForKey:@"section"] intValue];
//            int checkRow = [[medicineData valueForKey:@"row"] intValue];
//            
//            //            NSLog(@"testing sect:%d row: %d = %d", checkSection, checkRow, [[medicineData valueForKey:@"quantity"] intValue]);
//            
//            //            if (checkSection == currentSection &&
//            //                checkRow == (int) indexPath.row) {
//            //            cell.defaultStepperLabel.text = [NSString stringWithFormat:@"%ld", (long)cell.defaultStepper.value];
//            cell.defaultStepperLabel.text = [NSString stringWithFormat:@"%d", [[medicineData valueForKey:@"quantity"] intValue]];
//            cell.SectionRowHolder.text = [NSString stringWithFormat:@"%d:%d", checkSection, checkRow];
//            NSLog(@"section:%d row: %d = %d", checkSection, checkRow, [[medicineData valueForKey:@"quantity"] intValue]);
//            //            }
//        }
//    }
    
//    cell.defaultStepper.value = ([cell.defaultStepperLabel.text intValue] != 0) ? [cell.defaultStepperLabel.text intValue] : 0;
//    cell.defaultStepper.minimumValue = 0;
//    cell.defaultStepper.maximumValue = 100;
//    cell.defaultStepper.stepValue = 1;
//    _currentCell = cell;
//    _currentCell.delegate = self;
    
    
    
    return cell;
}

#pragma mark -
#pragma mark Table View Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

//- (NSUInteger)indexFromIndexPath:(NSIndexPath*)indexPath currentTbl:(UITableView *)tblView {
//    NSUInteger index=0;
//    for( int i=0; i<indexPath.section; i++ )
//        index += [self tableView:tblView numberOfRowsInSection:i];
//    index += indexPath.row;
//    return index;
//}
//
#pragma mark - SwipeableMedicinesCellDelegate
- (void)deleteZero_Alerting :(NSIndexPath *)indexPath theCell:(UITableViewCell *)cell obj2remove:(NSMutableDictionary *)obj {
    NSLog(@"deleteZero_Alerting entered");
    MedicinesCell *theCell = (MedicinesCell *) cell;
    NSString *positionText = [NSString stringWithFormat:@"%@ (%@)", theCell.header.text, theCell.text.text];
    [self showCustomAlert:@"Подтвердить удаление позиции ?:"
                      msg:positionText
               actionText:@"УДАЛЯЕМ!"
               showCancel:YES
               cancelText:@"ОТМЕНА"
               obj2remove:obj];
    NSLog(@"_approvedDeleting: %d", (int)_approvedDeleting);
    //    return _approvedDeleting;
}

-(void)showPreorderMedicineList {
    _preorderTbl.hidden = NO;
    _contentHolder.hidden = YES;
    _orderBtn.hidden = NO;
    _quantView.hidden = NO;
    _sumView.hidden = NO;
}

-(void)showPreorderDrugstoreList {
    _preorderTbl.hidden = YES;
    _contentHolder.hidden = NO;
    _orderBtn.hidden = YES;
    _quantView.hidden = YES;
    _sumView.hidden = YES;
}

-(IBAction)orderApprovingSendToUserAccount:(id)sender {
    NSArray *userDataFromFile = [self getContentOfPlist:kUserCredent];
    NSString *userEmailFromFile = [userDataFromFile objectAtIndex:0];
    NSArray *medicineData = [self getContentOfPlist:kFilename];
    NSDictionary *user_apothecary = [NSDictionary dictionaryWithObjectsAndKeys:
                                        userEmailFromFile, @"usermail", _apothecaryIdNumber, @"apothecid", medicineData, @"medlist", nil];
//    NSMutableArray *generalData2BeJSON = [[NSMutableArray alloc] initWithObjects:user_apothecary, nil];
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user_apothecary options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"jsonData from orderApprovingSendToUserAccount as string:\n%@ if error:%@", jsonString, error);
    [self approveTheOrder:jsonData];
}

-(UIView *) addShadowAndRoundedCorners:(UIView *)v corner:(float)cornerRadius borderW:(float)borderWidth {
    float bw = (borderWidth) ? borderWidth : 1.5f;
    float cr = (cornerRadius) ? cornerRadius : 30.0f;
    
    // border radius
    [v.layer setCornerRadius:cr];
    
    // border
    [v.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [v.layer setBorderWidth:bw];
    
    // drop shadow
    [v.layer setShadowColor:[UIColor blackColor].CGColor];
    [v.layer setShadowOpacity:0.8];
    [v.layer setShadowRadius:3.0];
    [v.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    v.layer.masksToBounds = true;
    
    return v;
}


#pragma mark - Segment event (KVO observer)
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    NSLog(@"segment index: %ld", (long)_segmentControl.selectedSegmentIndex);
    
    if (_segmentControl.selectedSegmentIndex == 1) {
        [self showPreorderMedicineList];
//        [self askThePreorderDetails];
    } else {
        [self showPreorderDrugstoreList];
    }
    
//    @try {
//        [object removeObserver:self forKeyPath:@"selectedSegmentIndex"];
//    }
//    @catch (NSException * __unused exception) {}

}



@end


