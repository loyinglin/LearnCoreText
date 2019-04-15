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

@property (nonatomic, strong) UIButton *normalFrameBtn;
@property (nonatomic, strong) UIButton *lineFrameBtn;
@property (nonatomic, strong) UIButton *columnFrameBtn;
@property (nonatomic, strong) UIButton *nonrectangleFrameBtn;
@property (nonatomic, strong) UIButton *kernBtn; // test char space
@property (nonatomic, strong) UIButton *attachmentBtn;
@property (nonatomic, strong) UIButton *rangeOfFontBtn;
@property (nonatomic, strong) UIButton *colorChangeBtn;
@property (nonatomic, strong) UIButton *ctLineBtn;
@property (nonatomic, strong) UIButton *ctRunBtn;
@property (nonatomic, strong) UIButton *fillAndStrokeColorBtn;
@property (nonatomic, strong) UIButton *textWithEmpytLayoutBtn;
@property (nonatomic, strong) UIButton *calculateLineBtn;

@property (nonatomic, strong) UIScrollView *containerScrollView;

@property (nonatomic, strong) UIImageView *topDrawView;

@property (nonatomic, assign) CTFrameRef frameRef;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.containerScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.containerScrollView];
    
    self.topDrawView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60, self.view.width, 200)];
    [self.view addSubview:self.topDrawView];
    
    [self customInit];
    
    self.topDrawView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
    [self.topDrawView addGestureRecognizer:tap];
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
        [btn setTitle:@"正常布局" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.containerScrollView addSubview:btn];
        [btn addTarget:self action:@selector(onBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        startY += CGRectGetHeight(btn.bounds) + margin;
        
        self.normalFrameBtn = btn;
    }
    
    
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, startY, 200, 20)];
        [btn setTitle:@"单行布局" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.containerScrollView addSubview:btn];
        [btn addTarget:self action:@selector(onBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        startY += CGRectGetHeight(btn.bounds) + margin;
        
        self.lineFrameBtn = btn;
    }
    
    
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, startY, 200, 20)];
        [btn setTitle:@"列布局" forState:UIControlStateNormal]; // 1
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.containerScrollView addSubview:btn];
        [btn addTarget:self action:@selector(onBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        startY += CGRectGetHeight(btn.bounds) + margin;
        
        self.columnFrameBtn = btn; // 2
    }
    
    
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, startY, 200, 20)];
        [btn setTitle:@"不规则布局" forState:UIControlStateNormal]; // 1
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.containerScrollView addSubview:btn];
        [btn addTarget:self action:@selector(onBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        startY += CGRectGetHeight(btn.bounds) + margin;
        
        self.nonrectangleFrameBtn = btn; // 2
    }
    
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, startY, 200, 20)];
        [btn setTitle:@"字间距" forState:UIControlStateNormal]; // 1
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.containerScrollView addSubview:btn];
        [btn addTarget:self action:@selector(onBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        startY += CGRectGetHeight(btn.bounds) + margin;
        
        self.kernBtn = btn; // 2
    }
    
    
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, startY, 200, 20)];
        [btn setTitle:@"TextKit图文混排" forState:UIControlStateNormal]; // 1
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.containerScrollView addSubview:btn];
        [btn addTarget:self action:@selector(onBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        startY += CGRectGetHeight(btn.bounds) + margin;
        
        self.attachmentBtn = btn; // 2
    }
    
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, startY, 200, 20)];
        [btn setTitle:@"字体种类测试" forState:UIControlStateNormal]; // 1
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.containerScrollView addSubview:btn];
        [btn addTarget:self action:@selector(onBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        startY += CGRectGetHeight(btn.bounds) + margin;
        
        self.rangeOfFontBtn = btn; // 2
    }
    
    
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, startY, 200, 20)];
        [btn setTitle:@"改变已有颜色" forState:UIControlStateNormal]; // 1
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.containerScrollView addSubview:btn];
        [btn addTarget:self action:@selector(onBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        startY += CGRectGetHeight(btn.bounds) + margin;
        
        self.colorChangeBtn = btn; // 2
    }
    
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, startY, 200, 20)];
        [btn setTitle:@"CTLine排版" forState:UIControlStateNormal]; // 1
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.containerScrollView addSubview:btn];
        [btn addTarget:self action:@selector(onBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        startY += CGRectGetHeight(btn.bounds) + margin;
        
        self.ctLineBtn = btn; // 2
    }
    
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, startY, 200, 20)];
        [btn setTitle:@"CTRun排版" forState:UIControlStateNormal]; // 1
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.containerScrollView addSubview:btn];
        [btn addTarget:self action:@selector(onBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        startY += CGRectGetHeight(btn.bounds) + margin;
        
        self.ctRunBtn = btn; // 2
    }
    
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, startY, 200, 20)];
        [btn setTitle:@"Fill 和 Stroke Color" forState:UIControlStateNormal]; // 1
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.containerScrollView addSubview:btn];
        [btn addTarget:self action:@selector(onBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        startY += CGRectGetHeight(btn.bounds) + margin;
        
        self.fillAndStrokeColorBtn = btn; // 2
    }
    
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, startY, 200, 20)];
        [btn setTitle:@"图文混排" forState:UIControlStateNormal]; // 1
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.containerScrollView addSubview:btn];
        [btn addTarget:self action:@selector(onBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        startY += CGRectGetHeight(btn.bounds) + margin;
        
        self.textWithEmpytLayoutBtn = btn; // 2
    }
    
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, startY, 200, 20)];
        [btn setTitle:@"计算位置" forState:UIControlStateNormal]; // 1
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.containerScrollView addSubview:btn];
        [btn addTarget:self action:@selector(onBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        startY += CGRectGetHeight(btn.bounds) + margin;
        
        self.calculateLineBtn = btn; // 2
    }
    
    self.containerScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds), startY);
}



