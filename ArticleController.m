//
//  ArticleController.m
//  NewsApp
//
//  Created by Zzz on 15.02.16.
//  Copyright © 2016 Zzz. All rights reserved.
//

#import "ArticleController.h"
#define kFilename @"data_new.plist" // plist для препаратов
#define kApothecary @"drugstoresList.plist" // для аптек
#define kUserCredent @"user_mobile_account.plist"
@interface ArticleController (UserAccount)

@end

@implementation ArticleController
@synthesize medicinesTNList = _medicinesTNList;
@synthesize currentCell = _currentCell;
@synthesize articleTbl = _articleTbl;
@synthesize approvedDeleting = _approvedDeleting;
@synthesize locationManager;
@synthesize longitudeHolder = _longitudeHolder;
@synthesize latitudeHolder = _latitudeHolder;

//@synthesize askPriceBtn;

//@synthesize parentObject = _parentObject;

//- (HomeController *)parentObject {
//    return _parentObject;
//}

-(CLLocationDegrees ) longitudeHolder {
    return _longitudeHolder;
}

-(CLLocationDegrees ) latitudeHolder {
    return _latitudeHolder;
}

-(BOOL) approvedDeleting {
    return _approvedDeleting;
}

-(UITableView *) articleTbl {
    return _articleTbl;
}

-(MedicinesPreOrderCell *) currentCell {
    return _currentCell;
}

-(NSArray *)medicinesTNList {
    if (!_medicinesTNList) {
        _medicinesTNList = [self getContentOfPlist:kFilename];
    }
    return _medicinesTNList;
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    // Do any additional setup after loading the view, typically from a nib.
    
    if ([self plistIsEmpty:kFilename]) {
        [self showAlert:@"Нет выбранных лекарств" msg:@"" actionText:@"OK. Перейти к выбору лекарств"];
        
    }
    else {
        _medicinesTNList = [self getContentOfPlist:kFilename];
        NSLog(@"_medicinesTNList: %@", _medicinesTNList);
    }
    
    _approvedDeleting = NO;
    
    [self checkIfAccountCredentialsAreInPlist];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Запрос местоположения *11.05.16 - отключено (можно перенести эту проверку уже на саму карту)
        self.locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.distanceFilter = kCLDistanceFilterNone; //whenever we move
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [locationManager startUpdatingLocation];
        [self.locationManager requestWhenInUseAuthorization];
    //    [self requestGeolocationAuthorization];
    // :END
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)previousView:(id)sender {
//    [self dismissViewControllerAnimated:YES completion:nil];
//    [self removeFromParentViewController];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return (int) [[self getContentOfPlist:kFilename] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"MedicinesPreOrderCell";
    int currentRow = (int) indexPath.row;
    NSDictionary *frstLevel = [self.medicinesTNList objectAtIndex:currentRow];
    
    NSLog(@"first level: %@", frstLevel);
    
    NSString *textLabelText = [NSString stringWithFormat:@"%@", [frstLevel  valueForKey:@"prepname"]];
    NSString *tempLatinName = [frstLevel valueForKey:@"latinname"];
    int lettersCounter = (int) [tempLatinName length];
    
    if (lettersCounter > 0) {
        textLabelText = [NSString stringWithFormat:@"%@ (%@)", [frstLevel valueForKey:@"prepname"], [frstLevel valueForKey:@"latinname"]];
    }
    
    NSString *detailText = [NSString stringWithFormat:@"%@", [frstLevel valueForKey:@"form"]];
//    int rrow = (int)[self indexFromIndexPath:indexPath currentTbl:tableView];
    MedicinesPreOrderCell *cell = (MedicinesPreOrderCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:simpleTableIdentifier owner:self options:nil];
        cell = (MedicinesPreOrderCell *) [nib objectAtIndex:0];
    }
    
    cell.header.text = textLabelText;
    cell.text.text = detailText;
