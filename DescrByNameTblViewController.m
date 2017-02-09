//
//  ThirdViewController.m
//  ScanTest
//
//  Created by Magnolia on 15.01.14.
//
//

#import "DescrByNameTblViewController.h"
//#import "HTMLNode.h"

#import "NSString+HTML.h"
//#import "CRGradientNavigationBar.h"

@interface DescrByNameTblViewController ()  {
    //    NSXMLParser *parser;
    //    NSMutableArray *feeds;
    //    NSMutableDictionary *item;
    //    NSMutableString *title;
    //    NSMutableString *link;
    //    NSString *element;
}

@end

@implementation DescrByNameTblViewController
@synthesize tarray;
@synthesize childView;
@synthesize hrefAddress;
@synthesize globalTitle;
//@synthesize headerTxt;
@synthesize nextGlobal;
//@synthesize globalNodeHolder;
@synthesize urlByItem2;
@synthesize getHtmlData;

@synthesize feeds = _feeds;

@synthesize tmpAttributed;

//@synthesize inputString;

//
//@synthesize marrXMLData;
//@synthesize mstrXMLString;
//@synthesize mdictXMLPart;
//@synthesize root;
@synthesize nomenNumber = _nomenNumber;
@synthesize eanNumber = _eanNumber;
@synthesize medicineTitle = _medicineTitle;
@synthesize nsobj;
@synthesize currentStringValue = _currentStringValue;
@synthesize xmlLocalDataHolder;
@synthesize receivedData = _receivedData;
@synthesize parserH = _parserH;
@synthesize tblDescr;

- (NSMutableArray *) feeds {
    return _feeds;
}

- (HTMLParser *) parserH {
    return _parserH;
}

- (NSMutableData *) receivedData {
    return _receivedData;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSString *)nomenNumber {
    return _nomenNumber;
}

- (NSString *)eanNumber {
    return _eanNumber;
}

- (NSString *)medicineTitle {
    return _medicineTitle;
}

- (NSMutableString *)currentStringValue {
    return _currentStringValue;
}



#pragma mark - Parser constants
//<ean caption="">5997086105055</ean>
//<tnname caption="">®]]></tnname>
//<pharmakinetic caption="Фармакокинетика">
//<pharmadynamic caption="Фармакодинамика">
//<indications caption="Показания препарата #">
//<contraindications caption="Противопоказания">
//<sideactions caption="Побочные действия">
//<interactions caption="Взаимодействие">
//<usemethodanddoses caption="Способ применения и дозы">
//<overdose caption="Передозировка">
//<pregnancyuse caption="Применение при беременности и кормлении грудью">
//<specialguidelines caption="Особые указания">
//<adjustdate caption="Последняя актуализация описания производителем"></adjustdate>
//<manufacturer caption="Производитель">
//<drugformdescr caption="Описание лекарственной формы">
//<apteka_condition caption="Условия отпуска из аптек">
//<composition_df caption="Состав">
//<form caption="Форма выпуска">

static NSString * const kean= @"ean";
static NSString * const ktnname= @"tnname";
//static NSString * const kpharmakinetic= @"pharmakinetic";
//static NSString * const kpharmadynamic= @"pharmadynamic";
//static NSString * const kindications= @"indications";
//static NSString * const kean= @"ean";
//static NSString * const kean= @"ean";


- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    self.nsobj = [[AppDetails alloc] init];
    
    
//    [[[[self.tabBarController tabBar]items]objectAtIndex:1]setEnabled:FALSE];
//    [[[[self.tabBarController tabBar]items]objectAtIndex:2]setEnabled:FALSE];
    
    //    [self.tabBarController.tabBar setHidden:NO];
    //    [self.tabBarController setHidesBottomBarWhenPushed: NO];
    
    //    NSLog(@"loaded");
    
    
    //    self.tarray = [self justParseIt];
    //[self justParseIt];
    
    //float this_height = self.view.frame.size.height;
    //float this_width = self.view.frame.size.width;
    //float height_param;
    //float retinaTopMargin;
    
    //    self.title = [tnname stringByConvertingHTMLToPlainText];
    
    self.title = _medicineTitle;
    
    //    [self.navigationController.navigationItem.backBarButtonItem setTitle:@"Назад"];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        //height_param = this_height/2.1;
    }
    else {
        //height_param = this_height;
    }
    
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] == YES && [[UIScreen mainScreen] scale] == 2.00) {
        // RETINA DISPLAY
        //retinaTopMargin = 65.0f;
    }
    else {
        //retinaTopMargin = 0.0f;
    }
    
    /*
     
     UITextView *headerTxt = [[UITextView alloc] initWithFrame:CGRectMake(0.0f, retinaTopMargin, this_width, height_param/3)];
     //textField.borderStyle = UITextBorderStyleRoundedRect;
     headerTxt.font = [UIFont systemFontOfSize:21];
     headerTxt.textAlignment = NSTextAlignmentCenter;
     
     
     //textField.placeholder = @"enter text";
     headerTxt.autocorrectionType = UITextAutocorrectionTypeNo;
     headerTxt.keyboardType = UIKeyboardTypeDefault;
     headerTxt.returnKeyType = UIReturnKeyDone;
     //textField.clearButtonMode = UITextFieldViewModeWhileEditing;
     //textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
     //textField.delegate = self;
     
     headerTxt.contentOffset = CGPointZero;
     
     */
    
    //(!!! ОТКЛЮЧЕНО)
    /*
     
     if ([tarray count] != 0) {
     headerTxt.text = @"";
     
     // ПОЛУЧАЕМ ВЕРИФИКАЦИЮ ПО ПРЕПАРАТУ
     
     TFHpple *rlsParserVERIF      = [TFHpple
     hppleWithHTMLData:
     self.getHtmlData];
     NSString *query1VERIF        = @"//div[@id='series_not_found']/div/text()";
     
     NSArray *getNodesVERIF       = [rlsParserVERIF
     searchWithXPathQuery:        query1VERIF];
     
     NSString *query1VERIF2        = @"//div[@id='series_not_found']/div";
     NSArray *getNodesVERIF2       = [rlsParserVERIF
     searchWithXPathQuery:        query1VERIF2];
     
     NSLog(@"stop %d", [getNodesVERIF2 count]);
     TFHppleElement * element = [getNodesVERIF2 objectAtIndex:0];
     
     NSString *curColor = [element objectForKey:@"id"];
     //        NSLog(@"nodes count %d",[getNodesVERIF count]);
     //int z;
     //NSInteger nodesLengthVERIF = ([getNodesVERIF count]-1);
     //for (z=0; z <= nodesLengthVERIF; z++) {
     TFHppleElement *curTagVERIF  = [getNodesVERIF
     objectAtIndex: 0];
     if (curColor != nil) {
     if ([curColor isEqualToString:@"red"]) {
     UIColor * color1 = [UIColor colorWithRed:165/255.0f green:42/255.0f blue:42/255.0f alpha:1.0f];
     headerTxt.backgroundColor = color1;
     headerTxt.textColor = [UIColor whiteColor];
     }
     else if ([curColor isEqualToString:@"yel"]) {
     UIColor * color2 = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:153/255.0f alpha:1.0f];
     UIColor * colorTxt = [UIColor colorWithRed:0/255.0f green:51/255.0f blue:153/255.0f alpha:1.0f];
     headerTxt.backgroundColor = color2;
     headerTxt.textColor = colorTxt;
     }
     else if ([curColor isEqualToString:@"green"]) {
     UIColor * color3 = [UIColor colorWithRed:23/255.0f green:176/255.0f blue:117/255.0f alpha:1.0f];            headerTxt.backgroundColor = color3;
     headerTxt.textColor = [UIColor whiteColor];
     }
     }
     
     headerTxt.text = [curTagVERIF content];
     
     [self.view addSubview:headerTxt];
     
     
     //NSLog(@"%@", [curTagVERIF content]);
     }
     */
    
    //[headerTxt release];
    
    
    
    OwnHttpReader *httpObj = [[OwnHttpReader alloc] init];
    httpObj.delegate = self;
    NSString *urlWithEAN = [NSString stringWithFormat:@"http://www.rlsnet.ru/rlsserv_t8_ean_%@.htm", _eanNumber];
    [httpObj checkXML:urlWithEAN tbl:tblDescr];
    
    
    //    [tblDescr reloadData];
    
    
}


// Delegated method
- (void)returnHTTPResponse:(NSMutableDictionary *)xmlData {
    self.xmlLocalDataHolder = xmlData;
    NSLog(@"xml data: %@", self.xmlLocalDataHolder);
}

