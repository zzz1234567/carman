///Users/josephhoffman/Google Drive/iOS 7 Book/iOS 7 Book Chapter folders/CH7 - Map Recipes/projects/Recipe 7-1:  Showing a Map with the Current Locaiton/Recipe 7-1:  Showing a Map with the Current Locaiton.xcodeproj
//  ViewController.m
//  Recipe 7-1:  Showing a Map with the Current Locaiton
//
//  Created by joseph hoffman on 8/10/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import "ViewController.h"
#import "MyAnnotation.h"
#import "MyAnnotationView.h"
#import "DetailedViewController.h"
//#import "CRGradientNavigationBar.h"

#define UIColorFromRGB(rgbValue)[UIColor colorWithRed:((float)((rgbValue&0xFF0000)>>16))/255.0 green:((float)((rgbValue&0xFF00)>>8))/255.0 blue:((float)(rgbValue&0xFF))/255.0 alpha:1.0]
#define HEXFromUIColor(color)[NSString stringWithFormat:@"#%02lX%02lX%02lX", lroundf(CGColorGetComponents(color.CGColor)[0] * 255),lroundf(CGColorGetComponents(color.CGColor)[1] * 255), lroundf(CGColorGetComponents(color.CGColor)[2] * 255)]
#define METERS_PER_MILE 1609.344
#define HEX_LIGHT_GREEN_COLOR @"#89d03f"
#define HEX_BLUE_OPAQUE_COLOR @"#478bda"
#define LIGHT_GREEN_COLOR [UIColor colorWithRed:0.537 green:0.816 blue:0.247 alpha:1]; /*#89d03f*/
#define LIGHT_BLUE_OPAQUE_COLOR [UIColor colorWithRed:0.278 green:0.545 blue:0.855 alpha:0.8]; /*478bda*/

#define kApothecary_forMap @"drugstoresList.plist"

@interface ViewController () {
    float firstX;
    float firstY;
    
    float canvasTopY;
    float canvasBottomY;
    float CollectionViewHeaderBottomY;
    float diffCollectionView_headerView;
    
    int length_drugstore;
    
}

@end

@implementation ViewController
@synthesize locationManager;

@synthesize trackingButton;
@synthesize flexibleSpace;
@synthesize listItem;
@synthesize mapItem;
//@synthesize drugstoresListTblView;
@synthesize mapToolbar;
@synthesize userLocationLabel;
@synthesize currentWebView;
@synthesize mapView;
//@synthesize makeCallBtn;
@synthesize drugstoreArray;
@synthesize EAN;
@synthesize appNSObjectDetails;
//@synthesize rvc;
@synthesize rec;
@synthesize innerArray;
@synthesize mapDataHolder;
@synthesize searchBarOwn;

@synthesize topTouchesCounter;
@synthesize bottomTouchesCounter;
@synthesize drugstoresCollection = _drugstoresCollection;
@synthesize curCell = _curCell;
@synthesize imgAsBG = _imgAsBG;
@synthesize xmlLocalDataHolder = _xmlLocalDataHolder;

@synthesize Name;
@synthesize Phone;
@synthesize Address;
@synthesize Site;
@synthesize ImageOfPlace;
@synthesize Hours;

@synthesize collCellHeader;

//@synthesize annotation = _annotation;
//
//- (MyAnnotation *)annotation {
//    return _annotation;
//}


- (NSMutableArray *)xmlLocalDataHolder {
//    if (!_xmlLocalDataHolder) {
//        _xmlLocalDataHolder = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:tradenamesFile ofType:@"plist"]];
//    }
    return _xmlLocalDataHolder;
}

-(UIImageView *)imgAsBG {
    return _imgAsBG;
}

-(UICollectionViewCell *)curCell {
    return _curCell;
}

-(UICollectionView *)drugstoresCollection {
    return _drugstoresCollection;
}


//@synthesize scrollViewImage = _scrollViewImage;
//
//- (UIImageView *) scrollViewImage {
//    return _scrollViewImage;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    if ([self connectExternalDrugstore]) {
//        [_drugstoresCollection setDataSource:self];
//        [_drugstoresCollection setDelegate:self];
//    }
    

//    UIColor *lightNavyColor = [UIColor colorWithRed:0.278 green:0.545 blue:0.855 alpha:1];
//    UIColor *lightNavyColorOpaque = [UIColor colorWithRed:0.278 green:0.545 blue:0.855 alpha:0.8];
    [self.searchBarOwn setImage:[UIImage imageNamed: @"Search-44.png"]
               forSearchBarIcon:UISearchBarIconSearch
                          state:UIControlStateNormal];
    self.searchBarOwn.layer.borderWidth = 1;
    self.searchBarOwn.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    // Замена цвета для кнопки "Отмена"
//    UIView *view = [self.searchBarOwn.subviews objectAtIndex:0];
//    for (UIView *subView in view.subviews) {
//        if ([subView isKindOfClass:[UIButton class]]) {
//            UIButton *cancelButton = (UIButton *)subView;
//            [cancelButton setTitleColor:lightNavyColorOpaque forState:UIControlStateNormal];
//            [cancelButton setTitleColor:lightNavyColor forState:UIControlStateHighlighted];
//        }
//    }
    //
    
//    [_drugstoresCollection reloadData];
   
    // Константы для верхней точки
    diffCollectionView_headerView = 25.0f;
    
    canvasTopY = _imgAsBG.frame.origin.y - diffCollectionView_headerView;
    UIScreen *someScreen = [UIScreen mainScreen];
    canvasBottomY = someScreen.applicationFrame.origin.y + someScreen.applicationFrame.size.height - _drugstoresCollection.frame.size.height;
//    diffCollectionView_headerView = _drugstoresCollection.frame.origin.y + someView.frame.origin.y;
    
    
    
    // :END
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
    NSLog(@"the view disappeared\n");
