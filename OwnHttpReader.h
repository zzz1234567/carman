//
//  OwnHttpReader.h
//  Навигатор лекарств
//
//  Created by Zzz on 13.04.16.
//  Copyright © 2016 Zzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "HTMLParser.h"

@protocol OwnHttpReaderDelegate <NSObject>
- (void)returnHTTPResponse:(id)xmlData;
@end


@interface OwnHttpReader : NSObject <NSXMLParserDelegate, NSURLSessionDelegate, NSURLSessionDataDelegate, NSURLSessionTaskDelegate, NSURLSessionDownloadDelegate, NSURLConnectionDelegate>

@property (nonatomic, weak) id <OwnHttpReaderDelegate> delegate;
@property (nonatomic, retain) HTMLParser *parserH;
@property (nonatomic, retain) NSNumber *tagsQuantity;
@property (nonatomic, retain) NSNumber *tagsQuantityForTbl;
@property (nonatomic, retain) NSMutableDictionary *xmlDataHolder;
@property (nonatomic, retain) NSMutableArray *xmlDataArray;
@property (nonatomic, weak) NSString *localEAN;
@property (nonatomic, weak) UITableView *localTbl;

- (void)checkXML:(NSString *)eanNumber tbl:(UITableView *)tblDescr;

// ПРЕЛОАДЕР
@property(nonatomic, retain) UIActivityIndicatorView *preloader;
@property(nonatomic, retain) UIAlertView *alertFromCamera;
// ОСТАНОВКА АНИМАЦИИ ПРЕЛОАДЕРА
- (void) stopUpdateAnimation;

@end
