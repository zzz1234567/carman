//
//  MedicinesPreOrderCell.m
//  NewsApp
//
//  Created by Zzz on 20.02.16.
//  Copyright © 2016 Zzz. All rights reserved.
//

#import "MedicinesPreOrderCell.h"
#define tradenamesFile @"forscanner_extended"
#define minifiedFile @"forscanner_minified"
#define kFilename @"data_new.plist"

@implementation MedicinesPreOrderCell

@synthesize header = _header;
@synthesize text = _text;
@synthesize quantity = _quantity;
@synthesize plusSign = _plusSign;
@synthesize minusSign = _minusSign;
@synthesize addToTheOrderText = _addToTheOrderText;
@synthesize switcher = _switcher;
@synthesize respToClick = _respToClick;
@synthesize defaultStepperLabel = _defaultStepperLabel;
@synthesize defaultStepper = _defaultStepper;
@synthesize txt;
@synthesize SectionRowHolder = _SectionRowHolder;

- (UILabel *) SectionRowHolder {
    return _SectionRowHolder;
}

- (UIStepper *) defaultStepper {
    return _defaultStepper;
}

- (UILabel *) defaultStepperLabel {
    return _defaultStepperLabel;
}

-(UILabel *) header {
    return _header;
}

-(UILabel *) text {
    return _text;
}

//-(UILabel *) quantity {
//    return _quantity;
//}

-(UIButton *) minusSign {
    return _minusSign;
}

-(UIButton *) plusSign {
    return _plusSign;
}

-(UIButton *) respToClick {
    return _respToClick;
}


-(UITextField *) addToTheOrderText {
    return _addToTheOrderText;
}

-(UISwitch *) switcher {
    return _switcher;
}

- (NSString *)dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
                                                         NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:kFilename];
}

- (NSArray *)getContentOfPlistOnTheCell {
    // запись нового значения в plist
    NSString *filePath = [self dataFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSArray *array = [[NSArray alloc] initWithContentsOfFile:filePath];
        NSLog(@"ARRAY from the plist: %@", array);
        return array;
    } else {
        return nil;
    }
}

#pragma mark - Actions

- (void)stepperValueDidChange:(UIStepper *)stepper {
    NSLog(@"A stepper changed its value: %@.", stepper);
    
    // Figure out which stepper was selected and update its associated label.
    UILabel *stepperLabel;
    UITextField *txt_ghjk;
    if (self.defaultStepper == stepper) {
        stepperLabel = self.defaultStepperLabel;
        txt_ghjk = self.txt;
    }
    
    stepperLabel.text = [NSString stringWithFormat:@"%ld", (long)stepper.value];
    txt_ghjk.text = [NSString stringWithFormat:@"%ld", (long)stepper.value];
    
    
    CGPoint touchPoint = [stepper convertPoint:CGPointZero toView:[self getTableView]];
    NSIndexPath *clickedButtonIndexPath = [[self getTableView] indexPathForRowAtPoint:touchPoint];
    NSLog(@"index path.section ==%ld",(long)clickedButtonIndexPath.section);
    NSLog(@"index path.row ==%ld",(long)clickedButtonIndexPath.row);
    
//    NSString *getFirstLetter = [[[getFullList objectAtIndex:clickedButtonIndexPath.section] allKeys] objectAtIndex:0];
//    NSString *getTradename = [[[[getFullList objectAtIndex:clickedButtonIndexPath.section] valueForKey:getFirstLetter] objectAtIndex:clickedButtonIndexPath.row] valueForKey:@"prepname"];
    
    // запись нового значения в plist
    NSString *filePath = [self dataFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
//        NSArray *array = [[NSArray alloc] initWithContentsOfFile:filePath];
        //        NSLog(@"Text n one: %@", [array objectAtIndex:0]);
    }
    
    //    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray: [self getContentOfPlistOnTheCell]];
    
    long rowcombined = (long)clickedButtonIndexPath.row;
    
//    BOOL theRowSectionArePresent = NO;
//    NSMutableArray *objectsToRemove = [[NSMutableArray alloc] init];
    for (NSMutableDictionary *dataForRow in array) {
//        NSString *sectionRowToCheck = [dataForRow objectForKey:@"sectionrow"];
//        NSLog(@"sectionRowToCheck: %@ getCurrentSectionRowNumber:%@ sectrowcombined:%ld", sectionRowToCheck, self.SectionRowHolder.text, rowcombined);
        // row/section есть данные в файле
//        if ([sectionRowToCheck isEqualToString:self.SectionRowHolder.text]) {
            // Проверка на минимальное значение (если минимальное значение, то удалить объект из файла)
            if (stepper.value == stepper.minimumValue) {
                // удаление объекта из файла
                // :DELETE
                NSLog(@"DELETE: %@", dataForRow);
                
                // Делегат для главного окна% (Извещение об удалении позиции; обновление таблицы в случае подтверждения)
                
                MedicinesPreOrderCell *curCell = (MedicinesPreOrderCell *) self;
                //                    if ([rowToCheck intValue] == (int) clickedButtonIndexPath.row) {
                //                        NSLog(@"rowToCheck intValue: %d clickedButtonIndexPath.row:%d", [rowToCheck intValue], (int) clickedButtonIndexPath.row);
                //                        NSLog(@"DELETE zero: %@", dataForRow);
                //                        [self.delegate deleteZero_Alerting:clickedButtonIndexPath theCell:curCell obj2remove:[array objectAtIndex:0]];
                //                    } else {
                [self.delegate deleteZero_Alerting:clickedButtonIndexPath theCell:curCell obj2remove:[array objectAtIndex: rowcombined]];
                //                    }
                //                {
                //                    NSLog(@"delegate: deleting approved");
                //                    [objectsToRemove addObject:dataForRow];
                //                }
            } else {
                // :UPDATE
                if (stepperLabel.text != nil) {
                    [[array objectAtIndex: rowcombined] setObject:stepperLabel.text forKey:@"quantity"];
                } else {
                    [[array objectAtIndex: rowcombined] setObject:@"" forKey:@"quantity"];
                }
                
                NSLog(@"UPDATE: %@", [array objectAtIndex: rowcombined]);
                [array writeToFile:[self dataFilePath] atomically:YES];
            }
            //            theRowSectionArePresent = YES;
//        }
    }
    
    
    
}

