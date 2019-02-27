//
//  SSPageView.m
//  LearnCoreText
//
//  Created by loyinglin on 2018/10/24.
//  Copyright © 2018 loyinglin. All rights reserved.
//

#import "SSPageView.h"

@implementation SSPageView
{
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

//    CGContextRef context = UIGraphicsGetCurrentContext();
//    NSLog(@"CGContext default matrix %@", NSStringFromCGAffineTransform(CGContextGetCTM(context)));
//    CGContextSaveGState(context);
//    CGContextTranslateCTM(context, 0, self.bounds.size.height);
//    CGContextScaleCTM(context, 1.0, -1.0);
//    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:@"测试文本" attributes:@{
//                                                                                                  NSForegroundColorAttributeName:[UIColor whiteColor],
//                                                                                                  NSFontAttributeName:[UIFont systemFontOfSize:14],
//                                                                                                  }];
//    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef) attrStr); // 根据富文本创建排版类CTFramesetterRef
//    UIBezierPath * bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 100, 20)];
//    CTFrameRef frameRef = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), bezierPath.CGPath, NULL); // 创建排版数据
//    CTFrameDraw(frameRef, context);
//    CGContextRestoreGState(context);
//
//
//    NSLog(@"CGContext default CTM matrix %@", NSStringFromCGAffineTransform(CGContextGetCTM(context)));
//    UILabel *testLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
//    testLabel.text = @"测试文本";
//    testLabel.font = [UIFont systemFontOfSize:14];
//    testLabel.textColor = [UIColor whiteColor];
//    [testLabel.layer renderInContext:context];

//    return ;
    
//    UIImage *image = [UIImage imageNamed:@"panda.png"];
//    CGContextDrawImage(context, CGRectMake(0, 0, image.size.width / 2, image.size.height / 2), image.CGImage);
    
    if (self.pageData && self.pageData.frameRef) {
        CGContextRef context = UIGraphicsGetCurrentContext();
//        NSLog(@"CGContext default matrix %@", NSStringFromCGAffineTransform(CGContextGetCTM(context)));
//        CGContextSetTextMatrix(context, CGAffineTransformIdentity);
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextTranslateCTM(context, 0, -self.bounds.size.height);
        
//        NSLog(@"CGContext reset matrix %@", NSStringFromCGAffineTransform(CGContextGetCTM(context)));
        
        CTFrameDraw(self.pageData.frameRef, context);
    }
    else {


        
    }
}

@end
