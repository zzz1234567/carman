//
//  AppDetails.m
//  Recipe 2-1 to 2-2 About Us
//

#import "AppDetails.h"




@implementation AppDetails

@synthesize receivedData;
@synthesize eanFromMainView;
@synthesize parser;
@synthesize imagesArray;
@synthesize curCount;
@synthesize elementMutable;
@synthesize element;
@synthesize minSquare;
@synthesize minCounter;
@synthesize minSquareValue;
@synthesize resultingSquares;
@synthesize setDepth;
@synthesize setHeight;
@synthesize setWidth;
@synthesize twoSmlstSquares;

//@synthesize root;

@synthesize tnNameForTitle;
//@synthesize images3d;
@synthesize innerArray_drugstore;
@synthesize drugstroreAddresses;

//@synthesize companyLogoImage;
@synthesize firstMedicinePhoto;

-(id)initWithName:(NSString *)ean {
    self = [super init];
//    if (self) {
//        self.rootean = ean;
//    }
    NSLog(@"hi from AppDetails: \n");
    return self;
}

-(void)setEAN:(NSString *)ean {
    self.rootean = ean;
    NSLog(@"EAN: %@ \n", self.rootean);
}

-(NSString *)getEAN {
    return self.rootean;
}

// 3d TABBAR
- (void)returnResponse: (NSString *)urlWithEAN
              success : (void (^)(NSMutableArray *responseArray))success
               failure: (void (^)(NSError *error))failure {
    
    NSURL *url=[NSURL URLWithString:urlWithEAN];
    NSMutableURLRequest *request = [NSMutableURLRequest
                                    requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask * dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"%@",data);
//        NSDictionary * json  = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//        NSLog(@"%@",json);
        NSMutableArray *responseImages = [self checkXML_appDetails:urlWithEAN];
        
        NSLog(@"responseImages: %@\n",responseImages);
        
        if (0 < [responseImages count]) {
            success(responseImages);
        }
        else {
            failure(error);
        }
    }];
    
    [dataTask resume];
    
}

//
//- (NSMutableArray *)returnResponse:(NSString *)urlWithEAN {
//    /*
////    NSHTTPURLResponse *response;
//    NSMutableURLRequest *theRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:[urlWithEAN stringByAddingPercentEncodingWithAllowedCharacters:NSWindowsCP1251StringEncoding]]
//                                                            cachePolicy:NSURLRequestReturnCacheDataElseLoad
//                                                        timeoutInterval:45.0];
//    [theRequest setHTTPMethod:@"GET"];
//    NSString *refererRLS = @"http://www.rlsnet.ru";
//    [theRequest setValue:refererRLS forHTTPHeaderField:@"Referer"];
////     NSData * tmpContent = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&response error: NULL];
//    
//    
//    NSURLSession *session = [NSURLSession sharedSession];
////    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:theRequest
////                                                completionHandler:^(NSData *tmpContent, NSURLResponse *response, NSError *error) {
////                                                    NSMutableArray *responseImages = [self checkXML:tmpContent];
////                                                    //    NSString *responseString = [[NSString alloc] initWithData:tmpContent encoding:NSUTF8StringEncoding];
////                                                    NSLog(@"images: %@", responseImages);
////                                                    return responseImages;
////    }];
////    [dataTask resume];
//    
////    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:theRequest
//                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//                                                    //[self checkXML:data];
////        NSLog(@"images: %@", self.imagesArray);
////        return self.imagesArray;
//    }];
//    [dataTask resume];
//    
//    if (nil != self.imagesArray) {
//        NSLog(@"images: %@", self.imagesArray);
//        return self.imagesArray;
//        
//    }
//    else {
//        return nil;
//    }
//    
//    
//    */
//    
//    NSURL *url=[NSURL URLWithString:urlWithEAN];
//    NSMutableURLRequest *theRequest=[NSMutableURLRequest requestWithURL:url
//                                                            cachePolicy:NSURLRequestReturnCacheDataElseLoad
//                                                        timeoutInterval:45.0];
//    [theRequest setHTTPMethod:@"GET"];
//    NSString *refererRLS = @"http://www.rlsnet.ru";
//    [theRequest setValue:refererRLS forHTTPHeaderField:@"Referer"];
//    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
////    NSString *requestString = @"URL here";
////    NSURL *url = [NSURL URLWithString:requestString];
////    NSURLRequest *theRequest = [NSURLRequest requestWithURL:url];
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:theRequest
//                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//                                                    
//                                                }];
//    [dataTask resume];
//    
//    if (nil != self.imagesArray) {
//        NSLog(@"images: %@", self.imagesArray);
//        return self.imagesArray;
//        
//    }
//    else {
//        return nil;
//    }
//    
//}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler {
    NSURLCredential *cred = [NSURLCredential credentialWithUser:@"" password:@"" persistence:NSURLCredentialPersistenceForSession];
    completionHandler(NSURLSessionAuthChallengeUseCredential, cred);
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    self.receivedData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    [self.receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // do something with the data
    
    // release the connection, and the data object
//    [connection release];
//    [self.receivedData release];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
    NSLog(@"you've got an error: %@ \n", error);
}