#pragma mark - init

#pragma mark - getter&setter

#pragma mark - action

- (void)onBtnClick:(UIButton *)btn {
    if (btn == self.normalFrameBtn) {
        self.topDrawView.image = [self drawNormalImage];
    }
    else if (btn == self.lineFrameBtn) {
        self.topDrawView.image = [self drawLineImage];
    }
    else if (btn == self.columnFrameBtn) {
        self.topDrawView.image = [self drawColumnFrameImage];
    }
    else if (btn == self.nonrectangleFrameBtn) {
        self.topDrawView.image = [self drawNonrectangularImage];
    }
    else if (btn == self.kernBtn) {
        self.topDrawView.image = [self drawKernImage];
    }
    else if (btn == self.attachmentBtn) {
        self.topDrawView.image = [self drawAttachmentImage];
    }
    else if (btn == self.rangeOfFontBtn) {
        self.topDrawView.image = [self drawRangeOfFontImage];
    }
    else if (btn == self.colorChangeBtn) {
        self.topDrawView.image = [self drawColorChangeImage];
    }
    else if (btn == self.ctLineBtn) {
        self.topDrawView.image = [self drawCTLineImage];
    }
    else if (btn == self.ctRunBtn) {
        self.topDrawView.image = [self drawCTRunImage];
    }
    else if (btn == self.fillAndStrokeColorBtn) {
        self.topDrawView.image = [self drawFillAndStrokeColorImage];
    }
    else if (btn == self.textWithEmpytLayoutBtn) {
        self.topDrawView.image = [self drawTextWithEmptyLayoutImage];
    }
    else if (btn == self.calculateLineBtn) {
        self.topDrawView.image = [self drawCalucateImage];
    }
}

#pragma mark - delegate

#pragma mark - private

- (UIImage *)drawNormalImage {
    UIGraphicsBeginImageContextWithOptions(self.topDrawView.size, NO, [UIScreen mainScreen].scale);
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextTranslateCTM(context, 0, -self.topDrawView.height);
    
    NSString *str = @"一二三四五六七八九十一二三四五六七八九十\n一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十";
    CFMutableAttributedStringRef attrString = (__bridge CFMutableAttributedStringRef)[self getNormalMutableAttributeStrWithStr:str];

    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString(attrString);
    UIBezierPath * bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(30, 0, self.topDrawView.width / 2, self.topDrawView.height / 2)];
    CTFrameRef frameRef = CTFramesetterCreateFrame(frameSetter,
                                                   CFRangeMake(0, 0),
                                                   bezierPath.CGPath, NULL);
    CTFrameDraw(frameRef, context);
    // create 和 release 一一对应
    CFRelease(frameSetter);
    CFRelease(frameRef);
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}


- (NSMutableAttributedString *)getNormalMutableAttributeStrWithStr:(NSString *)contentStr {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    dict[NSForegroundColorAttributeName] = [UIColor redColor];
    dict[NSKernAttributeName] = @(0.1);
    dict[NSBackgroundColorAttributeName] = [UIColor lightGrayColor];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.lineSpacing = 1.0;
    
//    paragraphStyle.paragraphSpacing = 10;
    paragraphStyle.alignment = NSTextAlignmentJustified;
    dict[NSParagraphStyleAttributeName] = paragraphStyle;
    
    NSMutableAttributedString *ret = [[NSMutableAttributedString alloc] initWithString:contentStr
                                                              attributes:dict];
    return ret;
}

