//
//  OwnHttpReader.m
//  Навигатор лекарств
//
//  Created by Zzz on 13.04.16.
//  Copyright © 2016 Zzz. All rights reserved.
//

#import "OwnHttpReader.h"

@implementation OwnHttpReader 
@synthesize parserH = _parserH;
@synthesize tagsQuantity;
@synthesize tagsQuantityForTbl;
@synthesize xmlDataHolder = _xmlDataHolder;
@synthesize xmlDataArray = _xmlDataArray;
@synthesize localEAN;
@synthesize localTbl;

- (HTMLParser *) parserH {
    return _parserH;
}


// @return XML
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    NSData *data = [NSData dataWithContentsOfURL:location];
    NSLog(@"the loading has finished");
    dispatch_async(dispatch_get_main_queue(), ^{
        [self stopUpdateAnimation];
        NSError *error;
        _parserH = [[HTMLParser alloc] initWithData:data error:&error];
        if (error) {
            NSLog(@"Error: %@", error);
            return;
        } else {
            NSLog(@"session downloadTask: %@", downloadTask);
            
            HTMLNode *bodyNode = [_parserH body];
            NSArray *rootNodes = [bodyNode findChildTags:@"rls"] ;
            _xmlDataArray = [[NSMutableArray alloc] init];
            
            for (HTMLNode *inpNode in rootNodes) {
                int realCounter = [[inpNode getAttributeNamed:@"count"] intValue];
                self.tagsQuantity = [NSNumber numberWithInt: realCounter];
            }
            
                                                                    NSLog(@"self.tagsQuantity: %d", [self.tagsQuantity intValue]);
            
            NSArray *inputNodes = [bodyNode findChildTags:@"rec"];
            if ([self.tagsQuantity intValue] > 0) {
                if ([self.localEAN isEqualToString:@"http://www.kuznetsov.rlsnet.lan/rlsserv_pricesbyregion.htm"] || ([self.localEAN rangeOfString:@"http://www.kuznetsov.rlsnet.lan/rlsserv_drugstorepreorder.htm"].location != NSNotFound)) {
                    //                                                                dispatch_async(dispatch_get_main_queue(), ^{
                    for (HTMLNode *hNode in inputNodes) {
//                        int theCounter = 0;
//                        NSLog(@"[hNode children]: %@", hNode);
                        _xmlDataHolder = [NSMutableDictionary dictionary];
                        for (HTMLNode *tagElement in [hNode children]) {
                            NSString *theTagName = [tagElement tagName];
                            NSString *theTagContent = [tagElement contents];
                            if ((nil != theTagName && ![theTagName isEqualToString:@""]) && (nil != theTagContent && ![theTagContent isEqualToString:@""])) {
                                [_xmlDataHolder setValue:theTagContent forKey:theTagName];
//                                ++theCounter;
                            }
                        }
                        [_xmlDataArray addObject:_xmlDataHolder];
                    }
                    //                                                                });
                    [self.delegate returnHTTPResponse:_xmlDataArray];
                    //                                                                NSLog(@"self.xmlDataArray: %@", self.xmlDataArray);
                } else {
                    NSArray *childrenTags = [[inputNodes objectAtIndex:0] children];
                    int theCounter = 0;
                    self.xmlDataHolder = [NSMutableDictionary dictionary];
                    //                                                                NSLog(@"Children tags: %@", childrenTags);
                    for (HTMLNode *tagElement in childrenTags) {
                        NSString *theTagName = ([tagElement getAttributeNamed:@"caption"]) ? [tagElement getAttributeNamed:@"caption"] : [tagElement tagName];
                        NSString *theTagContent = [tagElement contents];
                        if ((nil != theTagName && ![theTagName isEqualToString:@""]) && (nil != theTagContent && ![theTagContent isEqualToString:@""])) {
                            NSLog(@"theCounter: %d childName: %@ theTagContent: %@", theCounter, theTagName, theTagContent);
                            [self.xmlDataHolder setValue:theTagContent forKey:theTagName];
                            ++theCounter;
                        }
                    }
                    self.tagsQuantityForTbl = [NSNumber numberWithInt:theCounter];
                    NSLog(@"the Counter  %d", [self.tagsQuantityForTbl intValue]);
                    NSLog(@"tmpDictionary: %@", self.xmlDataHolder);
                    [self.delegate returnHTTPResponse:self.xmlDataHolder];
                    NSLog(@"self.xmlDataHolder: %@", self.xmlDataHolder);
                }
                
                
            }
            if (self.localTbl) {
                [self.localTbl reloadData];
            }
        }
        _parserH = nil;
    });
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes {
    
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
//    float progress = (double)totalBytesWritten / (double)totalBytesExpectedToWrite;
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self startUpdateAnimation:@"Загрузка данных..."];
//    });
}