//    [self hideMapIcon];
}

- (BOOL) connectExternalDrugstore {
    // ПОДКЛЮЧЕНИЕ К ГЛОБАЛЬНОМУ КЛАССУ для отображения ближайшей аптеки
    OwnHttpReader *httpObj = [[OwnHttpReader alloc] init];
    httpObj.delegate = self;
    NSString *rlsQueryMainPart_Drugstore = @"http://www.kuznetsov.rlsnet.lan/rlsserv_pricesbyregion.htm";
    NSString *urlWithEAN_drugstore = [[NSString alloc] initWithFormat:@"%@", rlsQueryMainPart_Drugstore];
    
    NSLog(@"urlWithEAN_drugstore: %@", urlWithEAN_drugstore);
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [httpObj checkXML:urlWithEAN_drugstore tbl:nil];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"counter from collectionView %d", (int) collectionView_sections_counter);
//        });
//    });
    
    
    // :END
    return YES;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    NSLog(@"will appeared collection");
    
    //    if (self.makeCallBtn) {
    //        self.makeCallBtn.titleLabel.text = @"9254310011";
    //    }
    
    //    [self.drugstoresListTblView reloadData];
    
    //    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    [self connectExternalDrugstore];
    //        dispatch_async(dispatch_get_main_queue(), ^{
    NSLog(@"counter from collectionView %lu", (long)self.collectionView_sections_counter);
    //        });
    //    });
    
//    NSLog(@"self.xmlLocalDataHolderself.xmlLocalDataHolder: %lu", (long)self.collectionView_sections_counter);
    
    UIPanGestureRecognizer *tapRecognizer = [[UIPanGestureRecognizer alloc]
                                             initWithTarget:self action:@selector(panMiddlePosition:)];
    UITapGestureRecognizer *doubleTapFolderGesture = [[UITapGestureRecognizer alloc]
                                                      initWithTarget:self action:@selector(processDoubleTap:)];
    [doubleTapFolderGesture setNumberOfTapsRequired:2];
    
    [self.view addGestureRecognizer:tapRecognizer];
    [self.view addGestureRecognizer:doubleTapFolderGesture];
    
    self.locationManager = [[CLLocationManager alloc] init];
    //    locationManager.delegate = self;
    //    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //    [locationManager startUpdatingLocation];
    //
    //    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone; //whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
    [locationManager requestWhenInUseAuthorization]; // Add This Line
    
    // Set initial region
    //    CLLocationCoordinate2D denverLocation = CLLocationCoordinate2DMake(39.739, 104.984);
    //    self.mapView.region =
    //    MKCoordinateRegionMakeWithDistance(denverLocation, 10000, 10000);
    
    // Optional Controls
    //   self.mapView.zoomEnabled = NO;
    //   self.mapView.scrollEnabled = NO;
    
    //Control User Location on Map
    if ([CLLocationManager locationServicesEnabled]) {
        self.mapView.showsUserLocation = YES;
        [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    }
    
    
//    UITabBarItem *tabBarItem_1 = [[self.tabBarController.tabBar items] objectAtIndex:1];
//    UITabBarItem *tabBarItem = [[self.tabBarController.tabBar items] objectAtIndex:2];
//    self.EAN = [NSString stringWithFormat:@"%07ld%06ld",  (long)tabBarItem_1.tag, (long)tabBarItem.tag];
//    NSLog(@"starting from ViewContr with the EAN: %@", self.EAN);
    
    
    
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    
    // Do any additional setup after loading the view, typically from a nib.
    self.mapView.delegate = self;
    
//    self.drugstoresListTblView.hidden = YES;
    
    // Add button for controlling user location tracking
    self.flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    self.trackingButton = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.mapView];
//    UIView *view = [self.mapToolbar.subviews objectAtIndex:0];
//    for (UIView *subView in view.subviews) {
//        if ([subView isKindOfClass:[UIButton class]]) {
//            UIButton *navigBtn = (UIButton *)subView;
//            navigBtn.layer.borderWidth = 1;
//            navigBtn.layer.borderColor = [[UIColor whiteColor] CGColor];
//            self.trackingButton = [[MKUserTrackingBarButtonItem alloc] initWithCustomView:navigBtn];
//        }
//    }
    self.mapToolbar.layer.borderWidth = 1;
    self.mapToolbar.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.mapToolbar.barStyle = UIBarButtonItemStylePlain;
    self.trackingButton.style = UIBarButtonItemStylePlain;
    
//    self.listItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"List-25.png"] style:UIBarButtonItemStylePlain  target:nil action:@selector(showListIcon)];
//    self.mapItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Map-25.png"] style:UIBarButtonItemStylePlain  target:nil action:@selector(showMapIcon)];
    
    //    UIImage *image = [[UIImage imageNamed:@"description.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //    UIBarButtonItem *descrItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:nil];
    
    [self.mapToolbar setItems: [NSArray arrayWithObjects:self.trackingButton, nil] ];
//    self.mapToolbar.barStyle = -1;
    
    //    [self.navigationController.toolbar setItems:[NSArray arrayWithObjects:self.trackingButton, self.flexibleSpace, self.listItem, nil]];
    //    self.navigationController.toolbar.barStyle = -1;
    
    
    
    //    NSArray *tmparray =  [NSArray arrayWithObjects:@"", @"", @"", @"", @"", trackingButton];
    
    //    self.navigationItem.rightBarButtonItem =
    //   [[UIBarButtonItem alloc]
    //      initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
    //      target:self
    //      action:nil];
    
    //    MKPointAnnotation *annotation1 = [[MKPointAnnotation alloc] init];
    //    annotation1.title = @"Аптека WER.ru";
    //    annotation1.subtitle = @"WER.ru";
    //    annotation1.coordinate = CLLocationCoordinate2DMake(55.7861, 37.6356);
    //    [self.mapView addAnnotation:annotation1];
    
    //    [self.drugstoresListTblView reloadData];
    
    
    // Create and initialize a search request object.
