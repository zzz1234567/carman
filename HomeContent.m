//
//  HomeContent.m
//  NewsApp
//
//  Created by Zzz on 16.02.16.
//  Copyright © 2016 Zzz. All rights reserved.
//

#import "HomeContent.h"

@interface HomeContent ()

@end

@implementation HomeContent

@synthesize HomeCell;
@synthesize HelpCell;
@synthesize SettingsCell;
@synthesize ArticlesCell;
@synthesize FashionCell;
@synthesize LifestyleCell;
@synthesize DesignCell;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:NO];
    
//    NSLog(@"the class: %@", self.view);
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
//                                                         bundle:nil];
//    HomeController *homeContent=[storyboard instantiateViewControllerWithIdentifier:@"hController"];
//    [self presentViewController:homeContent animated:NO completion:nil];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)menuBack:(id)sender {
    CATransition *transition = [CATransition animation];
    transition.duration = 0.9;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:transition forKey:nil];
    
    [self dismissViewControllerAnimated:NO completion:nil];
}



#pragma mark -
#pragma mark Table View Data Source Methods
//- (NSInteger)tableView:(UITableView *)tableView
// numberOfRowsInSection:(NSInteger)section {
//    return 8;
//}

//- (UITableViewCell *)tableView:(UITableView *)tableView
//         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
////    static NSString *CellIdentifier = @"";
////    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
////    if (cell == nil) {
////        cell = [[UITableViewCell alloc]
////                initWithStyle:UITableViewCellStyleSubtitle
////                reuseIdentifier:CellIdentifier];
////    }
//
//    UITableViewCell *cell = [tableView  cellForRowAtIndexPath:indexPath];
//    cell.accessoryType = UITableViewCellAccessoryNone;
//    
//    NSUInteger section = [indexPath section];
//    NSUInteger row = [indexPath row];
//    
//    NSLog(@"ix: %d \n", indexPath.row);
////
//////    if (indexPath.row == 1) {
////        UIImageView *someImg = [cell.contentView viewWithTag:1000];
////        [someImg setImage:[UIImage imageNamed:@"Fill 183"]];
//////    }
////    
////    cell.textLabel.text = @"Домой";
////    [cell.textLabel setTextColor:[UIColor colorWithRed:0.278 green:0.545 blue:0.855 alpha:1]];
////    [cell.textLabel setFont:[UIFont fontWithName:@"Avenir" size:42.0]];
////    
////    [cell addSubview:someImg];
////    
////    UILabel *lbl = [cell.contentView viewWithTag:1001];
////    [lbl setText:@"Домой"];
////    
////    [cell.contentView addSubview:lbl];
////    
////    cell.imageView.image = [UIImage imageNamed:@"Fill 183"];
//    
//    return cell;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
//    NSLog(@"ix:%d", indexPath.row);
    
//    UITableViewCell *theCellClicked = [self.tableView cellForRowAtIndexPath:indexPath];
//    if (theCellClicked == theStaticCell) {
//        //Do stuff
//    }
}

@end