- (IBAction)previousView:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

/*
 - (CAGradientLayer*) silverGradient {
 
 UIColor *colorOne = [UIColor colorWithHue:0 saturation:0.0 brightness:1.0 alpha:1.0]; //Greyish
 UIColor *colorTwo = [UIColor colorWithHue:0 saturation:0.0 brightness:0.88 alpha:1.0]; //Light grey
 UIColor *colorThree = [UIColor colorWithHue:0 saturation:0.0 brightness:0.88 alpha:1.0]; //Light grey
 UIColor *colorFour = [UIColor colorWithHue:0 saturation:0.0 brightness:1.0 alpha:1.0]; //Greyish
 
 NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, colorThree.CGColor, colorFour.CGColor, nil];
 NSNumber *stopOne = [NSNumber numberWithFloat:0.0]; //From top till 45%
 NSNumber *stopTwo = [NSNumber numberWithFloat:0.45]; //From 45% til 55%
 NSNumber *stopThree = [NSNumber numberWithFloat:0.55];
 NSNumber *stopFour = [NSNumber numberWithFloat:1.0]; //From 55% till bottom
 
 NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, stopThree, stopFour, nil];
 
 CAGradientLayer *headerLayer = [CAGradientLayer layer];
 headerLayer.colors = colors;
 headerLayer.locations = locations;
 
 return headerLayer;
 
 }
 */

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //    UINavigationController *navigationController = [[UINavigationController alloc] initWithNavigationBarClass:[CRGradientNavigationBar class] toolbarClass:nil];
    ////    CAGradientLayer *gradient = [CAGradientLayer layer];
    //    UIColor *firstColor = [UIColor colorWithRed:0.949 green:0.976 blue:0.996 alpha:1];
    //    UIColor *secondColor = [UIColor colorWithRed:0.839 green:0.941 blue:0.992 alpha:1];
    //    NSArray *colors = [NSArray arrayWithObjects:(id)firstColor.CGColor, (id)secondColor.CGColor, nil];
    //    [[CRGradientNavigationBar appearance] setBarTintGradientColors:colors];
    //    [[self.navigationController navigationBar] setTranslucent:NO];
    
    //    [gradient setColors:colors];
    //    [self.navigationController.navigationBar.layer setMask:gradient];
    
    //    CGContextSetFillColorWithColor
    
    //NSLog(@"loaded view %@", self.tarray);
    //self.navigationItem.title = @",mbm,n";
    // Do any additional setup after loading the view.
    
    
    
    
}

-(void)viewWillDisappear:(BOOL)animated {
    tarray = nil;
    childView = nil;
    hrefAddress = nil;
    globalTitle = nil;
    //    headerTxt = nil;
    nextGlobal = nil;
    //    globalNodeHolder = nil;
    urlByItem2 = nil;
    getHtmlData = nil;
    self.xmlLocalDataHolder = nil;
    
    [super viewWillDisappear:YES];
}

-(void)viewDidUnload {
    tarray = nil;
    childView = nil;
    hrefAddress = nil;
    globalTitle = nil;
    //    headerTxt = nil;
    nextGlobal = nil;
    //    globalNodeHolder = nil;
    urlByItem2 = nil;
    //    self.forAttributed = nil;
    //    self.root = nil;
    [super viewDidUnload];
}