//    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
//    request.naturalLanguageQuery = @"lk;jlkjmklm.,m";
//    request.region = mapView.region;
//    // Create and initialize a search object.
//    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
//    // Start the search and display the results as annotations on the map.
//    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error)
//    {
//        NSMutableArray *placemarks = [NSMutableArray array];
//        for (MKMapItem *item in response.mapItems) {
//            [placemarks addObject:item.placemark];
//        }
//        [self.mapView removeAnnotations:[self.mapView annotations]];
//        [self.mapView showAnnotations:placemarks animated:NO];
//    }];
    
    
    
//    if(IOS_7) {
//        self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
//        self.searchBar.backgroundImage = [UIImage imageWithColor:[UIColor redColor] cornerRadius:5.0f];
//    }
    
    
    
}

// Delegated method
- (void)returnHTTPResponse:(NSMutableArray *)xmlData {
    // Если xmlData != nil, то length_drugstore > 0
    if (xmlData && [xmlData count] > 0) {
        length_drugstore = 1;
    }
    self.collectionView_sections_counter = [xmlData count];
    _xmlLocalDataHolder = xmlData;
    NSLog(@"length_drugstore: %d The xml data : %@", (int) length_drugstore, _xmlLocalDataHolder);
    if (length_drugstore > 0) {
        
        // запись данных об аптеках в plist-файл
        [self saveDrugstoresIntoPlist];
        // :END
        
        NSMutableArray *annotations = [[NSMutableArray alloc] init];
        
        //        NSString *str4 = [str3 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        //        NSMutableString *mString = [ap returnTnname:str4];
        NSString *mString = @"ertyuiol;lkjhgfdxcv bnm,.lkjhgfdsrtghnm,";
        self.navigationItem.title = [mString stringByConvertingHTMLToPlainText];
        
        for (NSMutableArray *drugstoreData in _xmlLocalDataHolder) {
            NSLog(@"data passed %@\n", drugstoreData);
            double lonValue = [[drugstoreData valueForKey:@"lon"] doubleValue];
            double latValue = [[drugstoreData valueForKey:@"lat"] doubleValue];
            //            MyAnnotation *ann1 = [[MyAnnotation alloc]
            //                                  initWithCoordinate:CLLocationCoordinate2DMake(latValue, lonValue)
            //                                  prepName: [mString stringByConvertingHTMLToPlainText]
            //                                  title: [NSString stringWithFormat:@"%@", [[drugstoreData valueForKey:@"name"] objectAtIndex:0]]
            //                                  subtitle:[NSString stringWithFormat:@"Цена: %@руб", [[drugstoreData valueForKey:@"price"] objectAtIndex:0 ] ]
            //                                  contactInformation:[NSString stringWithFormat:@"Телефон: %@", [[drugstoreData valueForKey:@"tel"] objectAtIndex:0]]
            //                                  companyAddress:[NSString stringWithFormat:@"%@", [[drugstoreData valueForKey:@"address"] objectAtIndex:0]]
            //                                  companyUrl:[NSString stringWithFormat:@"%@", [[drugstoreData valueForKey:@"url"] objectAtIndex:0]]
            //                                  hours:[NSString stringWithFormat:@"Часы работы: %@", [[drugstoreData valueForKey:@"hours"] objectAtIndex:0]]
            //                                  medicineImage:[NSString stringWithFormat:@"%@", [[drugstoreData valueForKey:@"medicineImage"] objectAtIndex:1]]];
            //            [annotations addObject:ann1];
            MyAnnotation *ann1 = [[MyAnnotation alloc]
                                  initWithCoordinate:CLLocationCoordinate2DMake(latValue, lonValue)
                                  prepName: [mString stringByConvertingHTMLToPlainText]
                                  title: [NSString stringWithFormat:@"%@", [drugstoreData valueForKey:@"name"]]
                                  contactInformation:[NSString stringWithFormat:@"Телефон: %@", [drugstoreData valueForKey:@"tel"]]
                                  companyAddress:[NSString stringWithFormat:@"%@", [drugstoreData valueForKey:@"address"]]
                                  companyUrl:[NSString stringWithFormat:@"%@", [drugstoreData valueForKey:@"url"]]
                                  hours:[NSString stringWithFormat:@"Часы работы: %@", [drugstoreData valueForKey:@"hours"]]
                                  indexId:[_xmlLocalDataHolder indexOfObject:drugstoreData]]; // просто индекс массива
            //                    NSLog(@"ann1: %@", ann1);
            [annotations addObject:ann1];
        }
        //        [self.mapView removeAnnotations:annotations];
        [self.mapView addAnnotations:annotations];
        
        [_drugstoresCollection setDataSource:self];
        [_drugstoresCollection setDelegate:self];
        [_drugstoresCollection reloadData];
        
    }
    else {
        NSLog(@"Ошибка получения данных в ПОДКЛЮЧЕНИЕ К ГЛОБАЛЬНОМУ КЛАССУ для отображения ближайшей аптеки");
    }
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

- (NSString *)dataFilePath:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
                                                         NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:fileName];
}

- (void) saveDrugstoresIntoPlist {
    // 5) Сохранение ВСЕХ аптек в plist-файл
    // обнуление файла kApothecary
    NSMutableArray *emptyArray = [[NSMutableArray alloc] init];
    [emptyArray writeToFile:[self dataFilePath:kApothecary_forMap] atomically:YES];
    // :END
    
    // запись данных от аптек
    [_xmlLocalDataHolder writeToFile:[self dataFilePath:kApothecary_forMap] atomically:YES];
    // :END
}


