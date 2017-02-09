//
//  UserAccount.m
//  Навигатор лекарств
//
//  Created by Zzz on 11.05.16.
//  Copyright © 2016 Zzz. All rights reserved.
//

#import "UserAccount.h"
#import "ApothecariesListController.h"
#define kForgetKeyURL @"http://10.0.0.132:8888/mobileclient/forget/" // url для забытого ключа (отправка адреса почты -> получение пароля)
#define kAuthURL @"http://10.0.0.132:8888/mobileclient/auth/" // url для авторизации (отправка адреса почты -> получение пароля)
#define kAccountURL @"http://10.0.0.132:8888/mobileclient/loginmob/" // url для аккаунта (отправка адреса почты и пароля -> сообщение)

#define kSendingDrugstoresData @"http://10.0.0.132:8888/mobileclient/"

#define kReadingDrugstoresData @"http://10.0.0.132:8888/mobileclient/priceavail/"

#define kUserCredent @"user_mobile_account.plist"

#define kOrder @"http://10.0.0.132:8888/mobileclient/makeorder/" // url для подтверждения заказа

@implementation UserAccount

@synthesize loginHolder = _loginHolder;
@synthesize passwordHolder = _passwordHolder;
@synthesize userHasEnteredAccount = _userHasEnteredAccount;

- (UITextField *)loginHolder {
    return _loginHolder;
}

- (UITextField *)passwordHolder {
    return _passwordHolder;
}



- (void) showAccountMessage {
    UIAlertController *accountController = [UIAlertController alertControllerWithTitle:@"ВОЙТИ В АККАУНТ"
                                                                               message:@"Введите адрес почты и пароль"
                                                                        preferredStyle:UIAlertControllerStyleAlert                   ];
    UIAlertAction *authAction = [UIAlertAction
                                 actionWithTitle:@"Регистрация"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action) {
                                     [self authorizeMessage];
                                 }];
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"Закрыть (X)"
                                   style:UIAlertActionStyleDestructive
                                   handler:^(UIAlertAction * action) {
                                       //                                    [self dismissViewControllerAnimated:YES completion:nil];
                                       
                                   }];
    UIAlertAction *forgetPswAction = [UIAlertAction
                                      actionWithTitle:@"Забыли пароль ?"
                                      style:UIAlertActionStyleDestructive
                                      handler:^(UIAlertAction * action) {
                                          //                                    [self dismissViewControllerAnimated:YES completion:nil];
                                          [self forgetPsw];
                                      }];
    [accountController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = NSLocalizedString(@"Введите адрес почты(email):", @"Login");
//        _loginHolder = textField;
    }];
    [accountController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = NSLocalizedString(@"Введите пароль:", @"Password");
//        _passwordHolder = textField;
        textField.secureTextEntry = YES;
    }];
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action) {
                                   _loginHolder = accountController.textFields.firstObject;
                                   _passwordHolder = accountController.textFields.lastObject;
                                   
                                   // отправка запроса на контроллер входа в аккаунт:
                                   DrugstoreDesk *deskObj = [[DrugstoreDesk alloc] init];
                                   deskObj.delegate = self;
                                   NSError *error;
                                   NSDictionary *mail_pswToJSON = [NSDictionary dictionaryWithObjectsAndKeys: _loginHolder.text, @"email", _passwordHolder.text, @"password", nil];
//                                   NSMutableArray *mail_psw2BeJSON = [[NSMutableArray alloc] initWithObjects:mail_pswToJSON, nil];
                                   NSData *jsonData = [NSJSONSerialization dataWithJSONObject:mail_pswToJSON options:0 error:&error];
                                   NSLog(@"show error: %@", error);
                                   [deskObj requestTheDrugstoreDeskServer:kAccountURL JSONData:jsonData];
                                
                                   
                                   
//                                   NSURL *mailtoURL = [NSURL URLWithString:@"mailto:"];
//                                   [[UIApplication sharedApplication] openURL:mailtoURL];
                                   // :END отправка запроса на контроллер входа в аккаунт

                                   NSLog(@"UITextField *loginHolder: %@", _loginHolder.text);
                               }];
    [accountController addAction:okAction];
    [accountController addAction:cancelAction];
    [accountController addAction:forgetPswAction];
    [accountController addAction:authAction];
    [self presentViewController:accountController animated:YES completion:nil];
}

