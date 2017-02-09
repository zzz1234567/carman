//
//  MyAnnotation.m
//  Recipe 7-3:Creating Custom Annotations
//
//  Created by joseph hoffman on 8/10/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation

//-(id)initWithCoordinate:(CLLocationCoordinate2D)coord prepName:(NSString *)prepName title:(NSString *)title subtitle:(NSString *)subtitle contactInformation:(NSString *)contactInfo companyAddress:(NSString *) addressTxt companyUrl:(NSString *)companyUrl hours:(NSString *)hours medicineImage:(NSString *)medicineImage {
//    self = [super init];
//    if (self) {
//        self.coordinate = coord;
//        self.prepName = prepName;
//        self.title = title;
//        self.subtitle = subtitle;
//        self.contactInformation = contactInfo;
//        self.companyAddress = addressTxt;
//        self.companyUrl = companyUrl;
//        self.hours = hours;
//        self.medicineImage = medicineImage;
//    }
//    return self;
//}

-(id)initWithCoordinate:(CLLocationCoordinate2D)coord prepName:(NSString *)prepName title:(NSString *)title contactInformation:(NSString *)contactInfo companyAddress:(NSString *) addressTxt companyUrl:(NSString *)companyUrl hours:(NSString *)hours indexId:(NSUInteger)indexId {
    self = [super init];
    if (self) {
        self.coordinate = coord;
        self.prepName = prepName;
        self.title = title;
        self.contactInformation = contactInfo;
        self.companyAddress = addressTxt;
        self.companyUrl = companyUrl;
        self.hours = hours;
        self.indexId = indexId;
    }
    
    return self;
}


@end