//    if ([objectsToRemove count] > 0) {
//        for (NSDictionary *objectToRemove in objectsToRemove) {
//            [array removeObject:objectToRemove];
//        }
//        [array writeToFile:[self dataFilePath] atomically:YES];
//        
//    }
//    

    
    
//    if (!theRowSectionArePresent) {
//        // нет данных в файле
//        // :INSERT
//        NSMutableDictionary *newDictionary = [NSMutableDictionary dictionary];
//        [newDictionary setObject:[NSNumber numberWithInteger:clickedButtonIndexPath.section] forKey:@"section"];
//        [newDictionary setObject:[NSNumber numberWithInteger:clickedButtonIndexPath.row] forKey:@"row"];
//        [newDictionary setObject:stepperLabel.text forKey:@"quantity"];
//        [array addObject:newDictionary];
//    }
    
    
    
    //    NSMutableDictionary *dataToChange = [NSMutableDictionary dictionaryWithDictionary:[[[getFullList objectAtIndex:clickedButtonIndexPath.section] valueForKey:getFirstLetter] objectAtIndex:clickedButtonIndexPath.row]];
    //    NSLog(@"dataToChange before: %@", dataToChange);
    //    [dataToChange setObject:[NSString stringWithFormat:@"%ld", (long)stepper.value] forKey:@"quantity"];
    //    NSLog(@"dataToChange after: %@", dataToChange);
    //    [(NSDictionary *)dataToChange writeToFile:[self currentContentFilePath] atomically:YES];
    // :END


//- (NSString *)currentContentFilePath {
////    NSArray *documentDirectories =
////    NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
////    NSString *documentsDirectory = [documentDirectories objectAtIndex:0];
////    NSLog(@"documentsDirectory: %@ \n [NSBundle mainBundle]: %@ ", documentsDirectory, [NSBundle mainBundle]);
////    return [documentsDirectory
////            stringByAppendingPathComponent:@"forscanner_minified.plist"];
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//
//}

- (NSArray *)readFullMedicinesListFromPlist {
    NSArray *list = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:tradenamesFile ofType:@"plist"]];
    return list;
}


//-(void)fadeOut:(UIView *)objectToAnimate {
//    CABasicAnimation* fadeAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
//    fadeAnim.fromValue = [NSNumber numberWithFloat:1.0];
//    fadeAnim.toValue = [NSNumber numberWithFloat:0.0];
//    fadeAnim.duration = 1.0;
//    [objectToAnimate.layer addAnimation:fadeAnim forKey:@"opacity"];
//}
//
//-(void)fadeIn:(UIView *)objectToAnimate {
//    CABasicAnimation* fadeAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
//    fadeAnim.fromValue = [NSNumber numberWithFloat:0.0];
//    fadeAnim.toValue = [NSNumber numberWithFloat:1.0];
//    fadeAnim.duration = 1.0;
//    [objectToAnimate.layer addAnimation:fadeAnim forKey:@"opacity"];
//}