- (UIImage *)drawLineImage {
    UIGraphicsBeginImageContextWithOptions(self.topDrawView.size, NO, [UIScreen mainScreen].scale);
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextTranslateCTM(context, 0, -self.topDrawView.height);
    
    // CTLine
    CFAttributedStringRef attrString = (__bridge CFAttributedStringRef)[self getAttributeStrWithStr:@"一二三四五六七八九十"];
    CTTypesetterRef typesetter = CTTypesetterCreateWithAttributedString(attrString);
    CFIndex count = CTTypesetterSuggestLineBreak(typesetter, 0, 150); // WIDTH=150
    CTLineRef line = CTTypesetterCreateLine(typesetter, CFRangeMake(0, count));
    CGContextSetTextPosition(context, 10, 10);
    CTLineDraw(line, context);

    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}


- (NSAttributedString *)getAttributeStrWithStr:(NSString *)contentStr {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:18];
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

- (UIImage *)drawColumnFrameImage {
    // Initialize a graphics context in iOS.
    UIGraphicsBeginImageContextWithOptions(self.topDrawView.size, NO, [UIScreen mainScreen].scale);
   
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextTranslateCTM(context, 0, -self.topDrawView.height);
    
    CFAttributedStringRef attrString = (__bridge CFAttributedStringRef)[self getColumnAttrStrWithStr:@"一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十"];
    // Initialize those variables.
    // Create the framesetter with the attributed string.
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(attrString);
    
    BOOL isUseFrameAttribute = YES;
    
    if (isUseFrameAttribute) {
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(30, 30, self.topDrawView.width / 2, self.topDrawView.height / 2)];
        CTFrameRef frameRef = CTFramesetterCreateFrame(framesetter,
                                                       CFRangeMake(0, 0),
                                                       bezierPath.CGPath,
                                                       (CFDictionaryRef)@{(NSString *)kCTFrameProgressionAttributeName:@(kCTFrameProgressionLeftToRight)});
        CTFrameDraw(frameRef, context);
    }
    else {
        // Call createColumnsWithColumnCount function to create an array of
        // three paths (columns).
        CFArrayRef columnPaths = [self createColumnsWithColumnCount:10];
        
        CFIndex pathCount = CFArrayGetCount(columnPaths);
        CFIndex startIndex = 0;
        int column;
        
        // Create a frame for each column (path).
        for (column = 0; column < pathCount; column++) {
            // Get the path for this column.
            CGPathRef path = (CGPathRef)CFArrayGetValueAtIndex(columnPaths, column);
            
            // Create a frame for this column and draw it.
            CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(startIndex, 0), path, NULL);
            CTFrameDraw(frame, context);
            
            // Start the next frame at the first character not visible in this frame.
            CFRange frameRange = CTFrameGetVisibleStringRange(frame);
            startIndex += frameRange.length;
            CFRelease(frame);
            
        }
        CFRelease(columnPaths);
    }
    
    CFRelease(framesetter);
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

- (NSAttributedString *)getColumnAttrStrWithStr:(NSString *)contentStr {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    dict[NSForegroundColorAttributeName] = [UIColor redColor];
    dict[NSBackgroundColorAttributeName] = [UIColor lightGrayColor];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.lineSpacing = 1.0;
    paragraphStyle.paragraphSpacing = 10;
    paragraphStyle.alignment = NSTextAlignmentJustified;
    dict[NSParagraphStyleAttributeName] = paragraphStyle;
    
    NSAttributedString *ret = [[NSAttributedString alloc] initWithString:contentStr
                                                              attributes:dict];
    return ret;
}

- (CFArrayRef)createColumnsWithColumnCount:(int)columnCount
{
    int column;
    
    CGRect* columnRects = (CGRect*)calloc(columnCount, sizeof(*columnRects));
    // Set the first column to cover the entire view.
    columnRects[0] = CGRectMake(40, 0, 15 * columnCount, self.topDrawView.height - 22 * 2);
    
    // Divide the columns equally across the frame's width.
    CGFloat columnWidth = 15; // CGRectGetWidth(self.topDrawView.bounds) / columnCount;
    for (column = 0; column < columnCount - 1; column++) {
        CGRectDivide(columnRects[column], &columnRects[column],
                     &columnRects[column + 1], columnWidth, CGRectMinXEdge);
    }
    
    // Inset all columns by a few pixels of margin.
    for (column = 0; column < columnCount; column++) {
        columnRects[column] = CGRectInset(columnRects[column], 0, 22);
    }
    
    // Create an array of layout paths, one for each column.
    CFMutableArrayRef array =
    CFArrayCreateMutable(kCFAllocatorDefault,
                         columnCount, &kCFTypeArrayCallBacks);
    
    for (column = 0; column < columnCount; column++) {
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, NULL, columnRects[column]);
        CFArrayInsertValueAtIndex(array, column, path);
        CFRelease(path);
    }
    free(columnRects);
    return array;
}