//- (void) dealloc {
//    [nomenid release];
//    [ean release];
//    [tnname release];
//    //    [curCount release];
//    [curCaption release];
//    [element release];
//    [elementMutable release];
//    [rec release];
//    [feeds release];
//    [self.root release];
//
//    [super dealloc];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    //NSLog(@"memory warning");
    // Dispose of any resources that can be recreated.
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    NSLog(@"Did start element");
    
    //    NSMutableDictionary *tmpDictionary = [NSMutableDictionary dictionary];
    NSLog(@"found %@", elementName);
    if ( [elementName isEqualToString:@"addresses"]) {
        // addresses is an NSMutableArray instance variable
        
        return;
    }
    //    if ( [elementName isEqualToString:@"person"] ) {
    //        // currentPerson is an ABPerson instance variable
    //        currentPerson = [[ABPerson alloc] init];
    //        return;
    //    }
    //    if ( [elementName isEqualToString:@"lastName"] ) {
    //        [self setCurrentProperty:kABLastNameProperty];
    //        return;
    //    }
    // .... continued for remaining elements ....
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (!_currentStringValue) {
        // currentStringValue is an NSMutableString instance variable
        _currentStringValue = [[NSMutableString alloc] initWithCapacity:250];
    }
    NSLog(@"letters: %@", string);
    [_currentStringValue appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    // ignore root and empty elements
    //    if (( [elementName isEqualToString:@"addresses"]) ||
    //        ( [elementName isEqualToString:@"address"] )) return;
    //    if ( [elementName isEqualToString:@"person"] ) {
    //        // addresses and currentPerson are instance variables
    //        [addresses addObject:currentPerson];
    //        [currentPerson release];
    //        return;
    //    }
    ////    NSString *prop = [self currentProperty];
    //    // ... here ABMultiValue objects are dealt with ...
    //    if (( [prop isEqualToString:kABLastNameProperty] ) ||
    //        ( [prop isEqualToString:kABFirstNameProperty] )) {
    //        [currentPerson setValue:(id)currentStringValue forProperty:prop];
    //    }
    if (( [elementName isEqualToString:@"addresses"]) ||
        ( [elementName isEqualToString:@"address"] )) {
        [feeds addObject:self.currentStringValue];
        return;
    }
    
    //    [_xmlDataHolder setValue:_currentStringValue forKey:elementName];
    
    // currentStringValue is an instance variable
    _currentStringValue = nil;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    _receivedData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"you've got an error: %@ \n", error);
}




//#pragma mark - Parser constants
//static NSString * const kRLSName = @"rls";
//static NSString * const kRootName = @"rec";
//
////static NSString * const kNomenid = @"nomenid";
////static NSString * const kEan = @"ean";
////static NSString * const kTnname = @"tnname";
//
//#pragma mark - NSXMLParser delegate methods
//
//- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
//
//    /*
//     If the number of parsed earthquakes is greater than kMaximumNumberOfEarthquakesToParse, abort the parse.
//
//    if (_parsedEarthquakesCounter >= kMaximumNumberOfEarthquakesToParse) {
//        _didAbortParsing = YES;
//        [parser abortParsing];
//    }
//    */
//
//    element  = elementName;
//
//    NSLog(@"element: %@ \n", element);
//
//    if ([elementName isEqualToString:kRootName]) {
//        nomenid   = [[NSMutableString alloc] init];
//        ean    = [[NSMutableString alloc] init];
//        tnname = [[NSMutableString alloc] init];
//    }
//
//    if ([elementName isEqualToString:kRLSName]) {
//        NSString *countAttribute = [attributeDict valueForKey:@"count"];
//
//        if ([countAttribute isEqualToString:@"0"]) {
//            curCount = @"0";
//            NSLog(@"count attr: %@", countAttribute);
//            return;
//        }
//    }
//
//    NSLog(@"tnname: %@", tnname);
//
//    NSString *capAttribute = [attributeDict valueForKey:@"caption"];
//    if (![capAttribute isEqualToString:@""]) {
//        curCaption = capAttribute;
//    }
//    else {
//        curCaption = @"";
//    }
//
//
//
//}
//
//
//
//- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
//
//    NSLog(@"string: %@ \n", string);
//    if ([curCount isEqualToString:@"0"]) {
//        return;
//    }
//
//    //NSLog(@"string: %@\n", string);
//
//    //NSMutableString *elementMutable = nil;
//
//    elementMutable = [[NSMutableString alloc] init];
//    if ([element isEqualToString:element]) {
//        [elementMutable appendString:string];
//        //NSLog(@"elem mutable: %@ || elem: %@\n", elementMutable, element);
//    }
//
//    if ([element isEqualToString:@"tnname"]) {
//        [tnname appendString:string];
//        //NSLog(@"elem mutable: %@ || elem: %@\n", elementMutable, element);
//    }
//
//
//
//    /*
//    else if ([element isEqualToString:@"tnname"]) {
//        [tnname appendString:string];
//        NSLog(@"TNNAME: %@ \n", tnname);
//    }
//    */
//
//}
//
//- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
//    //NSLog(@"elem name: %@ \n elem: %@ \n", elementName, element);
//    if ([curCount isEqualToString:@"0"]) {
//        return;
//    }
//    if ([elementName isEqualToString:element]) {
//        rec    = [[NSMutableDictionary alloc] init];
//        if ([curCaption isEqualToString:@""]) {
//            if ([elementName isEqualToString:@"tnname"]) {
//                NSLog(@"элемент %@ ", tnname);
//            }
////            [rec setObject:elementMutable forKey:element];
////            [feeds addObject:rec];
//        }
//        else {
////            NSLog(@"cur caption: %@", curCaption);
//            [rec setObject:elementMutable forKey:curCaption];
//            [feeds addObject:rec];
//        }
//        //NSLog(@"\n\n !!!!REC %@ \n\n", rec);
//        //[rec setObject:tnname forKey:@"tnname"];
//        //NSLog(@"elem mutable: %@ || elem: %@\n", elementMutable, element);
//        //NSLog(@"\n\n !!!!FEED %@ \n\n", feeds);
//    }
//}
//
//- (void)parserDidEndDocument:(NSXMLParser *)parser {
//    //[self.tableView reloadData];
//    //NSLog(@"feeds %@", [rec objectForKey:@"tnname"]);
//
//
//
//    //NSLog(@"feeds: %@", feeds);
//
//
////    for (NSString *aKey in [rec allKeys]) {
////        //NSDictionary *aValue = [rec valueForKey:aKey];
////        NSData *dt = [aKey dataUsingEncoding:NSUTF8StringEncoding];
////
////        NSString *convKey = [[NSString alloc] initWithData:dt encoding:NSWindowsCP1251StringEncoding];
////
////
////
////        NSLog(@"key converted: %@", convKey);
////    }
//
//}
//
//
//- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
//    NSLog(@"Error = %@", parseError);
//}




//- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
//    element = elementName;
//    if ([element isEqualToString:@"item"]) {
//        item    = [[NSMutableDictionary alloc] init];
//        title   = [[NSMutableString alloc] init];
//        link    = [[NSMutableString alloc] init];
//    }
//}
//
//- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
//    NSLog(@"string: %@ \n", string);
//    if ([element isEqualToString:@"title"]) {
//        [title appendString:string];
//    } else if ([element isEqualToString:@"link"]) {
//        [link appendString:string];
//    }
//}
//
//- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
//
//    if ([elementName isEqualToString:@"item"]) {
//        [item setObject:title forKey:@"title"];
//        [item setObject:link forKey:@"link"];
//        [feeds addObject:[item copy]];
//    }
//
//}
//
//
//- (void)parserDidEndDocument:(NSXMLParser *)parser {
//    [self.tableView reloadData];
//}







-(NSMutableArray *) justParseItGoogle {
    return nil;
}


-(NSAttributedString *)string2attribute:(NSString *)inputString {
    //NSAttributedString *attributed = nil;
    NSDictionary *attributeOptions = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType};
    NSData *tmpData = [inputString dataUsingEncoding:NSUnicodeStringEncoding];
    
    self.tmpAttributed = [[NSAttributedString alloc]
                          initWithData: tmpData
                          options: attributeOptions
                          documentAttributes:nil
                          error:nil];
    //inputString = nil;
    //[self.tmpAttributed autorelease];
    //[attributed autorelease];
    //[tmpData release];
    //[attributeOptions release];
    return self.tmpAttributed;
}

