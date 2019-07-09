//
//  FFRoute.m
//  FFRoutes
//
//  Created by 张玲玉 on 2018/7/27.
//

#import "FFRoute.h"
#import "FFRouteRequest.h"
#import "FFRouteResponse.h"

@interface FFRoute ()

@property(nonatomic,copy)NSString *pattern;
@property(nonatomic,copy)NSArray *patternPathComponents;

@end

@implementation FFRoute

/**
 创建一个路由
 
 @param pattern 模板
 @param handlerBlock 参数返回Block
 @return 实例
 */
- (instancetype)initWithPattern:(NSString *)pattern
                   handlerBlock:(BOOL (^)(NSDictionary *parameters))handlerBlock
{
    if ((self = [super init])) {
        self.pattern = pattern;
        self.handlerBlock = handlerBlock;
        if ([pattern characterAtIndex:0] == '/') {
            pattern = [pattern substringFromIndex:1];
        }
        self.patternPathComponents = [pattern componentsSeparatedByString:@"/"];
    }
    return self;
}

/**
 根据路由请求生成路由响应
 
 @param request 路由请求
 @return 路由响应
 */
- (FFRouteResponse *)routeResponseForRequest:(FFRouteRequest *)request
{
    NSDictionary *routeVariables = [self routeVariablesForRequest:request];
    if (routeVariables.count>0) {
        NSDictionary *matchParams = [self matchParametersForRequest:request routeVariables:routeVariables];
        FFRouteResponse *response =[FFRouteResponse validMatchResponseWithParameters:matchParams];
        return response;
    }
    return nil;
}

- (NSDictionary *)routeVariablesForRequest:(FFRouteRequest *)request
{
    NSMutableDictionary *routeVariables = [NSMutableDictionary dictionary];
    NSUInteger index = 0;
    for (NSString *patternComponent in self.patternPathComponents) {
        NSString *URLComponent = nil;
        if (index < [request.pathComponents count]) {
            URLComponent = request.pathComponents[index];
        }
        if ([patternComponent hasPrefix:@":"]) {
            NSString *variableName = [self routeVariableNameForValue:patternComponent];
            NSString *variableValue = [self routeVariableValueForValue:URLComponent];
            routeVariables[variableName] = variableValue;
        }
        index++;
    }
    return [routeVariables copy];
}

- (NSString *)routeVariableNameForValue:(NSString *)value
{
    NSString *name = value;
    if (name.length > 1 && [name characterAtIndex:0] == ':') {
        name = [name substringFromIndex:1];
    }
    if (name.length > 1 && [name characterAtIndex:name.length - 1] == '#') {
        name = [name substringToIndex:name.length - 1];
    }
    return name;
}

- (NSString *)routeVariableValueForValue:(NSString *)value
{
    NSString *var = [value stringByRemovingPercentEncoding];
    if (var.length > 1 && [var characterAtIndex:var.length - 1] == '#') {
        var = [var substringToIndex:var.length - 1];
    }
    return var;
}

- (NSDictionary *)matchParametersForRequest:(FFRouteRequest *)request
                             routeVariables:(NSDictionary <NSString *, NSString *> *)routeVariables
{
    NSDictionary *params=@{@"FFRoutePattern": self.pattern ?: [NSNull null],
                           @"FFRouteURL": request.URL ?: [NSNull null],
                           @"FFRouteScheme": self.scheme ?: [NSNull null]};
    
    NSMutableDictionary *matchParams = [NSMutableDictionary dictionary];
    [matchParams addEntriesFromDictionary:request.queryParams];
    [matchParams addEntriesFromDictionary:routeVariables];
    [matchParams addEntriesFromDictionary:params];
    
    return [matchParams copy];
}

- (BOOL)callHandlerBlockWithParameters:(NSDictionary *)parameters
{
    if (self.handlerBlock == nil) {
        return YES;
    }
    return self.handlerBlock(parameters);
}

@end
