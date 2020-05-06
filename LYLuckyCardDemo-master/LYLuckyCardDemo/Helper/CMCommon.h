//
//  CMCommon.h

#import <Foundation/Foundation.h>

@interface CMCommon : NSObject

/// 判断字符串是否为空
+ (BOOL)stringIsNull:(id)str;

/**
 *判断是不是空数组，如果返回yes，代表该该数组为空
 */
+ (BOOL)arryIsNull:(NSArray *)array;


/**
 *  读取本地JSON文件
 *
 */
+ (NSDictionary *)readLocalFileWithName:(NSString *)name;


@end
