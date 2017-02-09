//
//  ArticleController.h
//  NewsApp
//
//  Created by Zzz on 15.02.16.
//  Copyright © 2016 Zzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MedicinesPreOrderCell.h"
#import "ViewController.h"
#import "HomeController.h"
#import "DrugstoreDesk.h"
#import <CoreLocation/CoreLocation.h>
#import "UserAccount.h"

//@protocol ArticleControllerDelegate <NSObject>
//- (void)showMapDelegation;
//@end

@interface ArticleController : UserAccount <MedicinesPreOrderCellDelegate, DrugstoreDeskDelegate, CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
    CLLocationDegrees longitudeHolder;
    CLLocationDegrees latitudeHolder;
}


//@property (strong, nonatomic) IBOutlet UIButton *askPriceBtn;

//@property (nonatomic, weak) id <ArticleControllerDelegate> delegate;

@property (nonatomic, strong) NSArray *medicinesTNList;
@property (nonatomic,weak) MedicinesPreOrderCell *currentCell;
@property (weak, nonatomic) IBOutlet UITableView *articleTbl;
@property (nonatomic) BOOL approvedDeleting;
@property (weak, nonatomic) IBOutlet UIButton *findDrugstore;
@property (weak, nonatomic) IBOutlet UIButton *askThePriceBtn;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic) CLLocationDegrees longitudeHolder;
@property (nonatomic) CLLocationDegrees latitudeHolder;

//@property (nonatomic, weak) ViewController *parentObject;

- (IBAction)previousView:(id)sender;
- (IBAction)price_availability:(id)sender;

@end
