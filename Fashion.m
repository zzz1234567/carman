//
//  Fashion.m
//  NewsApp
//
//  Created by Zzz on 20.02.16.
//  Copyright © 2016 Zzz. All rights reserved.
//

#import "Fashion.h"
#import "SWRevealViewController.h"

@implementation Fashion 
@synthesize barButton = _barButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [_barButton addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    //        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
    //                                                             bundle:nil];
    //        HomeController *homeContent=[storyboard instantiateViewControllerWithIdentifier:@"hController"];
    //        [self presentViewController:homeContent animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
