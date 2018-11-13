//
//  SSDataManager.m
//  LearnCoreText
//
//  Created by loyinglin on 2018/10/24.
//  Copyright © 2018 loyinglin. All rights reserved.
//

#import "SSDataManager.h"
#import "SSTransformManager.h"

@implementation SSDataManager

- (SSChapterData *)syncGetRemoteChatperDataWithBookId:(NSString *)bookId chapterId:(NSString *)chapterId {
    return [self getFakeChapterDataWithId:chapterId];
}

- (void)asyncGetRemoteChatperDataWithBookId:(NSString *)bookId chapterId:(NSString *)chapterId callback:(SSDataCallback)callback {
    SSChapterData *chapterData = [self getFakeChapterDataWithId:chapterId];
    if (callback) {
        float delayTime = 0.01;
//        if ([chapterId intValue] != 1) { //
//            delayTime = 10;
//        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            callback(chapterData);
        });
    }
}

- (SSChapterData *)getFakeChapterDataWithId:(NSString *)chapterId {
    NSString *fakeStr = @"<article><p></p><p>萧慕白淡然一笑：“哦，是吗？那真是很巧，我也是。”</p><p>俩人四目相对的一瞬间，站在一旁的苏墨瞳只感觉电光火石，剑拔弩张，战争一触即发。</p><p>可是这么坦白的两个人，怎么能让苏墨瞳招架的住啊。趁着两人暗暗较劲的空档，她捂住顾美的嘴，托着顾美还有她自己的行李箱，一溜烟的跑了。</p><p>惹不起只好躲得起了，苏墨瞳一路狂奔，顾美口中发出呜呜的挣扎声，苏墨瞳也置之不理，当务之急，是马上离开这个地方。</p><p>天大地大，竟然没有她苏墨瞳的容身之所吗？她才不信这个邪。</p><p>顾美跑不动了，挣脱开了苏墨瞳的禁锢，体力不支的她坐在街边的花坛上大口的喘着粗气，“墨瞳，不行了，别跑了，再跑我就心脏脱落猝死了。”</p><p>苏墨瞳也是气喘如牛，她望了望四周，确定江一寒和萧慕白没有追上来后，才放心的挨着顾美坐下，上气不接下气的质问道：“是不是你把我出卖了？”</p><p>顾美连连摆手，一脸的委屈，“真的不是我，是江总偷听到了咱俩的通话，才临时做决定来上海的。”</p><p>“那你们怎么又会出现在这家酒店呢？”苏墨瞳继续追问道，她被顾美出卖很多次了，当然不会相信她的说辞。</p><p>顾美举着手保证，“墨瞳，在盛世豪景遇到你完全是个意外，是上海分部安排我和江总入住这家酒店的，你说，怎么就那么巧。”</p><p>苏墨瞳横眉，巧？哪里巧？你明明知道我也入住这家酒店，既然江一寒也要入住进来，你就不会给我通风报信的吗？你肯定是被江一寒收买了，还死活不肯承认？</p><p>苏墨瞳的眯着眼，怀疑的眼神上上下下的打量着顾美，顾美被盯的冷汗直冒，干笑了几声，心虚的垂下头。</p><p>“顾美，你先回去吧，要是萧慕白或者是江一寒和你问起我来，你就说我去了机场，要回汉川。”苏墨瞳站起身，扬起头呼出一口浊气，烈日的阳光照射在柏油马路上，升腾起的热气，让她的心情也越发的烦闷起来。</p><p>“墨瞳，你真的要回去啊？”顾美扯着苏墨瞳的衣角，怏怏的问道。</p><p>苏墨瞳眉头一拧，阴阳怪气的厉声叫道：“是又怎么样？”</p><p>一辆出租车正好停在了苏墨瞳的脚边，她冲着司机师傅示意了下，扔下顾美钻进车里，绝尘而去。她当然不会回汉川，既然上海七日游泡汤了，那就改苏杭七日游吧，想到这，她吩咐司机师傅朝着火车站的方向开去。</p><p>另一边，发现顾美和苏墨瞳已经不见踪影的的俩个男人也在和时间进行着一场赛跑。</p><p>俩个人并肩走向停车场，各自打开车门，相视一笑。</p><p>“我一定会比你先找到苏墨瞳的。”萧慕白单手支着车门，胸有成竹。</p><p>“那我们就拭目以待吧。”江一寒耸着肩膀，钻进了驾驶位。</p><p>两辆轿车一前一后的滑出停车场，一个向左，一个向右，消失在车水马龙的闹市区。</p><p>上海这么大，到底去哪里找苏墨瞳呢？</p><p>萧慕白焦急的一边转着方向盘，一边四处瞧望。苏墨瞳啊苏墨瞳，你知不知道你越是逃的远远的，越是能激起我把你抓回，然后绑在身边的欲望。</p><p>我已经弄丢了你一次，我怎么还能弄丢你第二次呢。</p><p>拐过一个街角，眼尖的他看到了坐在花坛旁，闷闷不乐的顾美，他认得她，是苏墨瞳的闺蜜，也是江一寒的秘书。</p><p>一个急刹车，萧慕白落下车窗喊了一声，“喂。”</p><p>顾美顺着声音抬起头，萧慕白剑眉一挑，沉声问道：“墨瞳去哪了，你一定知道吧。”</p><p>“那个……那个……”顾美语塞，她抬起微颤的手指随便指了个方向，“墨瞳朝那个方向走了。”</p><p>“谢谢。”</p><p>萧慕白扬起一个微笑，轿车再一次启动，车轮卷起的灰尘迷了顾美的眼。她一边揉着眼睛一边气的跺脚，就算我说的不是实话，你也不用现在就报复我吧。</p><p>苏墨瞳这时已经到达了火车站，她付好了车钱跳下了车，顿时被上海火车站这人山人海的场面吓的一呆。</p><p>话说现在也不是春运和长假啊，都挤在火车站干什么啊？</p><p>排队买票的队伍太长，一眼都望不到售票窗口。苏墨瞳百无聊赖的站在队尾，一边等，一边习惯性的用脚尖在大理石地面上画圈圈。</p><p>江一寒真的是特意来上海找她的吗？</p><p>这个念头一冒出来，苏墨瞳立刻鄙视了自己千百遍，不已经决定和他划清界限了吗？不已经决定和他老死不相往来了吗？怎么一见到他人，那颗坚定的心又动摇了？</p><p>哎！苏墨瞳你醒醒吧，求求你醒醒好不好？</p><p>手臂就是这时，突然被一双强有力的大手拽住，苏墨瞳侧目的瞬间，又被扯进了一个宽厚的怀抱，强有力的心跳声震击着她的耳膜，迷人的声线响在她的耳畔，“看你这回，还往哪里跑？”</p><p>又是江一寒！！</p><p>苏墨瞳心中小鹿乱撞，江一寒怎么就能轻而易举的找到她？她明明对顾美也说了谎呢。</p><p>苏墨瞳用尽了全力挣脱开了这个怀抱，退后了一步，和江一寒保持着安全的距离，冷若冰霜的面庞上没有丝毫的感情色彩。“江总，您找我有事吗？”</p><p>“我……”江一寒一时语塞，他找苏墨瞳有什么事吗？好像是没有的。能看到苏墨瞳神采奕奕完好无缺的站在这里他也就不虚此行了。就算苏墨瞳对他冷眼相对，也燃不起他胸口处气愤的火焰。</p><p>他忘记了唐洛川给他的那三拳，也忘记了唐洛川对他的警告。此刻他的眼，他的脑，他的心，唯有苏墨瞳。</p><p>“既然没事我就不奉陪了。”苏墨瞳微笑颔首，拖着行李，站在了另一侧的购票队伍中。</p><p>江一寒一怔，第一次觉得自己是这般无用，苏墨瞳还没怎么样呢，他先乱了阵脚。他跟上苏墨瞳，静静的站在她的身后，随着队伍一点点的向前移动。偶尔，会有看起来不像是善类的几个男子穿梭在队伍里。这时，江一寒都会用手臂圈成一个保护圈，把苏墨瞳牢牢的圈在中央，保护起来。</p></article>";
    SSTransformManager *tranformMgr = [[SSTransformManager alloc] init];
    NSAttributedString *attrStr = [tranformMgr htmlStrConvertToAttributeStr:fakeStr];
    SSChapterData *chapterData = [[SSChapterData alloc] init];
    chapterData.chapterId = chapterId;
    chapterData.lastChapterId = [chapterId intValue] > 0 ? [NSString stringWithFormat:@"%d", [chapterId intValue] - 1] : nil;
    chapterData.nextChapterId = [chapterId intValue] < 3 ? [NSString stringWithFormat:@"%d", [chapterId intValue] + 1] : nil;
    chapterData.chapterTitle = [NSString stringWithFormat:@"第%@章（测试标题）", chapterId];
    chapterData.strContent = attrStr.string;
    
    return chapterData;
}

- (NSString *)stringByReplaceReturnWithString:(NSString *)str {
    return  [str stringByReplacingOccurrencesOfString:@"\\s*\\n+\\s*"
                                           withString:@"\n　　"
                                              options:NSRegularExpressionSearch // 匹配正则表达式
                                                range:NSMakeRange (0, str.length)];
}
@end