// Create a path in the shape of a donut.
static void AddSquashedDonutPath(CGMutablePathRef path,
                                 const CGAffineTransform *m, CGRect rect)
{
    CGFloat width = CGRectGetWidth(rect);
    CGFloat height = CGRectGetHeight(rect);
    
    CGFloat radiusH = width / 3.0;
    CGFloat radiusV = height / 3.0;
    
    CGPathMoveToPoint( path, m, rect.origin.x, rect.origin.y + height - radiusV);
    CGPathAddQuadCurveToPoint( path, m, rect.origin.x, rect.origin.y + height,
                              rect.origin.x + radiusH, rect.origin.y + height);
    CGPathAddLineToPoint( path, m, rect.origin.x + width - radiusH,
                         rect.origin.y + height);
    CGPathAddQuadCurveToPoint( path, m, rect.origin.x + width,
                              rect.origin.y + height,
                              rect.origin.x + width,
                              rect.origin.y + height - radiusV);
    CGPathAddLineToPoint( path, m, rect.origin.x + width,
                         rect.origin.y + radiusV);
    CGPathAddQuadCurveToPoint( path, m, rect.origin.x + width, rect.origin.y,
                              rect.origin.x + width - radiusH, rect.origin.y);
    CGPathAddLineToPoint( path, m, rect.origin.x + radiusH, rect.origin.y);
    CGPathAddQuadCurveToPoint( path, m, rect.origin.x, rect.origin.y,
                              rect.origin.x, rect.origin.y + radiusV);
    CGPathCloseSubpath( path);
    
    CGPathAddEllipseInRect( path, m,
                           CGRectMake( rect.origin.x + width / 2.0 - width / 5.0,
                                      rect.origin.y + height / 2.0 - height / 5.0,
                                      width / 5.0 * 2.0, height / 5.0 * 2.0));
}

// Generate the path outside of the drawRect call so the path is calculated only once.
- (NSArray *)paths
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect bounds = self.topDrawView.bounds;
    bounds = CGRectInset(bounds, 10.0, 10.0);
    AddSquashedDonutPath(path, NULL, bounds);
    
    NSMutableArray *result =
    [NSMutableArray arrayWithObject:CFBridgingRelease(path)];
    return result;
}

- (UIImage *)drawNonrectangularImage {
    UIGraphicsBeginImageContextWithOptions(self.topDrawView.size, NO, [UIScreen mainScreen].scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextTranslateCTM(context, 0, -self.topDrawView.height);
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithAttributedString:[self getColumnAttrStrWithStr:@"123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"]];
    CFMutableAttributedStringRef attrString = (__bridge CFMutableAttributedStringRef)attrStr;
    
    // Create a color that will be added as an attribute to the attrString.
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat components[] = { 1.0, 0.0, 0.0, 0.8 };
    CGColorRef red = CGColorCreate(rgbColorSpace, components);
    CGColorSpaceRelease(rgbColorSpace);
    
    // Set the color of the first 13 chars to red.
    CFAttributedStringSetAttribute(attrString, CFRangeMake(0, 13),
                                   kCTForegroundColorAttributeName, red);
    
    // Create the framesetter with the attributed string.
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(attrString);
    
    // Create the array of paths in which to draw the text.
    NSArray *paths = [self paths];
    
    CFIndex startIndex = 0;
    
    // In OS X, use NSColor instead of UIColor.
#define GREEN_COLOR [UIColor greenColor]
#define YELLOW_COLOR [UIColor yellowColor]
#define BLACK_COLOR [UIColor blackColor]
    
    // For each path in the array of paths...
    for (id object in paths) {
        CGPathRef path = (__bridge CGPathRef)object;
        
        // Set the background of the path to yellow.
        CGContextSetFillColorWithColor(context, [YELLOW_COLOR CGColor]);
        
        CGContextAddPath(context, path);
        CGContextFillPath(context);
        
        CGContextDrawPath(context, kCGPathStroke);
        
        // Create a frame for this path and draw the text.
        CTFrameRef frame = CTFramesetterCreateFrame(framesetter,
                                                    CFRangeMake(startIndex, 0), path, NULL);
        CTFrameDraw(frame, context);
        
        // Start the next frame at the first character not visible in this frame.
        CFRange frameRange = CTFrameGetVisibleStringRange(frame);
        startIndex += frameRange.length;
        CFRelease(frame);
    }
    
//    CFRelease(attrString); 不是CF对象创建的，不需要release，否则会crash
    CFRelease(framesetter);
    
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}


