//
//  MyViewAnnotation.m
//  Recipe 7-3:Creating Custom Annotations
//
//  Created by joseph hoffman on 8/10/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import "MyAnnotationView.h"

@implementation MyAnnotationView

- (id)initWithAnnotation:(id <MKAnnotation>)annotation
         reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImage *myImage = [UIImage imageNamed:@"drugstoreIcon_minusWhite_strip.png"];
        self.image = myImage;
        self.frame = CGRectMake(0, 0, 30, 40);
        // Use contentMode to ensure best scaling of image
        self.contentMode = UIViewContentModeScaleAspectFill;
        // Use centerOffset to adjust the position of the image
        self.centerOffset = CGPointMake(0, -20);
        
        self.canShowCallout = YES;
        
        // Left callout accessory view
        UIImageView *leftAccessoryView = [[UIImageView alloc] initWithImage:myImage];
        leftAccessoryView.frame = CGRectMake(0, 0, 30, 45 );
        leftAccessoryView.contentMode = UIViewContentModeScaleAspectFill;
        
//        UIButton* leftButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//        [leftButton addTarget:self action:@selector(hideDetails) forControlEvents:UIControlEventTouchUpInside];
        self.leftCalloutAccessoryView = leftAccessoryView;
        
//        UIColor *lightGreenColor = [UIColor colorWithRed:0.537 green:0.816 blue:0.247 alpha:1];
        //    UIColor *lightGreenColorOpaque = [UIColor colorWithRed:0.537 green:0.816 blue:0.247 alpha:0.8];
//        [self setBackgroundColor:lightGreenColor];
//        [annotationView setTintColor:[UIColor whiteColor]];
        
        // Right callout accessory view
        UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//        [rightButton addTarget:self action:@selector(showDetails) forControlEvents:UIControlEventTouchUpInside];
        self.rightCalloutAccessoryView = rightButton;
    }
    return self;
}


@end