- (IBAction) makeAcall:(id)sender {
    UIButton *btn = (UIButton *)sender;
    NSString *phoneNumber = btn.titleLabel.text;
    //    NSString *phoneNumber = @"88002003168";
    
    
    //    NSURL *phoneUrl = [NSURL URLWithString:[@"facetime://" stringByAppendingString:phoneNumber]];
    //    NSURL *phoneFallbackUrl = [NSURL URLWithString:[@"tel://" stringByAppendingString:phoneNumber]];
    
    // @todo Change to the above
    phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"facetime number:%@ \n", phoneNumber);
    NSURL *phoneUrl = [NSURL URLWithString:[@"facetime://" stringByAppendingString:phoneNumber]];
    NSURL *phoneFallbackUrl = [NSURL URLWithString:[@"facetime://" stringByAppendingString:phoneNumber]];
    
    if ([UIApplication.sharedApplication canOpenURL:phoneUrl]) {
        [UIApplication.sharedApplication openURL:phoneUrl];
    } else if ([UIApplication.sharedApplication canOpenURL:phoneFallbackUrl]) {
        [UIApplication.sharedApplication openURL:phoneFallbackUrl];
    } else {
        // Show an error message: Your device can not do phone calls.
        NSLog(@"The device doesn't support phone calling");
    }
    
    
}

/*
- (void) showListIcon {
    // Animate the table view reload
    NSLog(@"showListIcon clicked");
    [UIView transitionWithView:self.drugstoresListTblView
                      duration:0.35f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^(void) {
                        [self.drugstoresListTblView reloadData];
                        self.drugstoresListTblView.hidden = NO;
                    }
                    completion:nil];
    
    
    [self.mapToolbar setItems: [NSArray arrayWithObjects:self.trackingButton, nil]];
    self.mapToolbar.barStyle = -1;
}
*/

/*
- (void) showMapIcon {
    // Animate the table view reload
    NSLog(@"showMapIcon clicked");
    [UIView transitionWithView:self.drugstoresListTblView
                      duration:0.35f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^(void) {
                        [self.drugstoresListTblView reloadData];
                        self.drugstoresListTblView.hidden = YES;
                    }
                    completion:nil];
    
    
    [self.mapToolbar setItems: [NSArray arrayWithObjects:self.trackingButton, self.flexibleSpace, self.listItem, nil]];
    self.mapToolbar.barStyle = -1;
}
*/