- (UIImage *)drawKernImage {
    UIGraphicsBeginImageContextWithOptions(self.topDrawView.size, NO, [UIScreen mainScreen].scale);
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextTranslateCTM(context, 0, -self.topDrawView.height);
    
    CGPoint textPosition = CGPointMake(10, 10);
    double width = self.topDrawView.width - textPosition.x;
    NSString *contentStr = @"一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六";
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    dict[NSForegroundColorAttributeName] = [UIColor redColor];
    dict[NSKernAttributeName] = @(0);
    dict[NSBackgroundColorAttributeName] = [UIColor lightGrayColor];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.lineSpacing = 1.0;
    paragraphStyle.alignment = NSTextAlignmentJustified;
    dict[NSParagraphStyleAttributeName] = paragraphStyle;
    
    NSMutableAttributedString *ret = [[NSMutableAttributedString alloc] initWithString:contentStr
                                                                     attributes:dict];
    [ret addAttribute:NSKernAttributeName value:@(10) range:NSMakeRange(3, 2)]; // 第4个字符开始，往右的两个字符的字间距，即是4、5、6三个字符的字间距
    
    
    CFAttributedStringRef attrString = (__bridge CFAttributedStringRef)ret;
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


- (UIImage *)drawAttachmentImage {
    UIGraphicsBeginImageContextWithOptions(self.topDrawView.size, NO, [UIScreen mainScreen].scale);
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextScaleCTM(context, 1.0, -1.0);
//    CGContextTranslateCTM(context, 0, -self.topDrawView.height);
    
    CGPoint textPosition = CGPointMake(10, 10);
    double width = self.topDrawView.width - textPosition.x;
    NSMutableAttributedString *mutableAttrStr = [[NSMutableAttributedString alloc] initWithAttributedString:[self getAttributeStrWithStr:@"一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十"]];
    // Initialize those variables.
    
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc ] initWithData:nil ofType:nil];
    UIImage *pandaImage = [ UIImage imageNamed:@"abc"];  //my emoticon image named a.jpg
    
    textAttachment.image = pandaImage;
    NSAttributedString * textAttachmentString = [ NSAttributedString attributedStringWithAttachment:textAttachment];
    
    [mutableAttrStr insertAttributedString:textAttachmentString atIndex:5];
    
    CFAttributedStringRef attrString = (__bridge CFAttributedStringRef)mutableAttrStr;
    
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
//    CTLineDraw(line, context);
    
    // Move the index beyond the line break.
    start += count;
    
    [mutableAttrStr drawInRect:self.topDrawView.bounds];
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}



- (UIImage *)drawRangeOfFontImage {
    UIGraphicsBeginImageContextWithOptions(self.topDrawView.size, NO, [UIScreen mainScreen].scale);
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextTranslateCTM(context, 0, -self.topDrawView.height);
    
    CGPoint textPosition = CGPointMake(10, 10);
    double width = self.topDrawView.width - textPosition.x;
    
    NSMutableAttributedString *mutableAttrStr = [[NSMutableAttributedString alloc] init];
    {
        NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:@"字体测试1"
                                                                      attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
        [mutableAttrStr appendAttributedString:attrStr];
    }
    {
        NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:@"字体测试2"
                                                                      attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        [mutableAttrStr appendAttributedString:attrStr];
    }
    {
        NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:@"字体测试3"
                                                                      attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
        [mutableAttrStr appendAttributedString:attrStr];
    }
    {
        NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:@"字体测试4"
                                                                      attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19]}];
        [mutableAttrStr appendAttributedString:attrStr];
    }
    
    CFAttributedStringRef attrString = (__bridge CFAttributedStringRef)mutableAttrStr;
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
    
    CGContextRestoreGState(context); // 这一段很重要，详见https://www.jianshu.com/p/5456a4f21d35
    
    NSRange limitRange = NSMakeRange(0, [mutableAttrStr length]);
    NSRange effectiveRange;
    NSMutableArray *attrArray = [NSMutableArray array];
    
    while (limitRange.length > 0) {
        id attributeValue = [mutableAttrStr attribute:NSFontAttributeName
                                              atIndex:limitRange.location
                                longestEffectiveRange:&effectiveRange
                                              inRange:limitRange];
        [attrArray addObject:attributeValue];
        
        limitRange = NSMakeRange(NSMaxRange(effectiveRange),
                                 NSMaxRange(limitRange) - NSMaxRange(effectiveRange));
    }
    
    if (attrArray) {
        NSString *str = [NSString stringWithFormat:@"一共有%ld种字体", attrArray.count];
        [str drawAtPoint:CGPointMake(100, 100) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    }
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}