// @return XML
- (void)checkXML:(NSString *)urlWithEAN tbl:(UITableView *)tblDescr  {
    NSLog(@"eanean: %@", urlWithEAN);
    self.localEAN = urlWithEAN;
    self.localTbl = tblDescr;
    
    NSURL *url = [NSURL URLWithString:urlWithEAN];
    NSMutableURLRequest *theRequest=[NSMutableURLRequest requestWithURL:url
                                                            cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                                        timeoutInterval:45.0];
    [theRequest setHTTPMethod:@"GET"];
    NSString *httpAgentTxt = @"rlsMobApp";
    [theRequest setValue:httpAgentTxt forHTTPHeaderField:@"User-Agent"];
    NSLog(@"theRequest: %@", theRequest);
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:theRequest];
    
    [downloadTask resume];
    
    /*
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:theRequest
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    // для работы с json
//                                                    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//                                                    NSLog(@"%@", json);
                                                    // :END
                                                    _parserH = [[HTMLParser alloc] initWithData:data error:&error];
                                                    if (error) {
                                                        NSLog(@"Error: %@", error);
                                                        return;
                                                    } else {
                                                        NSLog(@"response: %@", response );
                                                        _xmlDataArray = [[NSMutableArray alloc] init];
                                                        HTMLNode *bodyNode = [_parserH body];
                                                        NSArray *rootNodes = [bodyNode findChildTags:@"rls"] ;
                                                        
                                                        for (HTMLNode *inpNode in rootNodes) {
                                                            int realCounter = [[inpNode getAttributeNamed:@"count"] intValue];
                                                            self.tagsQuantity = [NSNumber numberWithInt: realCounter];
                                                        }
                                                        
//                                                        NSLog(@"self.tagsQuantity: %d", [self.tagsQuantity intValue]);
                                                        
                                                        NSArray *inputNodes = [bodyNode findChildTags:@"rec"];
                                                        if ([self.tagsQuantity intValue] > 0) {
                                                            if ([urlWithEAN isEqualToString:@"http://www.rlsnet.ru/rlsserv_pricesbyregion.htm"]) {
//                                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                                    for (HTMLNode *hNode in inputNodes) {
                                                                        int theCounter = 0;
                                                                        self.xmlDataHolder = [NSMutableDictionary dictionary];
                                                                        for (HTMLNode *tagElement in [hNode children]) {
                                                                            NSString *theTagName = [tagElement tagName];
                                                                            NSString *theTagContent = [tagElement contents];
                                                                            if ((nil != theTagName && ![theTagName isEqualToString:@""]) && (nil != theTagContent && ![theTagContent isEqualToString:@""])) {
                                                                                [self.xmlDataHolder setValue:theTagContent forKey:theTagName];
                                                                                ++theCounter;
                                                                            }
                                                                        }
                                                                        [self.xmlDataArray addObject:self.xmlDataHolder];
                                                                    }
//                                                                });                                                                
                                                                [self.delegate returnHTTPResponse:self.xmlDataArray];
//                                                                NSLog(@"self.xmlDataArray: %@", self.xmlDataArray);
                                                            } else {
                                                                NSArray *childrenTags = [[inputNodes objectAtIndex:0] children];
                                                                int theCounter = 0;
                                                                self.xmlDataHolder = [NSMutableDictionary dictionary];
//                                                                NSLog(@"Children tags: %@", childrenTags);
                                                                for (HTMLNode *tagElement in childrenTags) {
                                                                    NSString *theTagName = ([tagElement getAttributeNamed:@"caption"]) ? [tagElement getAttributeNamed:@"caption"] : [tagElement tagName];
                                                                    NSString *theTagContent = [tagElement contents];
                                                                    if ((nil != theTagName && ![theTagName isEqualToString:@""]) && (nil != theTagContent && ![theTagContent isEqualToString:@""])) {
                                                                        NSLog(@"theCounter: %d childName: %@ theTagContent: %@", theCounter, theTagName, theTagContent);
                                                                        [self.xmlDataHolder setValue:theTagContent forKey:theTagName];
                                                                        ++theCounter;
                                                                    }
                                                                }
                                                                self.tagsQuantityForTbl = [NSNumber numberWithInt:theCounter];
                                                                NSLog(@"the Counter  %d", [self.tagsQuantityForTbl intValue]);
                                                                NSLog(@"tmpDictionary: %@", self.xmlDataHolder);
                                                                [self.delegate returnHTTPResponse:self.xmlDataHolder];
                                                                NSLog(@"self.xmlDataHolder: %@", self.xmlDataHolder);
                                                            }
                                                            
                                                            
                                                        }
                                                        
                                                        
                                                        if (tblDescr) {
                                                            [tblDescr reloadData];
                                                        }                                                        
                                                    }
                                                    
                                                    
                                                    
                                                }];
    [dataTask resume];
    */
    NSLog(@"hi from OwnHttpReader: \n");
    
}

