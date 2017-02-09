//
//  DescrByNameTblViewController.h
//  ScanTest
//
//  Created by Magnolia on 15.01.14.
//
//

#import <UIKit/UIKit.h>
#import "FourthViewController.h"
//#import "HTMLParser.h"
//#import "TFHpple.h"
#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>
//#import "TreeNode.h"
//#import "XMLParser.h"
#import "AppDetails.h"
#import "GameViewController.h"
//#import "ViewController.h"
#import "HTMLParser.h"
#import "OwnHttpReader.h"

@interface DescrByNameTblViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, UITabBarControllerDelegate, UITabBarDelegate, UITextFieldDelegate, UITabBarControllerDelegate, NSXMLParserDelegate, NSURLSessionDelegate, NSURLSessionDataDelegate, NSURLSessionTaskDelegate, NSURLConnectionDelegate, OwnHttpReaderDelegate> {
    NSMutableArray *tarray;
    FourthViewController *childView;
    NSString *hrefAddress;
    NSString *globalTitle;
    NSString *nextGlobal;
    //IBOutlet UITextView *headerTxt;
    //    HTMLParser *globalNodeHolder;
    NSString *urlByItem2;
    NSData *getHtmlData;
    
    
    NSXMLParser *parser;
    
    
    
    NSMutableArray *feeds;
    NSMutableDictionary *rec;
    
    NSMutableString *nomenid;
    NSMutableString *ean;
    NSMutableString *tnname;
    
    //NSMutableArray *arrayTitles;
    
    NSString *element;
    NSMutableString *elementMutable;
    NSString *curCaption;
    NSString *curCount;
    
    NSAttributedString *tmpAttributed;
    
    
    //NSString *inputString;
    
    NSString *nomenNumber;
    NSString *medicineTitle;
    
}

@property (nonatomic, copy) NSMutableArray *tarray;
@property (nonatomic, strong) NSMutableArray *feeds;

@property (nonatomic, retain) FourthViewController *childView;
@property (nonatomic, retain) NSString *hrefAddress;
@property (nonatomic, retain) NSString *globalTitle;
@property (nonatomic, retain) NSString *nextGlobal;
//@property (nonatomic, retain) IBOutlet UITextView *headerTxt;
//@property (nonatomic, retain) HTMLParser *globalNodeHolder;
@property (nonatomic, retain) NSString *urlByItem2;
@property (nonatomic, retain) NSData *getHtmlData;

//@property (nonatomic, retain) NSAttributedString *forAttributed;


@property (nonatomic, retain) NSAttributedString *tmpAttributed;

//@property (nonatomic, retain) NSString *inputString;

//@property (strong) TreeNode *root;

@property (nonatomic, retain) NSString *nomenNumber;
@property (nonatomic, retain) NSString *eanNumber;
@property (nonatomic, retain) NSString *medicineTitle;
@property (nonatomic, retain) AppDetails *nsobj;

//-(NSMutableArray *) justParseIt;
-(NSMutableArray *) justParseItGoogle;
- (IBAction)previousView:(id)sender;


//@property (nonatomic, strong) NSMutableDictionary *dictData;
//@property (nonatomic,strong) NSMutableArray *marrXMLData;
//@property (nonatomic,strong) NSMutableString *mstrXMLString;
//@property (nonatomic,strong) NSMutableDictionary *mdictXMLPart;

//- (IBAction)returnBack:(id)sender;


@property (nonatomic, retain) NSMutableString *currentStringValue;
@property (nonatomic, retain) NSMutableDictionary *xmlLocalDataHolder;
@property (nonatomic, retain) NSMutableData *receivedData;
@property (nonatomic, retain) HTMLParser *parserH;
@property (strong, nonatomic) IBOutlet UITableView *tblDescr;


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;


@end