//- (NSMutableArray *)checkXML:(NSData *)response {
//    self.imagesArray = [[NSMutableArray alloc] init];
//    self.parser = [[NSXMLParser alloc] initWithData:response];
//    [self.parser setDelegate:self];
//    if ([self.parser parse]) {
//        AppDetails *nsobj = [[AppDetails alloc] initWithName:[NSString stringWithFormat:@"%d", (int) [self.imagesArray count]]];
//        NSLog(@"%@", nsobj);
//        return self.imagesArray;
//    }
//    else {
//        return nil;
//    }
//}


- (NSMutableArray *)checkXML_appDetails:(NSString *)url {
    self.imagesArray = [[NSMutableArray alloc] init];
    NSLog(@"url from 3d: %@", url);
//    self.root = [[XMLParser sharedInstance] parseXMLFromURL:[NSURL URLWithString:url]];
//    TreeNode *recElement = self.root;
//    int length = (int) [recElement.children count];
//    for (int i = 0; i < length; i++) {
//        TreeNode *nodeElement = [recElement.children objectAtIndex:i];
//        element  = nodeElement.leafvalue;
//        if ([nodeElement.key isEqualToString:@"images"]) {
//            [self.imagesArray addObject:nodeElement.leafvalue];
//        }
//    }
    if (nil != self.imagesArray) {
        return self.imagesArray;
    }
    else {
        return nil;
    }
}

- (int)checkXML_nearestDrugstore:(NSString *)url {
    /*
    self.drugstroreAddresses = [[NSMutableArray alloc] init];
    NSMutableDictionary *rec = [NSMutableDictionary dictionary];
    //    NSString *string4url = [[NSString alloc] initWithFormat:@"http://www.rlsnet.ru/rlsserv_pricesbyean.htm?ean=%@", self.EAN];
    NSLog(@"%@: url: %@", self.class, url);
    TreeNode *rootDrugstore = [[XMLParser sharedInstance] parseXMLFromURL:[NSURL URLWithString:url]];
    NSLog(@"root counter: %d \n", (int) [root.children count]);
    int length = (int) [rootDrugstore.children count];
    if (0 < length) {
        NSLog(@"leaves %@ \n", [rootDrugstore.children objectAtIndex:0]);
        for (int i = 0; i < length; i++) {
            NSLog(@"here: %@ \n", [rootDrugstore.children objectAtIndex:0]);
            TreeNode *recElement = [rootDrugstore.children objectAtIndex:0];
            int leastLength = (int) [recElement.children count];
            for (int j = 0; j < leastLength; j++) {
                self.innerArray_drugstore = [[NSMutableArray alloc] init];
                TreeNode *leastElement = [recElement.children objectAtIndex:j];
                if (nil != leastElement.leafvalue &&
                    ![leastElement.leafvalue isEqualToString:@""]) {
                    [rec setObject:leastElement.leafvalue forKey:leastElement.key];
                    [self.innerArray_drugstore addObject:rec];
                }
            }
            // Добавление картинок препарата и логотипа компании
            //            NSMutableDictionary *companyLogo = [NSMutableDictionary dictionary];
            //            [companyLogo setObject: self.companyLogoImage forKey:@"companyLogo"];
            if (self.firstMedicinePhoto) {
                NSMutableDictionary *medicineImage = [NSMutableDictionary dictionary];
                [medicineImage setObject: self.firstMedicinePhoto forKey:@"medicineImage"];
                //            [self.innerArray_drugstore addObject:companyLogo];
                [self.innerArray_drugstore addObject:medicineImage];
            }
            [self.drugstroreAddresses addObject:self.innerArray_drugstore];
        }
    }
    
    
    return length;
    */
    return 0;
}