#pragma mark -
#pragma mark Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    //return [self.tarray count];
    //    NSLog(@"count t.array %d", [self.tarray count]);
    //    self.title = [[self string2attribute:tnname] string];
    
    // !!! ЗАМЕНЕНО
    // return [self.tarray count];
    NSLog(@"feeds count: %d", (int) [self.xmlLocalDataHolder count]);
    //    return (int) [self.xmlDataHolder count];
    return (int) [self.xmlLocalDataHolder count];
    //    return 2;
    //    return 11;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"to table %d", [self.tarray count]);
    static NSString *CellIdentifier = @"Cell";
    //static NSString *CellIdentifier = @"SimpleTableIdentifier";
    /*
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
     if (cell == nil) {
     cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
     [cell autorelease];
     // НАСТРОЙКА ПЕРЕХОДА ДЛЯ РЯДА ТАБЛИЦЫ
     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
     }
     */
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier] ;
    
    if (cell == nil) {
        cell =
        [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                               reuseIdentifier:CellIdentifier];
        
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //        CAGradientLayer *gradient = [CAGradientLayer layer];
    //        gradient.frame = cell.bounds;
    //        UIColor *colorOne = [UIColor colorWithHue:0 saturation:0.0 brightness:1.0 alpha:1.0]; //Greyish
    //        UIColor *colorTwo = [UIColor colorWithHue:0 saturation:0.0 brightness:0.88 alpha:1.0]; //Light grey
    //        UIColor *colorThree = [UIColor colorWithHue:0 saturation:0.0 brightness:0.88 alpha:1.0]; //Light grey
    //        UIColor *colorFour = [UIColor colorWithHue:0 saturation:0.0 brightness:1.0 alpha:1.0]; //Greyish
    //        NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, colorThree.CGColor, colorFour.CGColor, nil];
    //        gradient.colors = colors;
    //        gradient.opacity = 0.01;
    
    // red to white gradient:
    //        gradient.colors = [NSArray
    //                           arrayWithObjects:
    //                           (id)[[UIColor colorWithRed:0.322 green:0.929 blue:0.78 alpha:0.5] CGColor],
    //                           (id)[[UIColor colorWithRed:0.353 green:0.784 blue:0.984 alpha:0.5] CGColor],
    //                           nil];
    // :end
    
    //[cell.layer addSublayer:gradient];
    
    //        [cell.layer insertSublayer:gradient atIndex:1];
    
    //        CAGradientLayer *bgLayer = [Colors navigationMenuGradient];
    //        bgLayer.frame = tableView.bounds;
    //        [tableView.layer insertSublayer:bgLayer atIndex:0];
    
    /*
     UIWebView* webView = [[UIWebView alloc] initWithFrame:
     CGRectMake(0,0, 320, 44)];
     webView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
     webView.tag = 1001;
     webView.userInteractionEnabled = NO;
     webView.opaque = NO;
     webView.backgroundColor = [UIColor clearColor];
     
     [cell addSubview:webView];
     
     [cell autorelease];
     */
    // НАСТРОЙКА ПЕРЕХОДА ДЛЯ РЯДА ТАБЛИЦЫ
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    //    NSLog(@"%@", @"jhkjh");
    //    return cell;
    
    // !!! УБРАНО
    //HTMLParser *thisTutorial = [self.tarray objectAtIndex:indexPath.row];
    
    //NSLog(@"hjfjhgjhg: %@", thisTutorial.title);
    
    //    UIFont *font = [UIFont fontWithName:@"Verdana" size:16.0f];
    
    //cell.textLabel.attributedText = [self string2attribute:thisTutorial.title];
    
    NSString *tempDictKey = [[self.xmlLocalDataHolder allKeys] objectAtIndex:indexPath.row];
    //    NSString *tempDictKey = [[[feeds objectAtIndex:indexPath.row] allKeys] objectAtIndex:0];
    //self.inputString = tempDictKey;
    //[tempDictKey autorelease];
    //cell.textLabel.text = self.inputString;
    
    //    cell.textLabel.attributedText = [self string2attribute:tempDictKey];
    //    cell.textLabel.text = [tempDictKey stringByConvertingHTMLToPlainText];
    cell.textLabel.text = tempDictKey;
    //    cell.textLabel.font = font;
    
    cell.textLabel.textColor = [UIColor blackColor];
    //cell.detailTextLabel.text = thisTutorial.url;
    
    /*
     NSRegularExpression *regex_tags = [NSRegularExpression regularExpressionWithPattern:@"<.*"
     options:NSRegularExpressionCaseInsensitive
     error:nil];
     */
    
    // !!! заменено
    /*
     if (thisTutorial.header4Cell != nil) {
     //NSString *stringWithoutTags = [regex_tags stringByReplacingMatchesInString:thisTutorial.header4Cell options:0 range:NSMakeRange(0, [thisTutorial.header4Cell length]) withTemplate:@""];
     
     // !!! заменено
     
     //cell.detailTextLabel.attributedText = [self string2attribute:thisTutorial.header4Cell];
     
     cell.detailTextLabel.text = [[feeds objectAtIndex:indexPath.row] objectForKey:tempDictKey];
     
     //cell.detailTextLabel.text = stringWithoutTags;
     
     }
     else {
     // !!! заменено
     
     //cell.detailTextLabel.text = thisTutorial.header4Cell;
     cell.detailTextLabel.text = [[feeds objectAtIndex:indexPath.row] objectForKey:tempDictKey];
     
     }
     
     */
    
    //    cell.detailTextLabel.text = [[_feeds objectAtIndex:indexPath.row] objectForKey:tempDictKey];
    
    //UIImage *image = [UIImage imageNamed:@"up.gif"];
    //cell.imageView.image = image;
    
    
    
    
    //    HTMLParser *getNodes4Cells = [self.nodesArray objectAtIndex:indexPath.row];
    //    cell.textLabel.text = getNodes4Cells.title;
    //    cell.detailTextLabel.text = getNodes4Cells.url;
    
    /*
     return cell;
     */
    
    
    //NSUInteger row = [indexPath row];
    //cell.textLabel.text = [self.tarray objectAtIndex:row];
    //HTMLParser *getNodes4Cells = [self.nodesArray objectAtIndex:indexPath.row];
    //cell.textLabel.text = getNodes4Cells.title;
    
    
    //    cell.backgroundColor = (indexPath.row % 2) ? [UIColor colorWithRed: 0.0 green: 0.0 blue: 1.0 alpha: 1.0]
    //    : [UIColor whiteColor];
    //    cell.textLabel.backgroundColor = [UIColor clearColor];
    //    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    return cell;
}

