//
//  FFRoutes.h
//  FFRoutes
//
//  Created by 张玲玉 on 2018/7/26.
//

#import <Foundation/Foundation.h>

@interface FFRoutes : NSObject

/**
 创建路由

 @param scheme URL scheme
 @return 单例
 */
+ (instancetype)routesForScheme:(NSString *)scheme;

/**
 添加路由

 @param pattern 模板
 @param handlerBlock 参数返回Block
 */
- (void)addRoute:(NSString *)pattern
         handler:(BOOL (^)(NSDictionary<NSString *, id> *parameters))handlerBlock;

/**
 跳转

 @param URL 跳转URL
 @return 是否成功
 */
- (BOOL)routeURL:(NSURL *)URL;

@end