//    NSString *tmpTagAsSectionRow = [NSString stringWithFormat:@"%@100%@", [frstLevel valueForKey:@"section"], [frstLevel valueForKey:@"row"]];
//    NSInteger setTagAsSectionRow = [tmpTagAsSectionRow integerValue];
//    cell.tag = setTagAsSectionRow;
    
    NSLog(@"the Cell tag: %lu", (long)cell.tag);
    
//    cell.SectionRowHolder.text = [frstLevel valueForKey:@"sectionrow"];
    cell.quantity.text = [NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"%@", [frstLevel valueForKey:@"quantity"]]];
    
    NSLog(@"real cell quantity: %@", cell.quantity.text);
    
    [cell.defaultStepper addTarget:cell action:@selector(stepperValueDidChange:) forControlEvents:UIControlEventValueChanged];
    [cell.defaultStepper addTarget:self action:@selector(stepperLocalAction:) forControlEvents:UIControlEventValueChanged];
//
    if (![self plistIsEmpty:kFilename]) {
        NSArray *getData = (NSArray *) [self getContentOfPlist:kFilename];
        for (NSDictionary *medicineData in getData) {
            int checkSection = [[medicineData valueForKey:@"section"] intValue];
            int checkRow = [[medicineData valueForKey:@"row"] intValue];
            
            NSLog(@"testing sect:%d row: %d = %d", checkSection, checkRow, [[medicineData valueForKey:@"quantity"] intValue]);
            
//            if ([self.medicinesTNList objectAtIndex:currentRow] valueForKey:@"sectionrow" == )
//            if (checkSection == currentSection &&
//                checkRow == (int) indexPath.row) {
                //            cell.defaultStepperLabel.text = [NSString stringWithFormat:@"%ld", (long)cell.defaultStepper.value];
//                cell.defaultStepperLabel.text = [NSString stringWithFormat:@"%d", [[medicineData valueForKey:@"quantity"] intValue]];
//                cell.SectionRowHolder.text = [NSString stringWithFormat:@"%d:%d", checkSection, checkRow];
                NSLog(@"section:%d row: %d = %d", checkSection, checkRow, [[medicineData valueForKey:@"quantity"] intValue]);
//            }
        }
        cell.defaultStepperLabel.text = [NSString stringWithFormat:@"%d", [[frstLevel valueForKey:@"quantity"] intValue]];
    }
    
    cell.defaultStepper.value = ([cell.defaultStepperLabel.text intValue] != 0) ? [cell.defaultStepperLabel.text intValue] : 0;
    cell.defaultStepper.minimumValue = 0;
    cell.defaultStepper.maximumValue = 100;
    cell.defaultStepper.stepValue = 1;
    _currentCell = cell;
    _currentCell.delegate = self;
    
    return cell;
}

#pragma mark -
#pragma mark Table View Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (NSUInteger)indexFromIndexPath:(NSIndexPath*)indexPath currentTbl:(UITableView *)tblView {
    NSUInteger index=0;
    for( int i=0; i<indexPath.section; i++ )
        index += [self tableView:tblView numberOfRowsInSection:i];
    index += indexPath.row;
    return index;
}

- (void)stepperLocalAction:(JLTStepper *)stepper {
//    [_articleTbl reloadData];
}


