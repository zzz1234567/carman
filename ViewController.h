//
//  ViewController.h
//  Recipe 7-1:  Showing a Map with the Current Locaiton
//
//  Created by joseph hoffman on 8/10/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <QuartzCore/QuartzCore.h>
//#import "TreeNode.h"
//#import "XMLParser.h"
#import "AppDetails.h"
//#import "RootViewController.h"
#import "NSString+HTML.h"
#import "OwnHttpReader.h"
#import "MyAnnotation.h"

@interface ViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate, UITabBarControllerDelegate, UITabBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, OwnHttpReaderDelegate> {
    IBOutlet MKMapView *mapView;
    IBOutlet UILabel *userLocationLabel;
    IBOutlet UIToolbar *mapToolbar;
//    IBOutlet UITableView *drugstoresListTblView;
    IBOutlet UICollectionView *drugstoresCollection;
    
    CLLocationManager *locationManager;
    MKUserTrackingBarButtonItem *trackingButton;
    UIBarButtonItem *flexibleSpace;
    UIBarButtonItem *listItem;
    UIBarButtonItem *mapItem;
    UIWebView *currentWebView;
//    NSMutableArray *drugstoreArray;
//    NSMutableArray *innerArray;
    NSString *EAN;
    NSMutableString *nomenid;
    NSMutableString *ean;
    NSMutableString *tnname;
    NSString *element;
    NSMutableString *elementMutable;
    NSString *curCaption;
    NSString *curCount;
//    NSMutableDictionary *rec;
    
    AppDetails *appNSObjectDetails;
    //    RootViewController *rvc;
    
//    NSMutableArray *mapDataHolder;
}


@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UILabel *userLocationLabel;

@property (strong, nonatomic) IBOutlet UIToolbar *mapToolbar;

@property (strong, nonatomic) CLLocationManager *locationManager;

@property (strong, nonatomic) MKUserTrackingBarButtonItem *trackingButton;
@property (strong, nonatomic) UIBarButtonItem *flexibleSpace;
@property (strong, nonatomic) UIBarButtonItem *listItem;
@property (strong, nonatomic) UIBarButtonItem *mapItem;

//@property (strong, nonatomic) IBOutlet UITableView *drugstoresListTblView;

@property (strong, nonatomic) UIWebView *currentWebView;
@property (retain, nonatomic) IBOutlet UIButton *makeCallBtn;
@property (weak, nonatomic) NSMutableArray *drugstoreArray;
@property (weak, nonatomic) NSMutableArray *innerArray;
@property (nonatomic, retain) NSString *EAN;

@property (nonatomic, retain) AppDetails *appNSObjectDetails;

//@property (nonatomic, retain) RootViewController *rvc;
@property (nonatomic, weak) NSMutableDictionary *rec;
@property (weak, nonatomic) IBOutlet UIPanGestureRecognizer *PanTheDrugstore;

//- (void) showMapIcon;
//- (void) showListIcon;
//- (void) hideMapIcon;

- (IBAction) makeAcall:(id)sender;
//- (void)mapSetDrugstores;
@property (nonatomic, weak) NSMutableArray *mapDataHolder;
//@property (nonatomic, retain) IBOutlet UIImageView *scrollViewImage;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBarOwn;

-(IBAction)moveViewWithPanGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer;

-(void)panMiddlePosition:(UIPanGestureRecognizer *)sender;
-(void)moveToTheMiddle:(UICollectionView *)drgstrCln;
-(void)moveToTheBottom:(UICollectionView *)drgstrCln;
-(void)moveToTheTop:(UICollectionView *)drgstrCln;


@property(nonatomic) NSInteger topTouchesCounter;
@property(nonatomic) NSInteger bottomTouchesCounter;

@property(nonatomic, weak) IBOutlet UIImageView *imgAsBG;
@property(nonatomic, weak) IBOutlet UICollectionView *drugstoresCollection;
@property(nonatomic, weak) IBOutlet UICollectionViewCell *curCell;
@property (nonatomic) NSMutableArray *xmlLocalDataHolder;
@property (weak, nonatomic) IBOutlet UILabel *Name;
@property (weak, nonatomic) IBOutlet UILabel *Address;
@property (weak, nonatomic) IBOutlet UILabel *Hours;
@property (weak, nonatomic) IBOutlet UILabel *Phone;
@property (weak, nonatomic) IBOutlet UILabel *Site;
@property (weak, nonatomic) IBOutlet UIImageView *ImageOfPlace;
@property (weak, nonatomic) IBOutlet UIView *collCellHeader;
@property (strong, nonatomic) MyAnnotation *annotation;

@property (nonatomic) NSInteger collectionView_sections_counter;


@end
