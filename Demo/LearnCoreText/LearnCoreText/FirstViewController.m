//
//  FirstViewController.m
//  LearnCoreText
//
//  Created by loyinglin on 2019/2/27.
//  Copyright © 2019 Loying. All rights reserved.
//

#import "FirstViewController.h"
#import "UIView+LYLayout.h"
#import <CoreText/CoreText.h>

@interface FirstViewController ()

@property (nonatomic, strong) UIButton *lineFrameBtn;

@property (nonatomic, strong) UIScrollView *containerScrollView;

@property (nonatomic, strong) UIImageView *topDrawView;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.topDrawView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 200)];
    [self.view addSubview:self.topDrawView];
    
    self.containerScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.containerScrollView];
    if (@available(iOS 11.0, *)) {
        [self.containerScrollView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    
    [self customInit];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)customInit {
    CGFloat startY = self.topDrawView.bottom;
    CGFloat margin = 20;
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, startY, 200, 20)];
        [btn setTitle:@"行布局，选择换行" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.containerScrollView addSubview:btn];
        [btn addTarget:self action:@selector(onBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        startY += CGRectGetHeight(btn.bounds) + margin;
        
        self.lineFrameBtn = btn;
    }
    
    self.containerScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds), startY);
}



#pragma mark - init

#pragma mark - getter&setter

#pragma mark - action

- (void)onBtnClick:(UIButton *)btn {
    if (btn == self.lineFrameBtn) {
        self.topDrawView.image = [self drawLineImage];
    }
}

#pragma mark - delegate

#pragma mark - private

- (UIImage *)drawLineImage {
    UIGraphicsBeginImageContextWithOptions(self.topDrawView.size, NO, self.view.contentScaleFactor);
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextTranslateCTM(context, 0, -self.topDrawView.height);
    
    CGPoint textPosition = CGPointMake(10, 10);
    double width = self.topDrawView.width - textPosition.x;
    CFAttributedStringRef attrString = (__bridge CFAttributedStringRef)[self getAttributeStrWithStr:@"一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十"];
    // Initialize those variables.
    
    // Create a typesetter using the attributed string.
    CTTypesetterRef typesetter = CTTypesetterCreateWithAttributedString(attrString);
    
    // Find a break for line from the beginning of the string to the given width.
    CFIndex start = 0;
    CFIndex count = CTTypesetterSuggestLineBreak(typesetter, start, width);
    
    // Use the returned character count (to the break) to create the line.
    CTLineRef line = CTTypesetterCreateLine(typesetter, CFRangeMake(start, count));
    
    // Get the offset needed to center the line.
    float flush = 0.5; // centered
    double penOffset = CTLineGetPenOffsetForFlush(line, flush, width);
    
    // Move the given text drawing position by the calculated offset and draw the line.
    CGContextSetTextPosition(context, textPosition.x + penOffset, textPosition.y);
    CTLineDraw(line, context);
    
    // Move the index beyond the line break.
    start += count;

    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}


- (NSAttributedString *)getAttributeStrWithStr:(NSString *)contentStr {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    dict[NSForegroundColorAttributeName] = [UIColor redColor];
    dict[NSKernAttributeName] = @(0.1);
    dict[NSBackgroundColorAttributeName] = [UIColor lightGrayColor];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    paragraphStyle.firstLineHeadIndent = [[UIFont systemFontOfSize:14] pointSize] * 2;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.lineSpacing = 1.0;
    
    paragraphStyle.paragraphSpacing = 10;
    paragraphStyle.alignment = NSTextAlignmentJustified;
    dict[NSParagraphStyleAttributeName] = paragraphStyle;
    
    NSAttributedString *ret = [[NSAttributedString alloc] initWithString:contentStr
                                                              attributes:dict];
    return ret;
}
@end
