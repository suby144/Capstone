//
//  WebserviceModel.m
//  9alony
//
//  Created by suby on 10/10/15.
//  Copyright (c) 2015 suby. All rights reserved.
//

#import "WebserviceModel.h"
#import "AppDelegate.h"

@implementation WebserviceModel


+(void)getDataWithParams:(NSString *)params urlServer:(NSString *)urlforServer withCompletionHandler:(Successblock)success andFailure:(Falilureblock)failure{
    __block __weak id responseData;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"%@?%@",urlforServer,params] stringByAddingPercentEncodingWithAllowedCharacters:set]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response,NSError *error) {
        if (!error)
        {
            NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
            if (httpResp.statusCode == 200)
            {
                NSError *jsonError;
                responseData =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                if (!jsonError)
                {
                    success(responseData);
                }
                else
                {
                    failure(jsonError.localizedDescription);
                }
            }
            else{
                // HANDLE BAD RESPONSE //
                failure([NSHTTPURLResponse localizedStringForStatusCode:httpResp.statusCode]);
            }
            
        }
        else
        {
            // ALWAYS HANDLE ERRORS :-] //
            failure (error.localizedDescription);
        }
    }];
    [dataTask resume];
    
}

@end