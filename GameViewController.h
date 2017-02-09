//
//  GameViewController.h
//  3dcube_thrd
//

//  Copyright (c) 2015 Zzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SceneKit/SceneKit.h>
#import "AppDetails.h"
#import "NSString+HTML.h"

@interface GameViewController : UIViewController  <NSURLConnectionDelegate, NSURLConnectionDataDelegate, NSXMLParserDelegate> {
    SCNNode *boxNode;
    AppDetails *nsObjectDetails;
    NSString *eanFromRoot;
    NSMutableArray *inner3dimages;
}

@property (nonatomic, retain) SCNNode *boxNode;
@property (nonatomic, retain) AppDetails *nsObjectDetails;
@property (nonatomic, retain) NSString *eanFromRoot;
@property (strong, nonatomic) NSMutableArray *inner3dimages;

@end
