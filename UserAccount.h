//
//  UserAccount.h
//  Навигатор лекарств
//
//  Created by Zzz on 11.05.16.
//  Copyright © 2016 Zzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "DrugstoreDesk.h"


@interface UserAccount : UIViewController <DrugstoreDeskDelegate> {
    UITextField *loginHolder;
    UITextField *passwordHolder;
    BOOL userHasEnteredAccount;    
}

@property (nonatomic, weak) UITextField *loginHolder;
@property (nonatomic, weak) UITextField *passwordHolder;
@property (nonatomic) BOOL userHasEnteredAccount;

- (void) checkEmptinessOfFields;
- (void) showSmplAlert:(NSString *) title msg:(NSString *)msg actionText:(NSString *)actionText;
- (void) showGoToApothecaryAlert:(NSString *) title msg:(NSString *)msg actionText:(NSString *)actionText;
- (void) showAccountMessage;
- (void) authorizeMessage;
- (void) forgetPsw;
- (void) forgetPswRequest;
- (void) enterAccountRequest;
- (void) authorizeRequest;
- (void) sendDrugstoresData:(NSData *)jsonData;
- (void) readDrugstoresData:(NSData *)jsonData;
- (void) approveTheOrder:(NSData *)jsonData;
- (void) checkIfAccountCredentialsAreInPlist;
- (NSString *)dataFilePath:(NSString *)fileName;
- (NSArray *)getContentOfPlist:(NSString *)fName;

@end
