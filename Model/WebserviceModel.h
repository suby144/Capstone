//
//  WebserviceModel.h
//  9alony
//
//  Created by suby on 10/10/15.
//  Copyright (c) 2015 suby. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^ Successblock)(id response);
typedef void(^ Falilureblock)(NSString *errormessage);
@interface WebserviceModel : NSObject

+(void)getDataWithParams:(NSString *)parameters urlServer:(NSString *)urlforServer withCompletionHandler : (Successblock)success andFailure :(Falilureblock)failure;
@end
