//
//  ContentViewController.m
//  LearnHTMLtoNSString
//
//  Created by loyinglin on 2018/10/23.
//  Copyright © 2018 loyinglin. All rights reserved.
//

#import "ContentViewController.h"
#import "SSTransformManager.h"
#import "SSPageView.h"
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
    
    SSPageView *pageView = [[SSPageView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    [self.view addSubview:pageView];
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
    
    SSTransformManager *transformManager = [[SSTransformManager alloc] init];
    NSAttributedString *attrStr = [transformManager htmlStrConvertToAttributeStr:string];
    
    UILabel *label = [[UILabel alloc] init];
    label.attributedText = attrStr;
    [label setFrame:CGRectMake(100, 180, 200, 200)];
    label.numberOfLines = 0;
    [label setFrame:CGRectMake(100, 180, 200, 200)];
    [label sizeToFit];
    
    [self.view addSubview:label];
}



@end