- (UIImage *)drawColorChangeImage {
    UIGraphicsBeginImageContextWithOptions(self.topDrawView.size, NO, [UIScreen mainScreen].scale);
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextTranslateCTM(context, 0, -self.topDrawView.height);
    
    CGPoint textPosition = CGPointMake(10, 10);
    double width = self.topDrawView.width - textPosition.x;
    static NSAttributedString *staticAttrStr;
    if (!staticAttrStr) {
        staticAttrStr = [[NSAttributedString alloc] initWithAttributedString:[self getAttributeStrWithStr:@"测试颜色"]];
    }
    else {
        static BOOL test = NO;
        test = !test;
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithAttributedString:staticAttrStr];
        [attr addAttribute:NSForegroundColorAttributeName value:test ? [UIColor redColor] : [UIColor greenColor] range:NSMakeRange(0, staticAttrStr.length)];
        staticAttrStr = attr;
        
//        [staticAttrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:arc4random_uniform(255) / 255.0
//                                                                                         green:arc4random_uniform(255) / 255.0
//                                                                                          blue:arc4random_uniform(255) / 255.0
//                                                                                         alpha:1]
//                              range:NSMakeRange(0, staticAttrStr.length)];
    }
    // Initialize those variables.
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)staticAttrStr); // 根据富文本创建排版类CTFramesetterRef
    UIBezierPath * bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 200, 200)];
    CTFrameRef frameRef = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), bezierPath.CGPath, NULL); // 创建排版数据，第个参数的range.length=0表示放字符直到区域填满
    CTFrameDraw(frameRef, context);
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}