/*
- (void) hideMapIcon {
    // Animate the table view reload
    NSLog(@"HideMapIcon clicked");
    [UIView transitionWithView:self.drugstoresListTblView
                      duration:0.35f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^(void) {
                        [self.drugstoresListTblView reloadData];
                        self.drugstoresListTblView.hidden = YES;
                    }
                    completion:nil];
    
    [self.mapToolbar setItems: [NSArray arrayWithObjects:self.trackingButton, self.flexibleSpace, self.listItem, nil]];
    self.mapToolbar.barStyle = -1;
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - delegate methods

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    self.userLocationLabel.text =
    [NSString stringWithFormat:@"Location: %.5f°, %.5f°",
     userLocation.coordinate.latitude, userLocation.coordinate.longitude];
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)aView {
    NSLog(@"view selected");
}

//- (void)locationManager:(CLLocationManager *)manager
//       didFailWithError:(NSError *)error {
//    NSString *errorType = (error.code == kCLErrorDenied) ?
//    @"Нет доступа" : @"Неизвестная ошибка";
//    UIAlertView *alert = [[UIAlertView alloc]
//                          initWithTitle:@"Ошибка определения местоположения"
//                          message:errorType
//                          delegate:nil
//                          cancelButtonTitle:@"Ok"
//                          otherButtonTitles:nil];
//    [alert show];
//}

// При повторном открытии - та же картинка
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    // Don't create annotation views for the user location annotation
    if ([annotation isKindOfClass:[MyAnnotation class]]) {
        static NSString *myAnnotationId = @"myAnnotation";
        
        MyAnnotationView *annotationView =
        (MyAnnotationView *)[self.mapView
                             dequeueReusableAnnotationViewWithIdentifier:myAnnotationId];
                if(annotationView) {
                    annotationView.annotation = annotation;
                }
                else {
                    annotationView = [[MyAnnotationView alloc] initWithAnnotation:annotation
                                                      reuseIdentifier:myAnnotationId];
                }
        
        
        
        return annotationView;
    }
    // Use a default annotation view for the user location annotation
    return nil;
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    // Подключение вида для аннотации по конкретной аптеке (отключено 19.04.16)
//    DetailedViewController *dvc = [[DetailedViewController alloc]
//                                   initWithAnnotation:view.annotation];
//    dvc.modalTransitionStyle = UIModalTransitionStylePartialCurl;
//    [self.navigationController pushViewController:dvc animated:YES];
    // :END
    
    
    self.annotation = view.annotation;
    NSLog(@"Здесь: анимация для UICollectionView; drugstoreid: %lu", (unsigned long) self.annotation.indexId);
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.annotation.indexId inSection:0];
    
//    dispatch_async(dispatch_get_main_queue(), ^{
    
        [_drugstoresCollection scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
//    });
//    [self.drugstoresCollection reloadData];
    
    
    
}


//- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
//    NSLog(@"\nStarted the map changes\n");
//}


//- (void)mapSetDrugstores {
//    rec = [NSMutableDictionary dictionary];
//    NSString *string4url = [[NSString alloc] initWithFormat:@"http://www.rlsnet.ru/rlsserv_pricesbyean.htm?ean=%@", self.EAN];
//    TreeNode *root = [[XMLParser sharedInstance] parseXMLFromURL:[NSURL URLWithString:string4url]];
//    NSLog(@"root counter: %d \n", (int) [root.children count]);
//    int length = (int) [root.children count];
//    if (0 < length) {
//        NSLog(@"leaves %@ \n", [root.children objectAtIndex:0]);
//        for (int i = 0; i < length; i++) {
//            NSLog(@"here: %@ \n", [root.children objectAtIndex:0]);
//            TreeNode *recElement = [root.children objectAtIndex:0];
//            int leastLength = (int) [recElement.children count];
//            for (int j = 0; j < leastLength; j++) {
//                innerArray = [[NSMutableArray alloc] init];
//                TreeNode *leastElement = [recElement.children objectAtIndex:j];
//                if (nil != leastElement.leafvalue &&
//                    ![leastElement.leafvalue isEqualToString:@""]) {
//                    [rec setObject:leastElement.leafvalue forKey:leastElement.key];
//                    [innerArray addObject:rec];
//                }
//            }
//            [self.drugstoreArray addObject:innerArray];
//        }
//    }
//}


/*
#pragma mark -
#pragma mark Table View Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    int ret = 0;
    ret = (int) [self.drugstoreArray count];
    return ret;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    static NSString *CellIdentifier = @"DrugstoreCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
        //        self.makeCallBtn = (UIButton *)[cell viewWithTag:220];
        //        self.makeCallBtn.titleLabel.text = @"9254310011";
        
        //        cell.textLabel.text = [NSString stringWithFormat:@"Cell %d", 0];
        
        //        [(UIButton *)[cell viewWithTag:220] setTitle:@"..." forState:UIControlStateNormal];
    }
    //    else {
    
    
    if (0 < [self.drugstoreArray count]) {
        UIButton *btn = (UIButton *)[cell.contentView viewWithTag:220];
        UIButton *tel = (UIButton *)[cell.contentView viewWithTag:221];
        NSString *telephones = [[[self.drugstoreArray objectAtIndex:row] valueForKey:@"tel"] objectAtIndex:0];
        NSLog(@"\n telepones: %@ \n ", telephones);
        NSArray *telItems = [telephones componentsSeparatedByString:@"\n"];
        
        if ([telItems count] > 1) {
            [btn setTitle:[NSString stringWithFormat:@"%@", [[telItems objectAtIndex:0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]] forState:UIControlStateNormal];
            [tel setTitle:[NSString stringWithFormat:@"%@", [[telItems objectAtIndex:1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]] forState:UIControlStateNormal];
        }
        else {
            [btn setTitle:[NSString stringWithFormat:@"%@", [[[self.drugstoreArray objectAtIndex:row] valueForKey:@"tel"] objectAtIndex:0]] forState:UIControlStateNormal];
        }
        
        btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        btn.layer.borderWidth = 1.0;
        btn.layer.cornerRadius = 10;
        [btn.layer setShadowOffset:CGSizeMake(2, 2)];
        [btn.layer setShadowColor:[[UIColor blackColor] CGColor]];
        [btn.layer setShadowOpacity:0.5];
        
        tel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        tel.layer.borderWidth = 1.0;
        tel.layer.cornerRadius = 10;
        [tel.layer setShadowOffset:CGSizeMake(2, 2)];
        [tel.layer setShadowColor:[[UIColor blackColor] CGColor]];
        [tel.layer setShadowOpacity:0.5];
        
        UILabel *shopName = (UILabel *)[cell.contentView viewWithTag:1];
        [shopName setText:[[[self.drugstoreArray objectAtIndex:row] valueForKey:@"name"] objectAtIndex:0]];
        
        UILabel *productPriceTitle = (UILabel *)[cell.contentView viewWithTag:2];
        [productPriceTitle setText:@"Цена: "];
        
        UILabel *productPrice = (UILabel *)[cell.contentView viewWithTag:3];
        [productPrice setText:[NSString stringWithFormat:@"%@руб", [[[self.drugstoreArray objectAtIndex:row] valueForKey:@"price"] objectAtIndex:0]]];
        
        UITextView *wHours = (UITextView *)[cell.contentView viewWithTag:4];
        [wHours setText:[[[self.drugstoreArray objectAtIndex:row] valueForKey:@"hours"] objectAtIndex:0]];
        
        
        //    UIButton *btn = (UIButton *)[cell viewWithTag:220];
        //    btn.titleLabel.text = @"9254310011";
        
        //    NSLog(@"row: %d", (int)row);
        //
        //    self.makeCallBtn = (UIButton *)[cell viewWithTag:220];
        //    self.makeCallBtn.titleLabel.text = @"9254310011";
        //    UIButton *btn = (UIButton *)[cell viewWithTag:220];
        //    btn.titleLabel.text = @"9254310011";
        
        
        //    if (((int)row % 2) == 0) {
        ////        NSLog(@"row: %d", (int) row);
        //        UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
        //        UIButton *btn = (UIButton *)[cell.contentView viewWithTag:220];
        //        btn.titleLabel.text = @"9254310011";
        //    }
        
        
        // cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0.6 alpha:1];
 */
        /*
         
         _currentWebView = [[UIWebView alloc] initWithFrame:CGRectMake(10.0, 25.0, cell.bounds.size.width - 20.0, cell.bounds.size.height - 20.0)];
         [_currentWebView setTag:315];
         [_currentWebView setUserInteractionEnabled:YES];
         [_currentWebView setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:0.6 alpha:1]];
         [_currentWebView setOpaque:NO];
         NSString *replacedText = [[[[_menu4drugs objectAtIndex:row] allValues] objectAtIndex:row] stringByReplacingOccurrencesOfString:@"\\r" withString:@""];
         NSString *replacedTextDouble = [replacedText stringByReplacingOccurrencesOfString:@"\\n" withString:@""];
         [_currentWebView loadHTMLString:replacedTextDouble baseURL:nil];
         [cell addSubview:_currentWebView];
         
         */