- (void) authorizeMessage {
    UIAlertController *authController = [UIAlertController alertControllerWithTitle:@"РЕГИСТРАЦИЯ"
                                                                            message:@"введите адрес почты и на нее будут высланы: подтверждающая ссылка и пароль"
                                                                     preferredStyle:UIAlertControllerStyleAlert                   ];
    UIAlertAction *authAction = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action) {
                                     
                                     // отправка запроса на контроллер регистрации:
                                     DrugstoreDesk *deskObj = [[DrugstoreDesk alloc] init];
                                     deskObj.delegate = self;
                                     NSError *error;
                                     NSLog(@"_loginHolder.text: %@", _loginHolder.text);
                                     NSDictionary *mailToJSON = [NSDictionary dictionaryWithObjectsAndKeys: _loginHolder.text, @"email", nil];
//                                     NSMutableArray *mail_psw2BeJSON = [[NSMutableArray alloc] initWithObjects:mailToJSON, nil];
                                     NSData *jsonData = [NSJSONSerialization dataWithJSONObject:mailToJSON options:0 error:&error];
                                     NSLog(@"show error: %@", error);
                                     [deskObj requestTheDrugstoreDeskServer:kAuthURL JSONData:jsonData];
                                     
//                                     NSURL *mailtoURL = [NSURL URLWithString:@"mailto:"];
//                                     [[UIApplication sharedApplication] openURL:mailtoURL];
                                     // :END
                                     
                                     
                                     
                                     
                                     
                                     //                                   NSURL *mailtoURL = [NSURL URLWithString:@"mailto:"];
                                     //                                   [[UIApplication sharedApplication] openURL:mailtoURL];
                                     
                                     
                                 }];
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"Отменить"
                                   style:UIAlertActionStyleDestructive
                                   handler:^(UIAlertAction * action) {
                                       //                                       [self dismissViewControllerAnimated:YES completion:nil];
                                       
                                   }];
    [authController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = NSLocalizedString(@"Введите адрес почты(email):", @"Login");
        _loginHolder = textField;
    }];
    [authController addAction:authAction];
    [authController addAction:cancelAction];
    [self presentViewController:authController animated:YES completion:nil];
}

- (void) forgetPsw {
    UIAlertController *authController = [UIAlertController alertControllerWithTitle:@"ВОССТАНОВЛЕНИЕ ПАРОЛЯ"
                                                                            message:@"введите адрес почты и на нее будет выслан пароль"
                                                                     preferredStyle:UIAlertControllerStyleAlert                   ];
    UIAlertAction *authAction = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action) {
                                     //                                     [self dismissViewControllerAnimated:YES completion:nil];
                                     //                                     NSURL *mailtoURL = [NSURL URLWithString:@"mailto:"];
                                     //                                     [[UIApplication sharedApplication] openURL:mailtoURL];
//                                     [self forgetPswRequest];
                                     
                                     // отправка запроса на контроллер регистрации:
                                     DrugstoreDesk *deskObj = [[DrugstoreDesk alloc] init];
                                     deskObj.delegate = self;
                                     NSError *error;
                                     NSLog(@"_loginHolder.text: %@", _loginHolder.text);
                                     NSDictionary *mailToJSON = [NSDictionary dictionaryWithObjectsAndKeys: _loginHolder.text, @"email", nil];
                                     //                                     NSMutableArray *mail_psw2BeJSON = [[NSMutableArray alloc] initWithObjects:mailToJSON, nil];
                                     NSData *jsonData = [NSJSONSerialization dataWithJSONObject:mailToJSON options:0 error:&error];
                                     NSLog(@"show error: %@", error);
                                     [deskObj requestTheDrugstoreDeskServer:kForgetKeyURL JSONData:jsonData];
                                     
                                     //                                     NSURL *mailtoURL = [NSURL URLWithString:@"mailto:"];
                                     //                                     [[UIApplication sharedApplication] openURL:mailtoURL];
                                     // :END

                                 }];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"Отменить"
                                   style:UIAlertActionStyleDestructive
                                   handler:^(UIAlertAction * action) {
                                       //                                       [self dismissViewControllerAnimated:YES completion:nil];
                                       
                                   }];
    [authController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = NSLocalizedString(@"Введите адрес почты(email):", @"Login");
    }];
    
    [authController addAction:authAction];
    [authController addAction:cancelAction];
    
    [self presentViewController:authController animated:YES completion:nil];
}

- (void) showSmplAlert:(NSString *) title msg:(NSString *)msg actionText:(NSString *)actionText {
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

- (void) showGoToApothecaryAlert:(NSString *) title msg:(NSString *)msg actionText:(NSString *)actionText {
    UIAlertController *myAlertController = [UIAlertController alertControllerWithTitle:title
                                                                               message:msg
                                                                        preferredStyle:UIAlertControllerStyleAlert                   ];
    UIAlertAction *alertView = [UIAlertAction
                                actionWithTitle:actionText
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    
                                    UINavigationController *navig = [[((UITabBarController *)self.parentViewController.tabBarController) viewControllers] objectAtIndex:2];
                                    ApothecariesListController *apoth = (ApothecariesListController *) navig.viewControllers[0];
//                                    NSLog(@"the class: %@", apoth);
                                    
                                    apoth.preorderHasSent = YES;
//                                    NSLog(@"preorderHasSent from userAccount: %d", apoth.preorderHasSent);
                                    [self.parentViewController.tabBarController setSelectedIndex:2]; // переход в "Аптеки"
                                }];
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"Закрыть (X)"
                                   style:UIAlertActionStyleDestructive
                                   handler:^(UIAlertAction * action) {
                                       
                                       
                                   }];
    [myAlertController addAction:alertView];
    [myAlertController addAction:cancelAction];
    [self presentViewController:myAlertController animated:YES completion:nil];
}