- (UIImage *)drawCTLineImage {
    UIGraphicsBeginImageContextWithOptions(self.topDrawView.size, NO, [UIScreen mainScreen].scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextTranslateCTM(context, 0, -self.topDrawView.height);
    
    NSString *str = @"Guangdong has recently published Several Policies that ";
    CFAttributedStringRef attrString = (__bridge CFAttributedStringRef)[self getAttributeStrWithStr:str];
    
    CTTypesetterRef typesetter = CTTypesetterCreateWithAttributedString(attrString);
    
    CFIndex start = 0;
    CGPoint textPosition = CGPointMake(30, 80);
    double width = 250;
    
    BOOL isCharLineBreak = YES;
    BOOL isJustifiedLine = YES;
    float flush = 0; // centered，可以调整这里的数字0是左对齐，1是右对齐，0.5居中
    while (start < str.length) {
        CFIndex count;
        if (isCharLineBreak) {
            count = CTTypesetterSuggestClusterBreak(typesetter, start, width);
        }
        else {
            count = CTTypesetterSuggestLineBreak(typesetter, start, width);
        }
        CTLineRef line = CTTypesetterCreateLine(typesetter, CFRangeMake(start, count));
        if (isJustifiedLine) {
            line = CTLineCreateJustifiedLine(line, 1, width);
        }
        double penOffset = CTLineGetPenOffsetForFlush(line, flush, width);
        CGContextSetTextPosition(context, textPosition.x + penOffset, self.topDrawView.height - textPosition.y);
        CTLineDraw(line, context);
        textPosition.y += CTLineGetBoundsWithOptions(line, 0).size.height;
        start += count;
    }
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

- (UIImage *)drawCTRunImage {
    UIGraphicsBeginImageContextWithOptions(self.topDrawView.size, NO, [UIScreen mainScreen].scale);
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextTranslateCTM(context, 0, -self.topDrawView.height);
    
    // CTRun
    CFAttributedStringRef attrString = (__bridge CFAttributedStringRef)[self getAttributeStrWithStr:@"一二三四Guangdong has recently published Several五六七八九十"];
    CTTypesetterRef typesetter = CTTypesetterCreateWithAttributedString(attrString);
    CFIndex count = CTTypesetterSuggestLineBreak(typesetter, 0, 300);
    CTLineRef line = CTTypesetterCreateLine(typesetter, CFRangeMake(0, count));
    CFArrayRef runsArr = CTLineGetGlyphRuns(line);
    CFIndex runsCount = CFArrayGetCount(runsArr);
    BOOL isManualDraw = YES;
    
    for (int i = 0; i < runsCount; ++i) {
        CTRunRef run = CFArrayGetValueAtIndex(runsArr, i);
        CGContextSetTextPosition(context, 20, 20);
        if (!isManualDraw) {
            CTRunDraw(run, context, CFRangeMake(0, 0));
        }
        else {
            CFIndex glyphCount = CTRunGetGlyphCount(run);
            CGPoint *positions = calloc(glyphCount, sizeof(CGPoint));
            CTRunGetPositions(run, CFRangeMake(0, 0), positions);
            CGGlyph *glyphs = calloc(glyphCount, sizeof(CGGlyph));
            CTRunGetGlyphs(run, CFRangeMake(0, 0), glyphs);
            CFDictionaryRef attrDic = CTRunGetAttributes(run);
            CTFontRef runFont = CFDictionaryGetValue(attrDic, kCTFontAttributeName);
            CGFontRef cgFont = CTFontCopyGraphicsFont(runFont, NULL);
            CGColorRef fontColor = (CGColorRef)CFDictionaryGetValue(attrDic, NSForegroundColorAttributeName);
            CGFloat fontSize = CTFontGetSize(runFont);
            CGContextSetFont(context, cgFont);
            CGContextSetFontSize(context, fontSize);
            [(__bridge UIColor *)fontColor setFill];
            // CGColorGetComponents(fontColor) 获取到的颜色是空的，包括CGColorGetAlpha
            //        CGContextSetFillColor(context, CGColorGetComponents(fontColor));
            CGContextShowGlyphsAtPositions(context, glyphs, positions, glyphCount);
            free(positions);
            free(glyphs);
        }
    }
    
    CFRelease(line);
    CFRelease(typesetter);
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}


- (UIImage *)drawFillAndStrokeColorImage {
    UIGraphicsBeginImageContextWithOptions(self.topDrawView.size, NO, [UIScreen mainScreen].scale);
    
    NSString *string = @"文字测试";
    NSMutableDictionary *stringAttributes = [NSMutableDictionary dictionary];
    
    // Define the font and fill color
    [stringAttributes setObject: [UIFont systemFontOfSize:100] forKey: NSFontAttributeName];
    [stringAttributes setObject: [UIColor grayColor] forKey: NSForegroundColorAttributeName];
    [stringAttributes setObject: [NSNumber numberWithFloat: 0] forKey: NSStrokeWidthAttributeName];
    [stringAttributes setObject: [UIColor redColor] forKey: NSStrokeColorAttributeName];
    
    [[UIColor grayColor] set];
    
    // Draw the string
    [string drawAtPoint:CGPointMake(0, 50) withAttributes: stringAttributes];

    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}


- (UIImage *)drawTextWithEmptyLayoutImage {
    UIGraphicsBeginImageContextWithOptions(self.topDrawView.size, NO, [UIScreen mainScreen].scale);
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextTranslateCTM(context, 0, -self.topDrawView.height);
    
    NSMutableAttributedString *mutableAttrString = [[NSMutableAttributedString alloc] initWithAttributedString:[self getAttributeStrWithStr:@"图文混排"]];
    [mutableAttrString insertAttributedString:[self getEmtpyAttributeString] atIndex:2];
    
    CFAttributedStringRef attrString = (__bridge CFAttributedStringRef)mutableAttrString;
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString(attrString);
    CGFloat marginX = 30;
    UIBezierPath * bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(marginX, 0, self.topDrawView.width / 2, self.topDrawView.height / 2)];
    CTFrameRef frameRef = CTFramesetterCreateFrame(frameSetter,
                                                   CFRangeMake(0, 0),
                                                   bezierPath.CGPath, NULL);
    CTFrameDraw(frameRef, context);
    // 计算图片所在位置
    CFArrayRef linesArr = CTFrameGetLines(frameRef);
    for (int i = 0; i < CFArrayGetCount(linesArr); ++i) {
        CTLineRef line = CFArrayGetValueAtIndex(linesArr, i);
        CFArrayRef runsArr = CTLineGetGlyphRuns(line);
        for (int j = 0; j < CFArrayGetCount(runsArr); ++j) {
            CTRunRef run = CFArrayGetValueAtIndex(runsArr, j);
            CTRunDelegateRef delegate = CFDictionaryGetValue(CTRunGetAttributes(run), kCTRunDelegateAttributeName);
            if (!delegate) {
                continue;
            }
            NSValue *data = CTRunDelegateGetRefCon(delegate);
            if (!data) {
                continue;
            }
            // 找到添加的特殊字符
            CGSize size = [data CGSizeValue];
            CGFloat offsetX;
            CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, &offsetX);
            
            CGPoint lineOrigin;
            CTFrameGetLineOrigins(frameRef, CFRangeMake(i, 1), &lineOrigin); // 获取第i行的位置
            
            UIImage *image = [UIImage imageNamed:@"abc"];
            CGContextDrawImage(context, CGRectMake(lineOrigin.x + offsetX + marginX, lineOrigin.y, size.width, size.height), image.CGImage);
            // 如果用UIKit的方法进行绘制，会出现上下颠倒的情况
//            [image drawInRect:CGRectMake(lineOrigin.x + offsetX + marginX, lineOrigin.y, size.width, size.height)];
        }
    }
    // create 和 release 一一对应
    CFRelease(frameSetter);
    CFRelease(frameRef);
    
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

static CGFloat ascentCallback(void * refCon){
    NSValue *data = (__bridge NSValue *)refCon;
    return [data CGSizeValue].height;
}

static CGFloat descentCallback(void * refCon){
    return 0;
}

static CGFloat widthCallback(void * refCon){
    NSValue *data = (__bridge NSValue *)refCon;
    return [data CGSizeValue].width;
}


- (NSAttributedString *)getEmtpyAttributeString {
    CTRunDelegateCallbacks callbacks;
    memset(&callbacks, 0, sizeof(CTRunDelegateCallbacks));
    callbacks.version = kCTRunDelegateVersion1;
    callbacks.getAscent = ascentCallback;
    callbacks.getDescent = descentCallback;
    callbacks.getWidth = widthCallback;
    CGSize size = CGSizeMake(50, 50);
    CTRunDelegateRef delegate = CTRunDelegateCreate(&callbacks, (__bridge void *)([NSValue valueWithCGSize:size]));
    NSMutableAttributedString *space = [[NSMutableAttributedString alloc] initWithString:@" " attributes:
  @{NSBackgroundColorAttributeName:[UIColor colorWithRed:0.5 green:1 blue:0.5 alpha:0.5],
    NSForegroundColorAttributeName:[UIColor greenColor],
    }];
    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)space,
                                   CFRangeMake(0, 1),
                                   kCTRunDelegateAttributeName,
                                   delegate);
    CFRelease(delegate);
    return space;
}


