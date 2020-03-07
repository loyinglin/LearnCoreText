//
//  SecondViewController.m
//  LearnCoreText
//
//  Created by loyinglin on 2019/2/27.
//  Copyright © 2019 Loying. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()


@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *pathStr = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"data"];
    NSString *htmlStr = [NSString stringWithContentsOfURL:[NSURL fileURLWithPath:pathStr] encoding:NSUTF8StringEncoding error:nil];
    
    NSLog(@"load string:%@", htmlStr);
    NSData *htmlData = [NSData dataWithBytes:htmlStr.UTF8String length:[htmlStr lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];

    NSDictionary *dic = @{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,
                          NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]};

    NSDate *date = [NSDate date];
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithData:htmlData options:dic documentAttributes:nil error:nil];
    
    NSLog(@"transform time:%f", [[NSDate date] timeIntervalSinceDate:date]);
}


@end