- (void) sendDrugstoresData:(NSData *)jsonData {
    DrugstoreDesk *deskObj = [[DrugstoreDesk alloc] init];
    deskObj.delegate = self;
    [deskObj requestTheDrugstoreDeskServer:kSendingDrugstoresData JSONData:jsonData];
}

// Получение списка препаратов с ценами и наличием 
- (void) readDrugstoresData:(NSData *)jsonData {
    DrugstoreDesk *deskObj = [[DrugstoreDesk alloc] init];
    deskObj.delegate = self;
    [deskObj requestTheDrugstoreDeskServer:kReadingDrugstoresData JSONData:jsonData];
}

// Подтверждение заказа клиентом
- (void) approveTheOrder:(NSData *)jsonData {
    DrugstoreDesk *deskObj = [[DrugstoreDesk alloc] init];
    deskObj.delegate = self;
    [deskObj requestTheDrugstoreDeskServer:kOrder JSONData:jsonData];
}

// ПРОВЕРКА ПОЛЕЙ ДАННЫХ
- (bool) isEmptyLoginPassword {
    if (((loginHolder.text == nil) || ([loginHolder.text isEqualToString:@""])) &&
        ((passwordHolder.text == nil) || ([passwordHolder.text isEqualToString:@""]))) {
        return YES;
    } else return NO;
}

- (bool) isEmptyLogin {
    if (((loginHolder.text == nil) || ([loginHolder.text isEqualToString:@""])) &&
        (passwordHolder.text != nil) && (![passwordHolder.text isEqualToString:@""])) {
        return YES;
    } else return NO;
}

- (bool) isEmptyPassword {
    if ((loginHolder.text != nil) && (![loginHolder.text isEqualToString:@""]) &&
        ((passwordHolder.text == nil) || ([passwordHolder.text isEqualToString:@""]))) {
        return YES;
    } else return NO;
}

- (void) checkEmptinessOfFields {
    if ([self isEmptyLoginPassword]) {
        [self showSmplAlert:@"Пустые поля:" msg:@"E-mail и пароль" actionText:@"OK"];
    } else if ([self isEmptyLogin]) {
        [self showSmplAlert:@"Пустое поле:" msg:@"E-mail" actionText:@"OK"];
    } else if ([self isEmptyLoginPassword]) {
        [self showSmplAlert:@"Пустое поле:" msg:@"Пароль" actionText:@"OK"];
    }
}
// :END ПРОВЕРКА ПОЛЕЙ ДАННЫХ

- (void) enterAccountRequest {
    [self checkEmptinessOfFields]; // ПРОВЕРКА ПОЛЕЙ ДАННЫХ
}

- (void) forgetPswRequest {
    
}

- (void) authorizeRequest {
    
}

//-(void) returnJSONResponse:(NSMutableDictionary *)jsonData {
//    NSLog(@">>> from UserAccount %@ <<<", jsonData);
//    NSString *readResponse = [jsonData valueForKey:@"result"];
//    NSLog(@"readResponse: %@", readResponse);
//    if ([readResponse isEqualToString:@"0"]) {
//        // сообщение, что такого пользователя не существует или допущена ошибка в логине/пароле
//        [self showSmplAlert:@"Такого пользователя не существует" msg:@"или допущена ошибка в логине/пароле" actionText:@"Попробовать еще раз"];
//    } else {
//        [self showSmplAlert:@"Отлично !" msg:@"Ваш аккаунт активирован !" actionText:@"OK"];
//    }
//}

- (NSString *)dataFilePath:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
                                                         NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:fileName];
}

- (NSArray *)getContentOfPlist:(NSString *)fName {
    NSString *filePath = [self dataFilePath:fName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSArray *array = [[NSArray alloc] initWithContentsOfFile:filePath];
        NSLog(@"ARRAY from the plist: %@", array);
        return array;
    } else {
        return nil;
    }
}


// Проверка - сохранены ли у пользователя данные по аккаунту
- (void) checkIfAccountCredentialsAreInPlist {
    NSArray *someCrdntl = [[NSArray alloc] initWithArray:[self getContentOfPlist:kUserCredent]];
    NSUInteger counter = [someCrdntl count];
    if (counter <= 0) {
        userHasEnteredAccount = NO;
    } else {
        userHasEnteredAccount = YES;
    }
    NSLog(@"someCrdntl: %@", someCrdntl);
}


- (void) returnJSONResponse:(NSMutableDictionary *)jsonData {
    // at present is using the ArticleController "returnJSONResponse"
//    NSLog(@"data from the UserAccount: %@", jsonData);
}


@end