#pragma mark - SwipeableMedicinesPreOrderCellDelegate
- (void)deleteZero_Alerting :(NSIndexPath *)indexPath theCell:(UITableViewCell *)cell obj2remove:(NSMutableDictionary *)obj {
    NSLog(@"deleteZero_Alerting entered");
    MedicinesPreOrderCell *theCell = (MedicinesPreOrderCell *) cell;
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

- (IBAction)mainBtnClicked:(id)sender {
    UIButton *mainBtn = (UIButton *)sender;
    self.askThePriceBtn.hidden = NO;
    self.findDrugstore.hidden = NO;
    [self runAlpha:self.findDrugstore obj2:self.askThePriceBtn alph:1];
    [mainBtn setImage:[UIImage imageNamed:@"closeBtnRed_ready.png"] forState:UIControlStateNormal];
    [mainBtn addTarget:self
                action:@selector(closeBtnClicked:)
      forControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)closeBtnClicked:(id)sender {
    UIButton *mainBtn = (UIButton *)sender;
    [self runAlpha:self.findDrugstore obj2:self.askThePriceBtn alph:0];
    [mainBtn setImage:[UIImage imageNamed:@"topArrowBtnRed_ready.png"] forState:UIControlStateNormal];
    [mainBtn addTarget:self
                action:@selector(mainBtnClicked:)
      forControlEvents:UIControlEventTouchUpInside];
    self.askThePriceBtn.hidden = YES;
    self.findDrugstore.hidden = YES;
}

- (IBAction)price_availability:(id)sender {
    
    UIAlertController * view=   [UIAlertController
                                 alertControllerWithTitle:@"ЗАПРОС"
                                 message:@"ЦЕНЫ И НАЛИЧИЯ:"
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* online = [UIAlertAction
                             actionWithTitle:@"ВСЕ АПТЕКИ"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action) {
                                 [self sendRequestToAll];
                                 [view dismissViewControllerAnimated:YES completion:nil];
                             }];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Закрыть"
                             style:UIAlertActionStyleDestructive
                             handler:^(UIAlertAction * action)
                             {
                             }];
//    [online setValue:[[UIImage imageNamed:@"manual_icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forKey:@"image"];
//    [offline setValue:[[UIImage imageNamed:@"auto_icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forKey:@"image"];
    [view addAction:online];
    [view addAction:cancel];
    [self presentViewController:view animated:YES completion:nil];
}

- (IBAction)chooseTheDrugstores:(id)sender {
    UIAlertController * view=   [UIAlertController
                                 alertControllerWithTitle:@""
                                 message:@""
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* offline = [UIAlertAction
                              actionWithTitle:@"ВЫБРАТЬ АПТЕКИ НА КАРТЕ"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action) {
                                  [view dismissViewControllerAnimated:YES completion:nil];
                                  [self openMapDrugstoresView:sender];
                              }];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Закрыть"
                             style:UIAlertActionStyleDestructive
                             handler:^(UIAlertAction * action)
                             {
                             }];
    [view addAction:offline];
    [view addAction:cancel];
    [self presentViewController:view animated:YES completion:nil];
}


//- (void) setParentObject:(HomeController *)parentObject {
//    self.parentObject = parentObject;
//}

- (void) openMapDrugstoresView:(id)sender {
    [self.parentViewController.tabBarController setSelectedIndex:1];
}

// Анимация кнопок при нажатии

-(void) moveTheObjectUpward:(UIButton *)obj1 obj2:(UIButton *)obj2 shifting:(float)shift {
    float getCurrentY_obj1 = (float)obj1.frame.origin.y;
    float getCurrentY_obj2 = (float)obj2.frame.origin.y;
    [self moveIt:obj1 obj2:obj2 toPositionFrst:(getCurrentY_obj1 + shift) toPosition:(getCurrentY_obj2 + shift)];
}

-(void)moveIt:(UIButton *)obj1 obj2:(UIButton *)obj2 toPositionFrst:(float)toPositionFrst toPosition:(float)toPosition {
        dispatch_async(dispatch_get_main_queue(), ^{
    [UIView animateWithDuration:0.5f
                          delay:0.0f
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^ {
                         CGRect frameFrst = obj1.frame;
                         CGRect frame = obj2.frame;
                         frameFrst.origin.y = toPositionFrst;
                         frame.origin.y = toPosition;
                         frameFrst.origin.x = 0;
                         frame.origin.x = 0;
                         obj1.frame = frame;
                         obj2.frame = frame;
                     }
                     completion:^(BOOL finished) {
                         NSLog(@"Completed");
                     }];
    });
}

