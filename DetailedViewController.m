//
//  DetailedViewController.m
//  Recipe 7-3:Creating Custom Annotations
//
//  Created by joseph hoffman on 8/10/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import "DetailedViewController.h"

@interface DetailedViewController ()

@end

@implementation DetailedViewController

@synthesize fields_titles = _fields_titles;
@synthesize fields_values = _fields_values;
@synthesize companyPhoto = _companyPhoto;
@synthesize medicinePhoto = _medicinePhoto;
@synthesize txtDescr = _txtDescr;

- (id)initWithAnnotation:(MyAnnotation *)annotation {
    self = [super init];
    if (self) {
        self.annotation = annotation;
    }
    return self;
}

-(NSMutableArray *) fields_titles {
    return _fields_titles;
}
-(NSMutableArray *) fields_values {
    return _fields_values;
}
-(UIImage *) companyPhoto {
    return _companyPhoto;
}
-(UIImage *) medicinePhoto {
    return _medicinePhoto;
}
-(UITextView *) txtDescr {
    return _txtDescr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    NSLog(@"Detailed view has been appeared");
    self.fields_titles = [[NSMutableArray alloc] initWithObjects:@"Название аптеки", @"Адрес аптеки", @"Телефон аптеки", @"Название препарата", @"Цена препарата", @"Дополнительная информация", nil];
    self.fields_values = [[NSMutableArray alloc] initWithObjects:self.annotation.title, [NSString stringWithFormat:@"%@ \n %@", self.annotation.companyAddress, self.annotation.companyUrl], self.annotation.contactInformation, self.annotation.prepName, self.annotation.subtitle, self.annotation.hours, nil];
    self.companyPhoto = [UIImage imageNamed:@"big_114x114.png"];
    //    self.medicinePhoto = [UIImage imageNamed:@"overlay.png"];
    self.medicinePhoto = [UIImage imageWithData:
                          [NSData dataWithContentsOfURL:
                           [NSURL URLWithString: [NSString stringWithFormat:@"http://www.rlsnet.ru%@", self.annotation.medicineImage]]]];
    
    NSLog(@"Medicine image: http://www.rlsnet.ru%@ /n", self.annotation.medicineImage);
    
    // Do any additional setup after loading the view from its nib.
    //    self.title = self.annotation.prepName;
    self.navigationItem.title  = self.annotation.title;
    //    self.prepName.title = self.annotation.title;
    //    self.navigationItem.title = @"My Title";
    self.titleLabel.text = self.annotation.prepName;
    self.subtitleLabel.text = self.annotation.subtitle;
    self.phoneNumber.text = self.annotation.contactInformation;
    
    
    //    CGRect frameSize = CGRectMake(self.navigationController.navigationBar.frame.origin.x, self.navigationController.navigationBar.frame.origin.y, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height + 15.0f);
    //
    //    [self.navigationController.navigationBar setFrame:frameSize];
    //
    
    //    CGRect frame = [self.prepBar frame];
    //    frame.size.height = 85.0f;
    //    [self.prepBar setFrame:frame];
    
    
    //    self.navigationController.navigationBar.frame.size.height =
    
    //    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Назад" style:UIBarButtonItemStylePlain target:nil action:nil];
    //    self.navigationController.navigationBar.backItem.backBarButtonItem = backButton;
    

}

- (void) viewDidDisappear:(BOOL)animated {
    self.prepName.title = nil;
    self.titleLabel.text = nil;
    self.subtitleLabel.text = nil;
    self.phoneNumber.text = nil;
    self.annotation = nil;
    _fields_titles = nil;
    _fields_values = nil;
    _companyPhoto = nil;
    _medicinePhoto = nil;
    [super viewDidDisappear:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.prepName.title = nil;
    self.titleLabel.text = nil;
    self.subtitleLabel.text = nil;
    self.phoneNumber.text = nil;
    self.annotation = nil;
}

-(IBAction) backButtonClicked:(id)sender {
//    NSLog(@"...");
//    [self.navigationController popViewControllerAnimated:YES];
//    [self dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark -
#pragma mark Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_fields_values count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    [tableView setContentMode:UIViewContentModeCenter];
    tableView.tableHeaderView.center = tableView.center;
    NSString *setTitle = [_fields_titles objectAtIndex:section];
    return setTitle;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier] ;
    if (cell == nil) {
        cell =
        [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                reuseIdentifier:CellIdentifier] autorelease];
    }
//    cell.selectionStyle = UITableViewCellAccessoryDisclosureIndicator;
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = @"...";
    */
    
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"MedicalDetails"];
    if (!cell)
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DetailedViewCell" owner:self options:nil] lastObject];
//    [(UILabel *)[cell viewWithTag:101] setText:[NSString stringWithFormat:@"Switch %d\n", (int)indexPath.row + 1]];
    
    
    NSString *setSubTitle = [_fields_values objectAtIndex:indexPath.section];
    cell.detailTextLabel.text = setSubTitle;

//    [(UITextView *)[cell viewWithTag:101] setText:setSubTitle];
//    
//    UITextView *txtView = (UITextView *)[cell viewWithTag:101];
//    [txtView setText:setSubTitle];
//    txtView setFrame:CGRectMake(, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
//    CGSize size = self.view.frame.size;
//    [txtView setCenter:CGPointMake(size.width - txtView.frame.size.width, size.height/2)];
//    
//    _txtDescr.text = setSubTitle;
    
//    NSString *setTitle = [_fields_titles objectAtIndex:indexPath.section];
//    cell.textLabel.text = setTitle;
    
    switch (indexPath.section) {
        case 0: // Название аптеки
        case 1:
        case 2:
        case 5:
            cell.imageView.image = _companyPhoto;
            break;
        case 3: // Название препарата
        case 4:
            cell.imageView.image = _medicinePhoto;
            break;
        default:
            break;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"MedicalDetails";
    UITableViewCell *prototypeCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!prototypeCell)
        prototypeCell = [[[NSBundle mainBundle] loadNibNamed:@"DetailedViewCell" owner:self options:nil] lastObject];
    [prototypeCell layoutIfNeeded];
    CGFloat currentHeight = prototypeCell.frame.size.height;
    return currentHeight * 1.1;
}

@end