// uses the indexPathForCell to return the indexPath for itself
- (NSIndexPath *)getIndexPath {
    return [[self getTableView] indexPathForCell:self];
}

// retrieve the table view from self
- (UITableView *)getTableView {
    // get the superview of this class, note the camel-case V to differentiate
    // from the class' superview property.
    UIView *superView = self.superview;
    
    /*
     check to see that *superView != nil* (if it is then we've walked up the
     entire chain of views without finding a UITableView object) and whether
     the superView is a UITableView.
     */
    while (superView && ![superView isKindOfClass:[UITableView class]]) {
        superView = superView.superview;
    }
    
    // if superView != nil, then it means we found the UITableView that contains
    // the cell.
    if (superView) {
        // cast the object and return
        return (UITableView *)superView;
    }
    
    // we did not find any UITableView
    return nil;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.backgroundColor = [UIColor redColor];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Triggered when touch is released
    self.backgroundColor = [UIColor whiteColor];
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Triggered if touch leaves view
    self.backgroundColor = [UIColor whiteColor];
    
}


//- (IBAction)plusBtnClck:(id)sender forEvent:(UIEvent *)event {
//    //    NSSet *touches = [event touchesForView:sender];
//    //    UITouch *touch = [touches anyObject];
//    //    CGPoint touchPoint = [touch locationInView:sender];
//    //    CGFloat pointX = touchPoint.x;
//    //    CGFloat pointY = touchPoint.y;
//    //    NSLog(@" from Topics cell: Coordinates are: %f, %f ", pointX, pointY);
//    //
//    //    [self.delegate buttonActionwith:self.buttonIndexPath];
//    //
//    //    [self configureDefaultStepper];
//    
//    
//    CGPoint touchPoint = [sender convertPoint:CGPointZero toView:[self getTableView]]; // maintable --> replace your tableview name
//    NSIndexPath *clickedButtonIndexPath = [[self getTableView] indexPathForRowAtPoint:touchPoint];
//    
//    //    self.buttonIndexPath = clickedButtonIndexPath;
//    
//    NSLog(@"index path.section ==%ld",(long)clickedButtonIndexPath.section);
//    NSLog(@"index path.row ==%ld",(long)clickedButtonIndexPath.row);
//    
//    
//    //    UIButton *senderButton = (UIButton *)sender;
//    //    NSLog(@"current Row=%d", (int)senderButton.tag);
//    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
//    MedicinesPreOrderCell *tcell = (MedicinesPreOrderCell *) [[self getTableView] cellForRowAtIndexPath:path];
//    
//    NSLog(@"[tcell subviews]: %@ count: %d", [tcell.contentView subviews], (int) [[tcell.contentView subviews] count]);
//    
//    UIView *uv = (UIView *) [[tcell.contentView subviews] objectAtIndex:4];
//    UILabel *uvlbl = (UILabel *) [[uv subviews] objectAtIndex:0];
//    int currentQuantity = [uvlbl.text intValue];
//    if ([uvlbl.text isEqualToString:@""]) {
//        [uvlbl setText:@"1"];
//    } else {
//        ++currentQuantity;
//        [uvlbl setText:[NSString stringWithFormat:@"%d", currentQuantity]];
//    }
//    
//    
//    //    [tcell.quantity setText:@"cvbnm,"];
//    /*
//     UIButton *btn = (UIButton *) sender;
//     TopicsCell *topicCell = (TopicsCell *) [[[sender superview] superview] viewWithTag:btn.tag];
//     NSLog(@"the cell's header data: %@", topicCell.header.text);
//     
//     for (UIView *view in  self.contentView.subviews){*/
//    /*
//     if ([view isKindOfClass:[UIButton class]]){
//     UIButton *btnTmp = (UIButton *)view;
//     btnTmp.hidden = YES;
//     } else if ([view isKindOfClass:[UILabel class]]){
//     UILabel* labelTmp = (UILabel *)view;
//     if (labelTmp.tag == 4) {
//     // quantity text
//     //                    [self fadeIn:labelTmp];
//     labelTmp.hidden = NO;
//     [labelTmp setText:@"1"];
//     }
//     } else if ([view isKindOfClass:[UITextField class]]){
//     UITextField* txtFieldTmp = (UITextField *)view;
//     if (txtFieldTmp.tag == 6) {
//     // add to the order text
//     //                    [self fadeOut:txtFieldTmp];
//     txtFieldTmp.hidden = YES;
//     }
//     } else if ([view isKindOfClass:[UISwitch class]]){
//     UISwitch* switchTmp = (UISwitch *)view;
//     //                [self fadeOut:switchTmp];
//     switchTmp.hidden = YES;
//     }
//     */
//    /*
//     if ([view isKindOfClass:[UILabel class]]){
//     UILabel *lbl = (UILabel *)[view viewWithTag:btn.tag];
//     lbl.text = @":::";
//     }
//     }
//     */
//    
//    //    topicCell.quantity.text = topicCell.header.text;
//    //
//    //    [[self getTableView] reloadData];
//    
//    /*
//     // Build the two index paths
//     NSIndexPath* indexPath1 = [NSIndexPath indexPathForRow:clickedButtonIndexPath.row inSection:clickedButtonIndexPath.section];
//     //    TopicsCell *tcell = (TopicsCell *) [[self getTableView] cellForRowAtIndexPath:indexPath1];
//     //    [tcell.quantity setText:@"cvbnm,"];
//     
//     
//     TopicsCell *tcell = [[self getTableView] cellForRowAtIndexPath:[NSIndexPath indexPathForRow:clickedButtonIndexPath.row inSection:clickedButtonIndexPath.section]];
//     
//     [tcell.quantity setText:@"cvbnm,"];
//     */
//    
//    
//    
//    //    NSIndexPath* indexPath2 = [NSIndexPath indexPathForRow:4 inSection:3];
//    // Add them in an index path array
//    //    NSArray* indexArray = [NSArray arrayWithObjects:indexPath1, nil];
//    //    // Launch reload for the two index path
//    //    [[self getTableView] reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationFade];
//    
//    //    UIView *view = [self.contentView.subviews objectAtIndex:(int)ce];
//    
//    
//    /*
//     
//     TopicsCell *clickedCell = (TopicsCell *)[[sender superview] superview];
//     //    UITableView* table = (UITableView *)[clickedCell superview];
//     NSIndexPath *clickedButtonIndexPath = [self getIndexPath];
//     int currentRow = (int) clickedButtonIndexPath.row;
//     
//     // Change the actual data value in the layer to the final value.
//     
//     //    if([sender isOn]){
//     //        NSLog(@"Switch is ON: %lu currentRow: %d", [self.contentView.subviews count], currentRow);
//     
//     
//     
//     //        UIView *view = [self.contentView.subviews objectAtIndex:currentRow];
//     UITableViewCell *cl = clickedCell;
//     UIButton *plusBtnTmp = (UIButton *)[cl viewWithTag:3];
//     UIButton *minusBtnTmp = (UIButton *)[cl viewWithTag:5];
//     UILabel *labelTmp = (UILabel *)[cl viewWithTag:4];
//     [labelTmp setText:@"1"];
//     
//     //        minusBtnTmp.hidden = NO;
//     */
//    /*
//     for (UIView *view in  self.contentView.subviews){
//     if ([view isKindOfClass:[UIButton class]]){
//     UIButton *btnTmp = (UIButton *)view;
//     btnTmp.hidden = YES;
//     } else if ([view isKindOfClass:[UILabel class]]){
//     UILabel* labelTmp = (UILabel *)view;
//     if (labelTmp.tag == 4) {
//     // quantity text
//     //                    [self fadeIn:labelTmp];
//     labelTmp.hidden = NO;
//     [labelTmp setText:@"1"];
//     }
//     } else if ([view isKindOfClass:[UITextField class]]){
//     UITextField* txtFieldTmp = (UITextField *)view;
//     if (txtFieldTmp.tag == 6) {
//     // add to the order text
//     //                    [self fadeOut:txtFieldTmp];
//     txtFieldTmp.hidden = YES;
//     }
//     } else if ([view isKindOfClass:[UISwitch class]]){
//     UISwitch* switchTmp = (UISwitch *)view;
//     //                [self fadeOut:switchTmp];
//     switchTmp.hidden = YES;
//     }
//     }
//     */
//    /*
//     //        plusBtnTmp.hidden = NO;
//     [cl.contentView addSubview:plusBtnTmp];
//     [[self getTableView] reloadData];
//     //        _plusSign.hidden = NO;
//     //        _minusSign.hidden = NO;
//     //        _quantity.hidden = NO;
//     //        [_quantity setText:@"1"];
//     //        _addToTheOrderText.hidden = YES;
//     //        _switcher.hidden = YES;
//     //    } else{
//     //        NSLog(@"Switch is OFF");
//     //    }
//     */
//    
//}


- (void)theTableReloader {
    [[self getTableView] reloadData];
}

@end
