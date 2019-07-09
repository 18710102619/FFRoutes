//
//  FFRoute.h
//  FFRoutes
//
//  Created by 张玲玉 on 2018/7/27.
//

#import <Foundation/Foundation.h>
#import "FFRouteResponse.h"
#import "FFRouteRequest.h"

@interface FFRoute : NSObject

@property(nonatomic,copy)NSString *scheme;
@property(nonatomic,copy)BOOL (^handlerBlock)(NSDictionary *parameters);

/**
 创建一个路由

 @param pattern 模板
 @param handlerBlock 参数返回Block
 @return 实例
 */
- (instancetype)initWithPattern:(NSString *)pattern
                   handlerBlock:(BOOL (^)(NSDictionary *parameters))handlerBlock;

/**
 根据路由请求生成路由响应

 @param request 路由请求
 @return 路由响应
 */
- (FFRouteResponse *)routeResponseForRequest:(FFRouteRequest *)request;

- (BOOL)callHandlerBlockWithParameters:(NSDictionary *)parameters;

@end
