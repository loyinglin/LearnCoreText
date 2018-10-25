//
//  SSTransformManager.m
//  LearnCoreText
//
//  Created by loyinglin on 2018/10/24.
//  Copyright © 2018 loyinglin. All rights reserved.
//

#import "SSTransformManager.h"

@implementation SSTransformManager


- (NSString *)attributeStrConvertToHtmlStr:(NSAttributedString *)attributeStr {
    NSDictionary *dic = @{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,
                          NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]};
    NSData *htmlData = [attributeStr dataFromRange:NSMakeRange(0, attributeStr.length)
                                documentAttributes:dic
                                             error:nil];
    
    return [[NSString alloc] initWithData:htmlData
                                 encoding:NSUTF8StringEncoding];
}

- (NSAttributedString *)htmlStrConvertToAttributeStr:(NSString *)htmlStr {
    return [[NSAttributedString alloc] initWithData:[htmlStr dataUsingEncoding:NSUnicodeStringEncoding]
                                            options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}
                                 documentAttributes:nil
                                              error:nil];
}



@end
