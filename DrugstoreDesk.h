//
//  DrugstoreDesk.h
//  Навигатор лекарств
//
//  Created by Zzz on 27.04.16.
//  Copyright © 2016 Zzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "HTMLParser.h"

@protocol DrugstoreDeskDelegate <NSObject>
- (void)returnJSONResponse:(NSMutableDictionary *)jsonData;
@end

@interface DrugstoreDesk: NSObject <NSURLSessionDelegate, NSURLSessionDataDelegate, NSURLSessionTaskDelegate, NSURLConnectionDelegate> {
   NSMutableDictionary *jsonDataHolder;
}

@property (nonatomic, weak) id <DrugstoreDeskDelegate> delegate;
@property (nonatomic, weak) NSMutableDictionary *jsonDataHolder;

-(void) requestTheDrugstoreDeskServer:(NSString *)urlWithEAN JSONData:(NSData *)JSONData;
//- (void)getPreorderPriceAvail:(NSString *)urlWithEAN;
//- (NSString *)dataFilePath:(NSString *)fileName;

@end