- (UIImage *)drawCalucateImage {
    UIGraphicsBeginImageContextWithOptions(self.topDrawView.size, NO, [UIScreen mainScreen].scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextTranslateCTM(context, 0, -self.topDrawView.height);
    
    NSString *str = @"一二三四五六七八九十一二三四五六七八九十\n一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十\n一二三四五六七八九十一二三四五六七八九十\n一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十";
    CFMutableAttributedStringRef attrString = (__bridge CFMutableAttributedStringRef)[self getNormalMutableAttributeStrWithStr:str];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString(attrString);
    UIBezierPath * bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.topDrawView.width, self.topDrawView.height)];
    CTFrameRef frameRef = CTFramesetterCreateFrame(frameSetter,
                                                   CFRangeMake(0, 0),
                                                   bezierPath.CGPath, NULL);
    CTFrameDraw(frameRef, context);
    if (self.frameRef) {
        CFRelease(self.frameRef);
        self.frameRef = NULL;
    }
    self.frameRef = frameRef;
    CFRetain(self.frameRef);
    
    // create 和 release 一一对应
    CFRelease(frameSetter);
    CFRelease(frameRef);
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

- (CFIndex)touchContentOffsetInView:(UIView *)view point:(CGPoint)point frameRef:(CTFrameRef)frameRef {
    CTFrameRef textFrame = frameRef;
    CFArrayRef lines = CTFrameGetLines(textFrame);
    if (!lines) {
        return -1;
    }
    CFIndex count = CFArrayGetCount(lines);
    
    // 获得每一行的origin坐标
    CGPoint origins[count];
    CTFrameGetLineOrigins(textFrame, CFRangeMake(0,0), origins);
    
    // 翻转坐标系
    CGAffineTransform transform =  CGAffineTransformMakeTranslation(0, view.bounds.size.height);
    transform = CGAffineTransformScale(transform, 1.f, -1.f);
    
    CFIndex idx = -1;
    for (int i = 0; i < count; i++) {
        CGPoint linePoint = origins[i];
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        // 获得每一行的CGRect信息
        CGRect flippedRect = [self getLineBounds:line point:linePoint];
        CGRect rect = CGRectApplyAffineTransform(flippedRect, transform);
        
        if (CGRectContainsPoint(rect, point)) {
            // 将点击的坐标转换成相对于当前行的坐标cocoapods
            CGPoint relativePoint = CGPointMake(point.x-CGRectGetMinX(rect),
                                                point.y-CGRectGetMinY(rect));
            // 获得当前点击坐标对应的字符串偏移
            idx = CTLineGetStringIndexForPosition(line, relativePoint);
        }
    }
    return idx;
}

- (CGRect)getLineBounds:(CTLineRef)line point:(CGPoint)point {
    CGFloat ascent = 0.0f;
    CGFloat descent = 0.0f;
    CGFloat leading = 0.0f;
    CGFloat width = (CGFloat)CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    CGFloat height = ascent + descent;
    return CGRectMake(point.x, point.y - descent, width, height);
}

- (void)onTap:(UITapGestureRecognizer *)tap {
    if (tap.view == self.topDrawView) {
        CGPoint point = [tap locationInView:self.topDrawView];
        CFIndex index = [self touchContentOffsetInView:self.topDrawView point:point frameRef:self.frameRef];
        NSLog(@"click index:%ld", (long)index);
    }
}

@end
