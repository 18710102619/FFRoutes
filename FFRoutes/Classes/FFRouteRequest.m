//
//  FFRouteRequest.m
//  FFRoutes
//
//  Created by 张玲玉 on 2018/7/27.
//

#import "FFRouteRequest.h"

@implementation FFRouteRequest

/**
 初始化路由请求
 
 @param URL 路由URL
 @return 实例
 */
- (instancetype)initWithURL:(NSURL *)URL
{
    self = [super init];
    if (self) {
        self.URL = URL;

        NSURLComponents *components = [NSURLComponents componentsWithString:[self.URL absoluteString]];
        if (components.host.length>0 && ![components.host isEqualToString:@"localhost"]) {
            NSString *host = [components.percentEncodedHost copy];
            components.host = @"/";
            components.percentEncodedPath = [host stringByAppendingPathComponent:(components.percentEncodedPath ?: @"")];
        }
        
        NSString *path = [components percentEncodedPath];
        if (path.length > 0 && [path characterAtIndex:0] == '/') {
            path = [path substringFromIndex:1];
        }
        self.pathComponents = [path componentsSeparatedByString:@"/"];

        NSMutableDictionary *queryParams = [NSMutableDictionary dictionary];
        NSArray *queryItems = [components queryItems] ?: @[];
        for (NSURLQueryItem *item in queryItems) {
            if (item.value == nil) {
                continue;
            }
            if (queryParams[item.name] == nil) {
                queryParams[item.name] = item.value;
            }
        }
        self.queryParams = [queryParams copy];
    }
    return self;
}

@end
