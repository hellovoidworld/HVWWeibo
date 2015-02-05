#import <Foundation/Foundation.h>

@implementation NSDictionary (Log)

/** 本地化显示 */
- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *str = [NSMutableString string];
    
    [str appendString:@"{\n"];
    
    // 遍历字典
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [str appendFormat:@"\t%@ = %@,\n", key, obj];
    }];
    
    [str appendString:@"}"];
    
    // 取出最后一个“，”
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    if (range.length) {
        [str deleteCharactersInRange:range];
    }
    
    return str;
}

@end

@implementation NSArray (Log)

- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *str = [NSMutableString string];
    
    [str appendString:@"[\n"];
    
    // 遍历数组所有元素
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [str appendFormat:@"%@, \n", obj];
    }];
    
    [str appendString:@"]"];
    
    // 取出最后一个“，”
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    if (range.length) {
        [str deleteCharactersInRange:range];
    }
    
    return str;
}

@end