-(void) runAlpha:(UIButton *)obj1 obj2:(UIButton *)obj2 alph:(float)alph  {
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5f
                              delay:0.0f
                            options: UIViewAnimationOptionTransitionNone
                         animations:^ {
                             obj1.alpha = alph;
                             obj2.alpha = alph;
                         }
                         completion:^(BOOL finished) {
             NSLog(@"Completed");
         }];
    });
}


// сообщение во ВСЕ аптеки
-(void) sendRequestToAll {
    DrugstoreDesk *deskObj = [[DrugstoreDesk alloc] init];
    deskObj.delegate = self;
//    NSString *rlsQueryMainPart_Drugstore = @"http://www.rlsnet.ru/rlsserv_pricesbyregion.htm";
    
    NSString *rlsQueryMainPart_Drugstore = @"http://10.0.0.132:8888/mobileclient/";
    NSString *urlWithEAN_drugstore = [[NSString alloc] initWithFormat:@"%@", rlsQueryMainPart_Drugstore];
    NSLog(@"urlWithEAN_drugstore: %@", urlWithEAN_drugstore);
    
    /*
    // 1) Проверка, что можно получить широту/долготу (подключение CLLocation библиотеки)
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status != kCLAuthorizationStatusDenied && status != kCLAuthorizationStatusNotDetermined) {
        // 2.1) Добавление широты и долготы в выходной JSON
        NSLog(@"from submenu lon/lat : %f/%f", _longitudeHolder, _latitudeHolder);
    } else {
        // 2.2) Запрос местоположения *11.05.16 - отключено (можно перенести эту проверку уже на саму карту)
        // [self requestGeolocationAuthorization];
        NSString *message = @"Для подключения геолокации перейдите в 'Настройки' ";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:@"Отмена"
                                                  otherButtonTitles:@"Настройки", nil];
        [alertView show];
    }
    */
    
    // Завершение работы GPS *отключено 11.05.16
    //    [locationManager stopUpdatingLocation];
    //    [locationManager stopMonitoringSignificantLocationChanges];
    //    if(locationManager!=nil){
    //        locationManager.delegate= nil;
    //        locationManager= nil;
    //    }
    // :END
    
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"ВОЙТИ В АККАУНТ"
//                                                        message:@"Введите адрес почты и пароль"
//                                                       delegate:self
//                                              cancelButtonTitle:@"Отмена"
//                                              otherButtonTitles:@"Авторизоваться", nil];
//    alertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
//    UITextField * alertTxt_email = [alertView textFieldAtIndex:0];
//    UITextField * alertTxt_ps = [alertView textFieldAtIndex:1];
//    alertTxt_email.keyboardType = UIKeyboardTypeDefault;
//    alertTxt_email.placeholder = @"Введите адрес почты(email):";
//    alertTxt_ps.keyboardType = UIKeyboardTypeDefault;
//    alertTxt_ps.placeholder = @"Введите пароль:";
//    [alertView show];

    if (!userHasEnteredAccount) {
        [self showAccountMessage];
    } else {
        // 3) Добавление всех данных по выбранным лекарствам и их объединение в JSON
        NSDictionary *drugstoresQuantityTypeDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                                          @"0", @"drugstoresQuantType", nil]; // 0 - тогда выбор по всем аптекам
        NSArray *userDataFromFile = [self getContentOfPlist:kUserCredent];
        NSString *userEmailFromFile = [userDataFromFile objectAtIndex:0];
        NSDictionary *locationDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                            [NSNumber numberWithDouble: _latitudeHolder], @"latitude",
                                            [NSNumber numberWithDouble: _longitudeHolder], @"longitude",
                                            userEmailFromFile, @"mobileUser_email", nil];
        NSMutableArray *location_drugstoresQuantTypeData = [[NSMutableArray alloc] initWithObjects:locationDictionary, drugstoresQuantityTypeDictionary, nil];
        NSArray *medicineData = [self getContentOfPlist:kFilename];
        NSArray *drugstoresData = [self getContentOfPlist:kApothecary];
        NSMutableArray *generalData2BeJSON = [[NSMutableArray alloc] initWithObjects:location_drugstoresQuantTypeData, medicineData, drugstoresData, nil];
        
        NSError *error;
        //    NSMutableDictionary *tmp = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
        //                                generalData2BeJSON, @"jsonData", nil];
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:generalData2BeJSON options:0 error:&error];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"jsonData as string:\n%@ if error:%@", jsonString, error);
        
        // 4) Отправка собранных данных на сервер
        //    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [deskObj requestTheDrugstoreDeskServer:urlWithEAN_drugstore JSONData:jsonData];
        
        [self sendDrugstoresData:jsonData];
        
        //        dispatch_async(dispatch_get_main_queue(), ^{
        //            NSLog(@"counter from collectionView %d", (int) collectionView_sections_counter);
        //        });
        //    });
        
        
        // :END

    }
    
    
    
}

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    NSLog(@"Entered email: %@",[[alertView textFieldAtIndex:0] text]);
//    NSLog(@"Entered password: %@",[[alertView textFieldAtIndex:1] text]);
//}

