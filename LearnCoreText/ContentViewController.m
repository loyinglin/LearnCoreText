//
//  ContentViewController.m
//  LearnHTMLtoNSString
//
//  Created by loyinglin on 2018/10/23.
//  Copyright © 2018 loyinglin. All rights reserved.
//

#import "ContentViewController.h"
@import CoreText;

@interface ContentViewController ()

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *string = @"<p>第64章 保护起来</p><p>萧慕白淡然一笑：“哦，是吗？那真是很巧，我也是。”</p>";
    
    UILabel *label = [[UILabel alloc] init];
    label.text = string;
    label.numberOfLines = 0;
    [label setFrame:CGRectMake(50, 100, 300, 200)];
    [label sizeToFit];
    
    [self.view addSubview:label];
    
//    NSLog(@"%@", string);
    
    [self testHTMLWithStr:string];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)testHTMLWithStr:(NSString *)string {
    
    //    string = @"我的<span style='color:red'>aafaf微</span>我的<span style='color:red'>aafaf微</span>";
    //    string = @"恭喜您获得<font color='red'>8.1元</font>现金奖励 ";
    //    string = @"<ul>\
    //    <li>苹果</li>\
    //    <li>水果</li>\
    //    <li>桃子</li>\
    //    </ul>";
    
    string = @"<header><div class=\"tt-title\">第64章 保护起来</div></header>\n\n\n<article><p>第64章 保护起来</p><p>萧慕白淡然一笑：“哦，是吗？那真是很巧，我也是。”</p><p>俩人四目相对的一瞬间，站在一旁的苏墨瞳只感觉电光火石，剑拔弩张，战争一触即发。</p><p>可是这么坦白的两个人，怎么能让苏墨瞳招架的住啊。趁着两人暗暗较劲的空档，她捂住顾美的嘴，托着顾美还有她自己的行李箱，一溜烟的跑了。</p><p>惹不起只好躲得起了，苏墨瞳一路狂奔，顾美口中发出呜呜的挣扎声，苏墨瞳也置之不理，当务之急，是马上离开这个地方。</p><p>天大地大，竟然没有她苏墨瞳的容身之所吗？她才不信这个邪。</p><p>顾美跑不动了，挣脱开了苏墨瞳的禁锢，体力不支的她坐在街边的花坛上大口的喘着粗气，“墨瞳，不行了，别跑了，再跑我就心脏脱落猝死了。";
    
    NSAttributedString *attrStr = [self htmlStrConvertToAttributeStr:string];
    
    NSArray *pagesArr = [self pagingContentWithAttributeStr:attrStr pageSize:CGSizeMake(100, 100)];
//    NSLog(@"pageArr %@ ", [pagesArr description]);
    
    //    NSString *htmlStr = [self attributeStrConvertToHtmlStr:attrStr];
//    NSLog(@"html %@ ", attrStr.string);
    
    UILabel *label = [[UILabel alloc] init];
    label.attributedText = attrStr;
    [label setFrame:CGRectMake(100, 180, 200, 200)];
    label.numberOfLines = 0;
    [label setFrame:CGRectMake(100, 180, 200, 200)];
    [label sizeToFit];
    
    [self.view addSubview:label];
}

/**
 *  富文本转html字符串
 */
- (NSString *)attributeStrConvertToHtmlStr:(NSAttributedString *)attributeStr {
    NSDictionary *dic = @{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,
                          NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]};
    NSData *htmlData = [attributeStr dataFromRange:NSMakeRange(0, attributeStr.length)
                                documentAttributes:dic
                                             error:nil];
    
    return [[NSString alloc] initWithData:htmlData
                                 encoding:NSUTF8StringEncoding];
}

/**
 *  html字符串转富文本
 */
- (NSAttributedString *)htmlStrConvertToAttributeStr:(NSString *)htmlStr {
    return [[NSAttributedString alloc] initWithData:[htmlStr dataUsingEncoding:NSUnicodeStringEncoding]
                                            options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}
                                 documentAttributes:nil
                                              error:nil];
}


- (NSArray *)pagingContentWithAttributeStr:(NSAttributedString *)attributeStr pageSize:(CGSize)pageSize {
    NSMutableArray<NSValue *> *resultRange = [NSMutableArray array]; // 返回结果数组
    CGRect rect = CGRectMake(0, 0, pageSize.width, pageSize.height); // 每页的显示区域大小
    NSUInteger curIndex = 0; // 分页起点，初始为第0个字符
    while (curIndex < attributeStr.length) { // 没有超过最后的字符串，表明至少剩余一个字符
        NSUInteger maxLength = MIN(1000, attributeStr.length - curIndex); // 1000为最小字体的每页最大数量，减少计算量
        NSAttributedString * subString = [attributeStr attributedSubstringFromRange:NSMakeRange(curIndex, maxLength)]; // 截取字符串
        CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef) subString); // 根据富文本创建排版类CTFramesetterRef
        UIBezierPath * bezierPath = [UIBezierPath bezierPathWithRect:rect];
        CTFrameRef frameRef = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), bezierPath.CGPath, NULL); // 创建排版数据，第个参数的range.length=0表示放字符直到区域填满
        CFRange visiableRange = CTFrameGetVisibleStringRange(frameRef); // 获取当前可见的字符串区域
        NSRange realRange = {curIndex, visiableRange.length}; // 当页在原始字符串中的区域
        [resultRange addObject:[NSValue valueWithRange:realRange]]; // 记录当页结果
        curIndex += realRange.length; //增加索引
        CFRelease(frameRef);
        CFRelease(frameSetter);
    };
    return resultRange;
}


@end
