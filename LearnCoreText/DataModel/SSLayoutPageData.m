//
//  SSPageData.m
//  LearnCoreText
//
//  Created by loyinglin on 2018/10/24.
//  Copyright © 2018 loyinglin. All rights reserved.
//

#import "SSLayoutPageData.h"

@implementation SSLayoutPageData

-(instancetype)initWithCTFrame:(CTFrameRef)frameRef range:(NSRange)range attributeStr:(NSAttributedString *)attrStr {
    self = [super init];
    if (self) {
        self.frameRef = frameRef;
        self.range = range;
        self.attrStr = attrStr;
    }
    return self;
}

- (void)dealloc {
    if (self.frameRef) {
        CFRelease(self.frameRef);
        self.frameRef = NULL;
    }
}


@end