//- (int)checkXML_nearestDrugstore:(NSString *)url {
//    self.drugstroreAddresses = [[NSMutableArray alloc] init];
//    NSMutableDictionary *rec = [NSMutableDictionary dictionary];
//    //    NSString *string4url = [[NSString alloc] initWithFormat:@"http://www.rlsnet.ru/rlsserv_pricesbyean.htm?ean=%@", self.EAN];
//    NSLog(@"%@: url: %@", self.class, url);
//    TreeNode *rootDrugstore = [[XMLParser sharedInstance] parseXMLFromURL:[NSURL URLWithString:url]];
//    NSLog(@"root counter: %d \n", (int) [root.children count]);
//    int length = (int) [rootDrugstore.children count];
//    if (0 < length) {
//        NSLog(@"leaves %@ \n", [rootDrugstore.children objectAtIndex:0]);
//        for (int i = 0; i < length; i++) {
//            NSLog(@"here: %@ \n", [rootDrugstore.children objectAtIndex:0]);
//            TreeNode *recElement = [rootDrugstore.children objectAtIndex:0];
//            int leastLength = (int) [recElement.children count];
//            for (int j = 0; j < leastLength; j++) {
//                self.innerArray_drugstore = [[NSMutableArray alloc] init];
//                TreeNode *leastElement = [recElement.children objectAtIndex:j];
//                if (nil != leastElement.leafvalue &&
//                    ![leastElement.leafvalue isEqualToString:@""]) {
//                    [rec setObject:leastElement.leafvalue forKey:leastElement.key];
//                    [self.innerArray_drugstore addObject:rec];
//                }
//            }
//            // Добавление картинок препарата и логотипа компании
//            //            NSMutableDictionary *companyLogo = [NSMutableDictionary dictionary];
//            //            [companyLogo setObject: self.companyLogoImage forKey:@"companyLogo"];
//            if (self.firstMedicinePhoto) {
//                NSMutableDictionary *medicineImage = [NSMutableDictionary dictionary];
//                [medicineImage setObject: self.firstMedicinePhoto forKey:@"medicineImage"];
//                //            [self.innerArray_drugstore addObject:companyLogo];
//                [self.innerArray_drugstore addObject:medicineImage];
//            }
//            [self.drugstroreAddresses addObject:self.innerArray_drugstore];
//        }
//    }
//    //    return length;
//    //    */
//    return nil;
//}


#pragma mark -
#pragma mark Прелоадер. Управление прелоадером
// Управление прелоадером
- (void) startUpdateAnimation:(NSString *) processName {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:processName message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
    
    //Create the first status image and the indicator view
    UIImage *statusImage = [UIImage imageNamed:@"1_01.png"];
    UIImageView *activityImageView = [[UIImageView alloc]
                                      initWithImage:statusImage];
    
    
    //Add more images which will be used for the animation
    activityImageView.animationImages = [NSArray arrayWithObjects:
                                         [UIImage imageNamed:@"1_01.png"],
                                         [UIImage imageNamed:@"1_02.png"],
                                         [UIImage imageNamed:@"1_03.png"],
                                         [UIImage imageNamed:@"1_04.png"],
                                         [UIImage imageNamed:@"1_05.png"],
                                         [UIImage imageNamed:@"1_06.png"],
                                         [UIImage imageNamed:@"1_07.png"],
                                         [UIImage imageNamed:@"1_08.png"],
                                         [UIImage imageNamed:@"1_09.png"],
                                         [UIImage imageNamed:@"1_10.png"],
                                         [UIImage imageNamed:@"1_11.png"],
                                         [UIImage imageNamed:@"1_12.png"],
                                         [UIImage imageNamed:@"1_13.png"],
                                         [UIImage imageNamed:@"1_14.png"],
                                         [UIImage imageNamed:@"1_15.png"],
                                         nil];
    //Set the duration of the animation (play with it
    //until it looks nice for you)
    activityImageView.animationDuration = 0.8;
    
    
    //Position the activity image view somewhere in
    //the middle of your current view
    
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    UIView *topView = window.rootViewController.view;
    activityImageView.frame = CGRectMake(
                                         topView.frame.size.width/2
                                         -statusImage.size.width/2,
                                         topView.frame.size.height/2
                                         -statusImage.size.height/2,
                                         statusImage.size.width,
                                         statusImage.size.height);
    
    activityImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    //Start the animation
    [activityImageView startAnimating];
    
    
    //Add your custom activity indicator to your current view
    //    [self.view addSubview:activityImageView];
    //
    //    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    //    [indicator startAnimating];
    [alertView setValue:activityImageView forKey:@"accessoryView"];
    //    [alertView setValue:indicator forKey:@"accessoryView"];
    //    self.preloader = indicator;
    self.alertFromCamera = alertView;
    [alertView show];
}
// :end Управление прелоадером

- (void) stopUpdateAnimation {
    NSLog(@"trying to stop the animation");
    [self.alertFromCamera dismissWithClickedButtonIndex:0 animated:YES];
    [self.preloader stopAnimating];
    self.preloader.hidden = YES;
}




@end
