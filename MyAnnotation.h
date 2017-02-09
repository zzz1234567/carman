//
//  MyAnnotation.h
//  Recipe 7-3:Creating Custom Annotations
//
//  Created by joseph hoffman on 8/10/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MyAnnotation : MKPointAnnotation

@property (nonatomic, strong) NSString *contactInformation;
@property (nonatomic, strong) NSString *prepName;
@property (nonatomic, strong) NSString *companyAddress;
@property (nonatomic, strong) NSString *companyUrl;
@property (nonatomic, strong) NSString *hours;
@property (nonatomic, strong) NSString *medicineImage;
@property (nonatomic) NSUInteger indexId;

//-(id)initWithCoordinate:(CLLocationCoordinate2D)coord
//               prepName:(NSString *)prepName
//                  title:(NSString *)title
//               subtitle:(NSString *)subtitle
//     contactInformation:(NSString *)contactInfo
//         companyAddress:(NSString *)addressTxt
//             companyUrl:(NSString *)companyUrl
//                  hours:(NSString *)hours
//          medicineImage:(NSString *)medicineImage;

-(id)initWithCoordinate:(CLLocationCoordinate2D)coord
               prepName:(NSString *)prepName
                  title:(NSString *)title
     contactInformation:(NSString *)contactInfo
         companyAddress:(NSString *)addressTxt
             companyUrl:(NSString *)companyUrl
                  hours:(NSString *)hours
                indexId:(NSUInteger)indexId;

@end