/*
        //    cell.textLabel.text = @"jopa";
        
        //    [_currentWebView removeFromSuperview];
        //    _currentWebView = [[UIWebView alloc] initWithFrame:CGRectMake(10.0, 30.0, cell.bounds.size.width - 20.0, cell.bounds.size.height - 30.0)];
        //    [_currentWebView setTag:row];
        //    [_currentWebView setUserInteractionEnabled:YES];
        //    [_currentWebView setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:0.6 alpha:1]];
        //    [_currentWebView setOpaque:YES];
        //    //  _currentWebView.scalesPageToFit = YES;
        //    //  _currentWebView.delegate = self;
        //    _currentWebView.contentMode = UIViewContentModeScaleToFill;
        //    NSString *basePath = [[NSBundle mainBundle] bundlePath];
        //    [_currentWebView loadHTMLString:@"lk;lk;lk;lk;lk;lk;lk" baseURL:[NSURL fileURLWithPath:basePath]];
        //    [cell addSubview:_currentWebView];
    }
    
    return cell;
}

*/

//- (void)tableView:(UITableView *)tableView
//  willDisplayCell:(UITableViewCell *)cell
//forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (cell) {
//        self.makeCallBtn = (UIButton *)[cell viewWithTag:220];
//        self.makeCallBtn.titleLabel.text = @"9254310011";
//    }
//
//}
/*
#pragma mark -
#pragma mark Table View Delegate Methods
- (NSIndexPath *)tableView:(UITableView *)tableView
  willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    double lonValue = [[[[self.drugstoreArray objectAtIndex:row] valueForKey:@"lon"] objectAtIndex:0] doubleValue];
    double latValue = [[[[self.drugstoreArray objectAtIndex:row] valueForKey:@"lat"] objectAtIndex:0] doubleValue];
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = latValue;
    zoomLocation.longitude= lonValue;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 1.0*METERS_PER_MILE, 1.0*METERS_PER_MILE);
    [self.mapView setRegion:viewRegion animated:YES];
//    [self hideMapIcon];
    return indexPath;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"clicked from view controller");
}
*/
//- (void)dealloc {
////    [self.locationManager release];
////    [self.trackingButton release];
////    [self.flexibleSpace release];
////    [self.listItem release];
////    [self.mapItem release];
//    //    [self.drugstoresListTblView release];
//    [self.mapToolbar release];
//    [self.userLocationLabel release];
//    [self.currentWebView release];
//    [self.mapView release];
//    [self.makeCallBtn release];
//    [nomenid release];
//    [ean release];
//    [tnname release];
//    [curCount release];
//    [curCaption release];
//    [element release];
//    [elementMutable release];
//    
//    [super dealloc];
//}


