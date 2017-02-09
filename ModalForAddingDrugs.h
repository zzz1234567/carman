//
//  ModalForAddingDrugs.h
//  Навигатор лекарств
//
//  Created by Zzz on 30.03.16.
//  Copyright © 2016 Zzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"

@interface ModalForAddingDrugs: UIViewController
@property (weak, nonatomic) IBOutlet UIView *popUpView;

- (void)showInView:(UIView *)aView animated:(BOOL)animated;

@end
