//
//  CMCommon.m

#import "CMCommon.h"

@implementation CMCommon


+ (BOOL)stringIsNull:(id)str{
    if (str == nil) {
        return YES;
    }
    if ([str isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([str isKindOfClass:[NSString class]]) {
        NSString *validateStr = str;
        if (validateStr.length == 0 || [validateStr isEqualToString:@"<null>"] || [validateStr isEqualToString:@""] || [validateStr isEqualToString:@"null"]) {
            return YES;
        }else
            return NO;
    }else{
        return NO;
    }
    
}

/**
 *判断是不是空数组，如果返回yes，代表该该数组为空
 */
+ (BOOL)arryIsNull:(NSArray *)array{
    if (array != nil && ![array isKindOfClass:[NSNull class]] && array.count != 0){
        //执行array不为空时的操作
        return NO;
    }else{
        return YES;
    }
}

/**
 *  读取本地JSON文件
 *
 */
+ (NSDictionary *)readLocalFileWithName:(NSString *)name{
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}


@end