#pragma mark - Collection View delegate methods
-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section {
    
    NSLog(@"numberOfItemsInSection appeared collection");
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
    NSLog(@"self.collectionView_sections_counterself.collectionView_sections_counter: %lu", (long)self.collectionView_sections_counter);
    
        return self.collectionView_sections_counter;
//    }
    
//    });
//    
    
    
//    return 11;
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(UICollectionViewCell *) addShadowAndRoundedCorners:(UICollectionViewCell *)v corner:(float)cornerRadius borderW:(float)borderWidth {
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

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath  {
    static NSString * CellIdentifier = @"CellFirst";
    UICollectionViewCell *cell = [collectionView
                                  dequeueReusableCellWithReuseIdentifier:CellIdentifier
                                  forIndexPath:indexPath];
//    UIImageView *imageView = (UIImageView *)[cell viewWithTag:100];
//    imageView.layer.opacity = 1.0f;
//    imageView.layer.zPosition = 1000.0f;
//    imageView.image = [UIImage imageNamed:@"pill_25.png"];
//    [cell addSubview:imageView];
//    UIImage *image = imageView.image;
    NSLog(@"collection view cell: %@", cell);
    cell = [self addShadowAndRoundedCorners:cell corner:24.0f borderW:0.5f];
    
    if (0 < [_xmlLocalDataHolder count]) {
        NSString *setTitle = @"";
        NSString *setContactInformation = @"";
        NSString *setCompanyAddress = @"";
        NSString *setCompanyUrl = @"";
        NSString *setHours = @"";
        
        setTitle = [NSString stringWithFormat:@"%@", [[_xmlLocalDataHolder objectAtIndex:indexPath.row ] valueForKey:@"name"]];
        setContactInformation = [NSString stringWithFormat:@"Телефон: %@", [[_xmlLocalDataHolder objectAtIndex:indexPath.row ] valueForKey:@"tel"]];
        setCompanyAddress = [NSString stringWithFormat:@"%@", [[_xmlLocalDataHolder objectAtIndex:indexPath.row ] valueForKey:@"address"]];
        setCompanyUrl = [NSString stringWithFormat:@"%@", [[_xmlLocalDataHolder objectAtIndex:indexPath.row ] valueForKey:@"url"]];
        setHours = [NSString stringWithFormat:@"Часы работы: %@", [[_xmlLocalDataHolder objectAtIndex:indexPath.row ] valueForKey:@"hours"]];
        
        UILabel *txtName = [cell viewWithTag:101];
        txtName.text = setTitle;
        UILabel *txtSite = [cell viewWithTag:102];
        txtSite.text = setCompanyUrl;
        UILabel *txtPhone = [cell viewWithTag:103];
        txtPhone.text = setContactInformation;
        UILabel *txtHour = [cell viewWithTag:104];
        txtHour.text = setHours;
        UILabel *txtAddress = [cell viewWithTag:105];
        txtAddress.text = setCompanyAddress;
        
    }
//    tapRecognizer.minimumNumberOfTouches = 0;
//    tapRecognizer.maximumNumberOfTouches = 2;
    
    UIView *headerBg = [cell viewWithTag:10];
    if ([HEXFromUIColor(headerBg.backgroundColor) isEqualToString:HEX_LIGHT_GREEN_COLOR]) {
        headerBg.backgroundColor = LIGHT_GREEN_COLOR;
    } else {
        headerBg.backgroundColor = LIGHT_BLUE_OPAQUE_COLOR;
    }
    
    _curCell = cell;
    
    return cell;
    
}



-(void)panMiddlePosition: (UIPanGestureRecognizer *)sender {
    typedef NS_ENUM(NSUInteger, UIPanGestureRecognizerDirection) {
        UIPanGestureRecognizerDirectionUndefined,
        UIPanGestureRecognizerDirectionUp,
        UIPanGestureRecognizerDirectionDown
//        ,
//        UIPanGestureRecognizerDirectionLeft,
//        UIPanGestureRecognizerDirectionRight
    };
    static UIPanGestureRecognizerDirection direction = UIPanGestureRecognizerDirectionUndefined;
        
    switch (sender.state) {
        case UIGestureRecognizerStateBegan: {
            if (direction == UIPanGestureRecognizerDirectionUndefined) {
                CGPoint velocity = [sender velocityInView:sender.view];
                BOOL isVerticalGesture = fabs(velocity.y) > fabs(velocity.x);
                if (isVerticalGesture) {
                    if (velocity.y > 0) {
                        direction = UIPanGestureRecognizerDirectionDown;
                    } else {
                        direction = UIPanGestureRecognizerDirectionUp;
                    }
                }
//                else {
//                    if (velocity.x > 0) {
//                        direction = UIPanGestureRecognizerDirectionRight;
//                    } else {
//                        direction = UIPanGestureRecognizerDirectionLeft;
//                    }
//                }
            }
            break;
        }
            
        case UIGestureRecognizerStateChanged: {
            switch (direction) {
                case UIPanGestureRecognizerDirectionUp: {
                    [self handleUpwardsGesture:sender];
                    break;
                }
                case UIPanGestureRecognizerDirectionDown: {
                    [self handleDownwardsGesture:sender];
                    break;
                }
//                case UIPanGestureRecognizerDirectionLeft: {
//                    [self handleLeftGesture:sender];
//                    break;
//                }
//                case UIPanGestureRecognizerDirectionRight: {
//                    [self handleRightGesture:sender];
//                    break;
//                }
                default: {
                    break;
                }
            }
        }
            
        case UIGestureRecognizerStateEnded: {
            direction = UIPanGestureRecognizerDirectionUndefined;
            break;
        }
        default:
            break;
    }
    
}


- (void)handleUpwardsGesture:(UIPanGestureRecognizer *)sender {
    NSLog(@"Up: self.touchesCounter: %d", (int) self.topTouchesCounter);
    if (self.bottomTouchesCounter > 0)
        self.bottomTouchesCounter--;
    
    if ((self.topTouchesCounter < 2) &&
        (self.topTouchesCounter >= 0)) {
        self.topTouchesCounter++;
    } else if (self.topTouchesCounter != 2) {
        self.topTouchesCounter = 0;
    }
    
    if ((int)self.topTouchesCounter == 1 ) {
        [self moveToTheMiddle:_drugstoresCollection];
    } else if ((int)self.topTouchesCounter == 2 ) {
        [self moveToTheTop:_drugstoresCollection];
    }
}

- (void)handleDownwardsGesture:(UIPanGestureRecognizer *)sender {
    NSLog(@"Down: self.touchesCounter: %d", (int) self.bottomTouchesCounter);
    if (self.topTouchesCounter > 0)
        self.topTouchesCounter--;
    
    if ((self.bottomTouchesCounter < 2) &&
        (self.bottomTouchesCounter >= 0)) {
        self.bottomTouchesCounter++;
    } else if (self.bottomTouchesCounter != 2) {
        self.bottomTouchesCounter = 0;
    }
    if ((int)self.bottomTouchesCounter == 1 ) {
        [self moveToTheMiddle:_drugstoresCollection];
    } else if ((int)self.bottomTouchesCounter == 2 ) {
        [self moveToTheBottom:_drugstoresCollection];
    }
}

//
//- (void)handleLeftGesture:(UIPanGestureRecognizer *)sender {
//    NSLog(@"Left");
//}
//
//- (void)handleRightGesture:(UIPanGestureRecognizer *)sender {
//    NSLog(@"Right");
//}

-(void)moveToTheMiddle:(UICollectionView *)drgstrCln {
    NSLog(@"middle: %f", canvasBottomY);
    NSLog(@"Main View Y: %f", (float) self.view.frame.origin.y);
    UIScreen *someScreen = [UIScreen mainScreen];
    NSLog(@"Main Screen Y: %f", (float) someScreen.applicationFrame.origin.y);
    NSLog(@"Main Screen Bottom Y: %f", (float) (someScreen.applicationFrame.origin.y + someScreen.applicationFrame.size.height));
    NSLog(@"col view bottomY: %f", (float) (_drugstoresCollection.frame.origin.y + _drugstoresCollection.frame.size.height));
    
    [self makeTheTransition:canvasBottomY];
}

-(void)moveToTheBottom:(UICollectionView *)drgstrCln {
    NSLog(@"bottom: %f", CollectionViewHeaderBottomY);
    NSLog(@"Main View Y: %f", (float) self.view.frame.origin.y);
    UIScreen *someScreen = [UIScreen mainScreen];
    NSLog(@"Main Screen Y: %f", (float) someScreen.applicationFrame.origin.y);
    NSLog(@"col view bottomY: %f", (float) _drugstoresCollection.frame.origin.y);
    NSLog(@"col view -> curCell -> ViewWithTag:10 bottomY: %f", (float) _curCell.frame.origin.y);
    
    UIView *someView = [_curCell viewWithTag:10];
    NSLog(@"ВЫСОТА: %f", someView.frame.size.height);
    CollectionViewHeaderBottomY = canvasTopY + _imgAsBG.frame.size.height - someView.frame.size.height;
    [self makeTheTransition:CollectionViewHeaderBottomY];
}

-(void)moveToTheTop:(UICollectionView *)drgstrCln {
    NSLog(@"top");
    NSLog(@"Main View Y: %f", (float) self.view.frame.origin.y);
    UIScreen *someScreen = [UIScreen mainScreen];
    NSLog(@"Main Screen Y: %f", (float) someScreen.applicationFrame.origin.y);
    NSLog(@"col view topY: %f", (float) _drugstoresCollection.frame.origin.y);
    
    [self makeTheTransition:canvasTopY];
}

- (void) animationDidFinish {
    NSLog(@"The animation finish");
}

-(void)makeTheTransition:(float)yPosition {
//    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5f
                              delay:0.0f
                            options: UIViewAnimationOptionCurveEaseIn
                         animations:^ {
                             CGRect frame = _drugstoresCollection.frame;
                             frame.origin.y = yPosition;
                             frame.origin.x = 0;
                             _drugstoresCollection.frame = frame;
                         }
                         completion:^(BOOL finished)
         {
             NSLog(@"Completed");
         }];
//    });
}

-(IBAction) moveViewWithPanGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer {
    NSLog(@"The view nas been moved");
    [self.view bringSubviewToFront:[panGestureRecognizer view]];
//    CGPoint translatedPoint = [panGestureRecognizer translationInView:self.view];
    
    //    if ([panGestureRecognizer state] == UIGestureRecognizerStateBegan) {
    //        firstX = [panGestureRecognizer.view center].x;
    //        firstY = [panGestureRecognizer.view center].y;
    //    }
    //
    //    translatedPoint = CGPointMake(firstX+translatedPoint.x, firstY);
    //
    //    [[panGestureRecognizer view] setCenter:translatedPoint];
    //
    //    if ([panGestureRecognizer state] == UIGestureRecognizerStateEnded) {
    //        CGFloat velocityX = (0.2*[panGestureRecognizer velocityInView:self.view].x);
    //
    //
    //        CGFloat finalX = translatedPoint.x + velocityX;
    //        CGFloat finalY = firstY;// translatedPoint.y + (.35*[(UIPanGestureRecognizer*)sender velocityInView:self.view].y);
    //
    //        if (UIDeviceOrientationIsPortrait([[UIDevice currentDevice] orientation])) {
    //            if (finalX < 0) {
    //                //finalX = 0;
    //            } else if (finalX > 768) {
    //                //finalX = 768;
    //            }
    //
    //            if (finalY < 0) {
    //                finalY = 0;
    //            } else if (finalY > 1024) {
    //                finalY = 1024;
    //            }
    //        } else {
    //            if (finalX < 0) {
    //                //finalX = 0;
    //            } else if (finalX > 1024) {
    //                //finalX = 768;
    //            }
    //
    //            if (finalY < 0) {
    //                finalY = 0;
    //            } else if (finalY > 768) {
    //                finalY = 1024;
    //            }
    //        }
    //
    //        CGFloat animationDuration = (ABS(velocityX)*.0002)+.2;
    //
    //        NSLog(@"the duration is: %f", animationDuration);
    //
    //        [UIView beginAnimations:nil context:NULL];
    //        [UIView setAnimationDuration:animationDuration];
    //        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    //        [UIView setAnimationDelegate:self];
    //        [UIView setAnimationDidStopSelector:@selector(animationDidFinish)];
    //        [[panGestureRecognizer view] setCenter:CGPointMake(finalX, finalY)];
    //        [UIView commitAnimations];
    //    }
}

/*
 // Without the constraints
 -(IBAction) moveViewWithPanGestureRecognizer:(UIPanGestureRecognizer *)recognizer {
 NSLog(@"The view nas been moved");
 CGPoint translation = [recognizer translationInView:self.view];
 recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
 recognizer.view.center.y + translation.y);
 [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
 
 if (recognizer.state == UIGestureRecognizerStateEnded) {
 
 CGPoint velocity = [recognizer velocityInView:self.view];
 CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
 CGFloat slideMult = magnitude / 200;
 NSLog(@"magnitude: %f, slideMult: %f", magnitude, slideMult);
 
 float slideFactor = 0.1 * slideMult; // Increase for more of a slide
 CGPoint finalPoint = CGPointMake(recognizer.view.center.x + (velocity.x * slideFactor),
 recognizer.view.center.y + (velocity.y * slideFactor));
 finalPoint.x = MIN(MAX(finalPoint.x, 0), self.view.bounds.size.width);
 finalPoint.y = MIN(MAX(finalPoint.y, 0), self.view.bounds.size.height);
 
 [UIView animateWithDuration:slideFactor*2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
 recognizer.view.center = finalPoint;
 } completion:nil];
 }
 }
 */

- (void) processDoubleTap:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        CGPoint point = [sender locationInView:_drugstoresCollection];
        NSIndexPath *indexPath = [_drugstoresCollection indexPathForItemAtPoint:point];
        if (indexPath) {
            NSLog(@"Image was tapped: %d", (int) indexPath.row);
            UICollectionViewCell *theCell = [_drugstoresCollection cellForItemAtIndexPath:indexPath];
            UIView *headerOfTheCell = [theCell viewWithTag:10];
            
            UIColor *prevColor = headerOfTheCell.backgroundColor;
//            NSString *colorString = [prevColor description];
            NSLog(@"Prev color: %@", HEXFromUIColor(prevColor));
            
            
            UIColor *lightGreenColor = LIGHT_GREEN_COLOR;
            headerOfTheCell.backgroundColor = lightGreenColor;
            
//            [_drugstoresCollection reloadData];
            
        }
        else {
//            DoSomeOtherStuffHereThatIsntRelated;
        }
    }
}

@end
