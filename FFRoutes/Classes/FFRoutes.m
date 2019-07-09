//
//  FFRoutes.m
//  FFRoutes
//
//  Created by 张玲玉 on 2018/7/26.
//

#import "FFRoutes.h"
#import "FFRoute.h"
#import "FFRouteRequest.h"
#import "FFRouteResponse.h"

static NSMutableDictionary *FFGlobal_routesMap = nil;

@interface FFRoutes ()

@property(nonatomic,strong)NSString *scheme;
@property(nonatomic,strong)NSMutableArray *routeArray;

@end

@implementation FFRoutes

/**
 创建路由
 
 @param scheme URL scheme
 @return 单例
 */
+ (instancetype)routesForScheme:(NSString *)scheme
{
    FFRoutes *routes = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        FFGlobal_routesMap = [[NSMutableDictionary alloc] init];
    });
    if (!FFGlobal_routesMap[scheme]) {
        routes = [[self alloc] init];
        routes.scheme = scheme;
        routes.routeArray=[NSMutableArray array];
        FFGlobal_routesMap[scheme] = routes;
    }
    routes = FFGlobal_routesMap[scheme];
    return routes;
}

/**
 添加路由
 
 @param pattern 模板
 @param handlerBlock 参数返回Block
 */
- (void)addRoute:(NSString *)pattern
         handler:(BOOL (^)(NSDictionary<NSString *, id> *parameters))handlerBlock
{
    FFRoute *route = [[FFRoute alloc]initWithPattern:pattern  handlerBlock:handlerBlock];
    route.scheme=self.scheme;
    [self.routeArray addObject:route];
}

/**
 跳转
 
 @param URL 跳转URL
 @return 是否成功
 */
- (BOOL)routeURL:(NSURL *)URL
{
    BOOL didRoute = NO;
    FFRouteRequest *request = [[FFRouteRequest alloc] initWithURL:URL];
    for (FFRoute *route in self.routeArray) {
        FFRouteResponse *response = [route routeResponseForRequest:request];
        didRoute = [route callHandlerBlockWithParameters:response.parameters];
    }
    return didRoute;
}

@end
