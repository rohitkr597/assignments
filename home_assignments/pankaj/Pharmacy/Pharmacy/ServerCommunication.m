//
//  ServerCommunication.m
//  Pharmacy
//
//  Created by Rohit Kumar on 07/11/16.
//  Copyright © 2016 Walmart. All rights reserved.
//

#import "Servercommunication.h"

@implementation ServerCommunication


- (void)getDataFromURL:(NSString *)urlString forRequestType:(RequestType) requestType
{
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSLog(@"%@", urlString);
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    [[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            [self.delegate fetchingFailedWithError:error];
        } else {
            [self.delegate receivedJSON:data forRequestType:requestType];
        }
    }] resume];
}

@end