-(void) returnJSONResponse:(NSMutableDictionary *)jsonData {
    NSLog(@">>> from Article %@ <<<", jsonData);
    
    if ([jsonData valueForKey:@"userLoginPassword"]) {
        NSString *readResponse = [jsonData valueForKey:@"userLoginPassword"];
        NSLog(@"readResponse: %@", readResponse);
        if ([readResponse isEqualToString:@"0"]) {
            // сообщение, что такого пользователя не существует или допущена ошибка в логине/пароле
            [self showSmplAlert:@"Такого пользователя не существует" msg:@"или допущена ошибка в логине/пароле" actionText:@"Попробовать еще раз"];
        } else {
            [self showSmplAlert:@"Отлично !" msg:@"Ваш аккаунт активирован !" actionText:@"OK"];
            // Запись логин/пароля в файл-аккаунт мобильного пользователя
            NSString *sentLogin = [jsonData valueForKey:@"L"];
            NSString *sentPassw = [jsonData valueForKey:@"P"];
            NSMutableArray *generateArray = [[NSMutableArray alloc] initWithObjects:sentLogin, sentPassw, nil];
            [generateArray writeToFile:[self dataFilePath:kUserCredent] atomically:YES];
            userHasEnteredAccount = YES;
            // :END
        }
    } else if ([jsonData valueForKey:@"userLostKey"]) {
        NSString *readResponse = [jsonData valueForKey:@"userLostKey"];
        NSLog(@"readResponse: %@", readResponse);
        if ([readResponse isEqualToString:@"0"]) {
            // сообщение, что такого пользователя не существует или допущена ошибка в логине/пароле
            [self showSmplAlert:@"Такого пользователя не существует" msg:@"или допущена ошибка в логине" actionText:@"Попробовать еще раз"];
        } else {
            [self showSmplAlert:@"Отлично !" msg:@"Ответ выслан на Вашу почту !" actionText:@"OK"];
        }
    } else if ([jsonData valueForKey:@"userRegistration"]) {
        NSString *readResponse = [jsonData valueForKey:@"userRegistration"];
        NSLog(@"readResponse: %@", readResponse);
        if ([readResponse isEqualToString:@"0"]) {
            // сообщение, что такого пользователя не существует или допущена ошибка в логине/пароле
            [self showSmplAlert:@"Такого пользователя не существует" msg:@"или допущена ошибка в логине" actionText:@"Попробовать еще раз"];
        } else if ([readResponse isEqualToString:@"1"]) {
            [self showSmplAlert:@"Отлично !" msg:@"Ответ выслан на Вашу почту !" actionText:@"OK"];
        } else if ([readResponse isEqualToString:@"email_exists"]) {
            [self showSmplAlert:@"Данный логин уже существует !" msg:@"Нажмите на \"Забыли пароль ?\"" actionText:@"OK"];
        } else if ([readResponse isEqualToString:@"email_error"]) {
            [self showSmplAlert:@"Ошибка с отправкой на указанную почту" msg:@"" actionText:@"OK"];
        }
    }
    
    NSLog(@"[jsonData valueForKey:drugstoresDataSent: %@", [jsonData valueForKey:@"drugstoresDataSent"]);
    
    if ([jsonData valueForKey:@"drugstoresDataSent"]) {
        NSString *resp = [jsonData valueForKey:@"drugstoresDataSent"];
        if ([resp isEqualToString:@"OK"]) {
            [self showGoToApothecaryAlert:@"Спасибо!\n Ваш предзаказ получен!" msg:@"Нажмите \"ОБНОВИТЬ\" в разделе \"Аптеки\" (среднее время ответа 10-15 минут)"  actionText:@"ПЕРЕЙТИ В \"Аптеки\""];
        } else {
            [self showSmplAlert:@"Ошибка с отправкой на указанную почту" msg:@"" actionText:@"OK"];
        }
    }
    
}