- (NSMutableString *)returnTnname:(NSString *)url {
    /*
    TreeNode *rootNode = [[XMLParser sharedInstance] parseXMLFromURL:[NSURL URLWithString:url]];
    TreeNode *recElement = [rootNode.children objectAtIndex:0];
    int length = (int) [recElement.children count];
    self.tnNameForTitle = [[NSMutableString alloc] init];
    for (int i = 0; i < length; i++) {
        TreeNode *nodeElement = [recElement.children objectAtIndex:i];
        element  = nodeElement.leafvalue;
        if ([nodeElement.key isEqualToString:@"tnname"]) {
            [self.tnNameForTitle appendString:nodeElement.leafvalue];
        }
    }
    NSLog(@"tnname text: %@ \n", self.tnNameForTitle);
    */
    
    return self.tnNameForTitle;
}

- (void)findMinValueInArray:(NSArray *)inpArray {
    self.minSquareValue = INT_MAX;
    int squaresLength = (int) [inpArray count];
    for (int a = 0; a<squaresLength; a++) {
        NSLog(@"class of int: %@", [[inpArray objectAtIndex:a] class]);
        int x = [[inpArray objectAtIndex:a] intValue];
        if (x < self.minSquareValue) {
            self.minSquareValue = x;
            self.minCounter = a;
        }
    }
}

- (void)findMaximumValueInArray:(NSArray *)inpArray {
    self.minSquareValue = -INT_MAX;
    int heightsLength = (int) [inpArray count];
    for (int a = 0; a<heightsLength; a++) {
        int x = [[inpArray objectAtIndex:a] intValue];
        if (x > self.minSquareValue) {
            self.minSquareValue = x;
            self.minCounter = a;
        }
    }
}

- (void)createSquaresWidthsHeights:(NSArray *)widths
                     heightsParams:(NSArray *)heights
                     squaresParams:(NSMutableArray *)squares
                          whParams:(NSArray *)wh {
    NSLog(@"entered NSMutableDictionary SQUARES %@ \n", squares);
    //    self.resultingSquares = [[NSMutableArray alloc] initWithObjects:@"", nil];
    //
    //    int length = (int) [widths count];
    //    for (int i = 0; i < length; i++ ) {
    //        NSMutableDictionary *dictInner = [NSMutableDictionary dictionary];
    //        NSMutableDictionary *dictOuter = [NSMutableDictionary dictionary];
    //        [dictInner setValue:[widths objectAtIndex:i] forKey:[NSString stringWithFormat:@"%@", [heigths objectAtIndex:i]]];
    //        [dictOuter setValue:dictInner forKey:[NSString stringWithFormat:@"%@", [squares objectAtIndex:i]]];
    //        [self.resultingSquares addObject:dictOuter];
    ////        [dictInner release];
    ////        [dictOuter release];
    //    }
    
    // find the smallest square:
    [self findMinValueInArray:squares];
    NSLog(@"the smallest square index: %d %d \n", self.minCounter, self.minSquareValue);
    NSLog(@"the width: %d \n", [[widths objectAtIndex:self.minCounter] intValue]);
    NSLog(@"the depth: %d \n", [[heights objectAtIndex:self.minCounter] intValue]);
    self.setWidth = [[widths objectAtIndex:self.minCounter] intValue];
    self.setDepth = [[heights objectAtIndex:self.minCounter] intValue];
    
    
    
    // find the largest height:
    [self findMaximumValueInArray:wh];
    NSLog(@"the largest height index: %d %d \n", self.minCounter, self.minSquareValue);
    NSLog(@"the height: %d \n", [[wh objectAtIndex:self.minCounter] intValue]);
    self.setHeight = [[wh objectAtIndex:self.minCounter] intValue];
    
    
    // find two smallest squares on the smallest part of the box (left 4)
    int frstIndex = self.minCounter;
    [squares removeObjectAtIndex:self.minCounter];
    [self findMinValueInArray:squares];
    int scndIndex = self.minCounter;
    self.twoSmlstSquares = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:frstIndex], [NSNumber numberWithInt:scndIndex], nil];
    
}

//-(int)ean2int3d {
//    NSString *rlsQueryMainPart = @"http://rlsnet.ru/rlsserv_imagesbyean.htm?ean=";
//    NSString *urlWithEAN = [[NSString alloc] initWithFormat:@"%@%@", rlsQueryMainPart, self.rootean];
//    NSLog(@"AppDetails urlWithEAN: %@ \n", urlWithEAN);
//    
//    [self returnResponse:urlWithEAN success:^(NSMutableArray *responseImages) {
//        int length = (int) [responseImages count];
//        if (!length) {
//            length = 0;
//        }
//        
//        if (length > 0) {
//            
//        }
//        
//    } failure:^(NSError *error) {
//        
//    }];
//    
//}

@end
