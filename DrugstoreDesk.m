//
//  DrugstoreDesk.m
//  Навигатор лекарств
//
//  Created by Zzz on 27.04.16.
//  Copyright © 2016 Zzz. All rights reserved.
//

#import "DrugstoreDesk.h"

@implementation DrugstoreDesk
@synthesize jsonDataHolder = _jsonDataHolder;


-(NSMutableDictionary *) jsonDataHolder {
    return _jsonDataHolder;
}

-(void) requestTheDrugstoreDeskServer:(NSString *)urlWithEAN JSONData:(NSData *)JSONData {
    NSLog(@"eanean: %@", urlWithEAN);
    
    NSMutableURLRequest *request = [NSMutableURLRequest
                                    requestWithURL:[NSURL URLWithString:urlWithEAN]];
    NSString *jsonString = [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
    NSLog(@"json string:%@", jsonString);
    NSString *params = [[NSString alloc] initWithFormat:@"jsondata=%@", jsonString];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                      {
                                          if (error) {
                                              NSLog(@"Error: %@", error.localizedDescription);
                                          } else {
                                              NSString *receivedDataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                              
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  if (receivedDataString != nil && data != nil) {
                                                      NSLog(@"Response string from the desk:%@",receivedDataString);
                                                      //                                              NSLog(@"Response data:%@",data);
                                                      [self.delegate returnJSONResponse:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
                                                      //                                              [self.delegate returnJSONResponse:receivedDataString];
                                                      
                                                  }
                                              });

                                          }
                                          
                                          
                                          
                                      }];
    [dataTask resume];
    

     
}

-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    NSLog(@"The error has been received: %@", error);
}

-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    NSLog(@"The data has been received: %@", data);
}

-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    NSLog(@"The response has been received: %@", response);
}


@end
