//
//  FFRouteResponse.m
//  FFRoutes
//
//  Created by 张玲玉 on 2018/7/27.
//

#import "FFRouteResponse.h"

@implementation FFRouteResponse

+ (instancetype)validMatchResponseWithParameters:(NSDictionary *)parameters
{
    FFRouteResponse *response = [[[self class] alloc] init];
    response.match = YES;
    response.parameters = parameters;
    return response;
}

@end