#pragma mark -
#pragma mark Table View Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // ПОДКЛЮЧАЕМ СЛЕДУЮЩИЙ КОНТРОЛЛЕР (БУДЕМ ПЕРЕДАВАТЬ В НЕГО ПЕРЕМЕННЫЕ)
    FourthViewController *nextView = [[FourthViewController alloc] initWithNibName:@"FourthViewController" bundle:nil];
    
    //nextView.title =
    
    childView = nextView;
    /*
     UIViewController *nextView;
     
     if (!self.nextView) {
     nextView = [[UIViewController alloc] initWithNibName:@"FourthViewController" bundle:nil];
     
     }
     
     
     NSTextCheckingResult *tempMatching = [self.matchGlobal objectAtIndex:row];
     NSString *tag2 = [string substringWithRange:[match range]];
     nextView.stringHolder = tag2;
     */
    
    //NSUInteger row = [indexPath row];
    //childView.stringHolder = [self.globalNodes objectAtIndex:row];
    //TFHppleElement *element = [self.globalNodes objectAtIndex:row];
    //NSLog(@"4 VIEW: %@", element.raw);
    //childView.title = [[element firstChild] content];
    
    //HTMLParser *thisTutorial = [self.tarray objectAtIndex:indexPath.row];
    
    NSString *startingHTML = @"<b>";
    //NSLog(@"url: %@",thisTutorial.header4Cell);
    
    // this was changed by myself:
    //    NSString *middleHTML = [startingHTML stringByAppendingFormat:@"%@ %@" , thisTutorial.url, thisTutorial.header4Cell];
    
    
    // !!! ЗАМЕНЕНО
    // NSString *middleHTML = [startingHTML stringByAppendingFormat:@"%@" , thisTutorial.url];
    NSString *tempDictKey = [[self.xmlLocalDataHolder allKeys] objectAtIndex:indexPath.row];
    
    NSString *middleHTML = [startingHTML stringByAppendingFormat:@"%@" , [self.xmlLocalDataHolder objectForKey:tempDictKey]];
    
    
    childView.html = [middleHTML stringByAppendingString: @"</b>"];
    //childView.viewTitle = thisTutorial.title;
    
    
    childView.viewTitle = tempDictKey;
    
    
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Назад" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backBarButtonItem;
    
    //[self.navigationController dismissViewControllerAnimated:YES completion:nil];
    //[super dismissViewControllerAnimated:YES completion:NULL];
    [self.navigationController pushViewController:childView animated:YES];
    
}

//- (IBAction)returnBack:(id)sender {
//    //    [self.view removeFromSuperview];
//    //    [self.navigationController popToRootViewControllerAnimated:YES];
////    [self dismissViewControllerAnimated:YES completion:^{}];
//    NSLog(@"stop");
//}


//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    if (section == 0) {
//        return @"abcdefg";
//    }
//    else {
//        return @"bmnbmb";
//    }
//}


@end
