//
//  AppDetails.h
//  Recipe 2-1 to 2-2 About Us
//
//  Created by joseph hoffman on 6/30/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "TreeNode.h"
//#import "XMLParser.h"

@interface AppDetails : NSObject <NSXMLParserDelegate, NSURLSessionDelegate, NSURLSessionDataDelegate, NSURLSessionTaskDelegate, NSURLConnectionDelegate> {
    NSMutableData *receivedData;
    NSString *eanFromMainView;
    NSXMLParser *parser;
    NSString *element;
    NSMutableString *elementMutable;
    NSString *curCount;
    NSMutableArray *imagesArray;
    NSMutableArray *minSquare;
    int minCounter;
    int minSquareValue;
    NSMutableArray *resultingSquares;
    int setWidth;
    int setHeight;
    int setDepth;
    NSArray *twoSmlstSquares;
    NSMutableString *tnNameForTitle;
    NSMutableArray *innerArray_drugstore;
    NSMutableArray *drugstroreAddresses;
}

@property(strong, nonatomic) NSString *rootean;
@property (nonatomic, retain) NSMutableData *receivedData;
@property (nonatomic, retain) NSString *eanFromMainView;
@property (nonatomic, retain) NSXMLParser *parser;
@property (nonatomic, retain) NSMutableArray *imagesArray;

@property (nonatomic, retain) NSString *element;
@property (nonatomic, retain) NSMutableString *elementMutable;
@property (nonatomic, retain) NSString *curCount;
@property (nonatomic, retain) NSMutableArray *minSquare;
@property (nonatomic) int minCounter;
@property (nonatomic) int minSquareValue;
@property (nonatomic, retain) NSArray *twoSmlstSquares;
@property (nonatomic, retain) NSMutableArray *resultingSquares;
@property (nonatomic) int setWidth;
@property (nonatomic) int setHeight;
@property (nonatomic) int setDepth;
//@property (strong) TreeNode *root;
@property (nonatomic, retain) NSMutableString *tnNameForTitle;
@property (nonatomic, retain) NSMutableArray *innerArray_drugstore;
@property (nonatomic, retain) NSMutableArray *drugstroreAddresses;

//@property (nonatomic, retain) UIImage *companyLogoImage;
@property (nonatomic, retain) UIImage *firstMedicinePhoto;

-(id)initWithName: (NSString *)rootean;
-(void)returnResponse:(NSString *)urlWithEAN success : (void (^)(NSMutableArray *responseArray))success
              failure: (void(^)(NSError* error))failure;
-(void)setEAN:(NSString *)ean;
-(NSString *)getEAN;

// -(int)ean2int3d;

- (NSMutableArray *)checkXML_appDetails:(NSString *)url;
- (int)checkXML_nearestDrugstore:(NSString *)url;
- (NSMutableString *)returnTnname:(NSString *)url;

@end