# pragma mark - delegate methods Map location detection
- (void)requestGeolocationAuthorization {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    // If the status is denied or only granted for when in use, display an alert
    if (status == kCLAuthorizationStatusDenied) {
        NSString *title;
        if (status == kCLAuthorizationStatusDenied) title = @"Не включены службы определения местоположения";
        NSString *message = @"Для подключения геолокации перейдите в 'Настройки' ";
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:@"Отмена"
                                                  otherButtonTitles:@"Настройки", nil];
        [alertView show];
    }
    // The user has not enabled any location services. Request background authorization.
    else if (status == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestWhenInUseAuthorization];
    }
}


/*
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"Button index: %d", (int) buttonIndex);
    NSLog(@"Entered email: %@",[[alertView textFieldAtIndex:0] text]);
    NSLog(@"Entered password: %@",[[alertView textFieldAtIndex:1] text]);
    
    
    if (buttonIndex == 1) {
        UIAlertView *authAlert = [[UIAlertView alloc] initWithTitle:@"АВТОРИЗАЦИЯ"
                                                            message:@"введите адрес почты и на нее будут высланы: подтверждающая ссылка и пароль"
                                                           delegate:self
                                                  cancelButtonTitle:@"Отмена"
                                                  otherButtonTitles:@"Перейти в почту", nil];
        NSURL *settingsURL = [NSURL URLWithString:@"mailto:"];
        authAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
        UITextField * alertTxt_email = [authAlert textFieldAtIndex:0];
        alertTxt_email.keyboardType = UIKeyboardTypeDefault;
        alertTxt_email.placeholder = @"Введите адрес почты(email):";
        [authAlert show];

    }
*/
    // ДЛЯ НАСТРОЙКИ ГЕОЛОКАЦИИ * отключено 11.05.16
    /*
    if (buttonIndex == 1) {
        // Send the user to the Settings for this app
        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:settingsURL];
    }
     */
    // END: ДЛЯ НАСТРОЙКИ ГЕОЛОКАЦИИ * отключено 11.05.16
/*
}
*/

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
//    UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"There was an error retrieving your location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//    [errorAlert show];
//    NSLog(@"Error: %@",error.description);
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *crnLoc = [locations lastObject];
    _latitudeHolder = crnLoc.coordinate.latitude;
    _longitudeHolder = crnLoc.coordinate.longitude;
    NSLog(@"%.0f m",crnLoc.altitude);
    NSLog(@"%.1f m/s", crnLoc.speed);
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    _longitudeHolder = userLocation.coordinate.longitude;
    _latitudeHolder = userLocation.coordinate.latitude;
    NSLog(@"Location: %.5f°, %.5f°", _longitudeHolder, _latitudeHolder);
}

@end
