//
//  ServerCommunication.h
//  Pharmacy
//
//  Created by Rohit Kumar on 07/11/16.
//  Copyright © 2016 Walmart. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    PHAuthentication,
    PHPrescription,
    PHSubmitPrescription,
} RequestType;


@protocol ServerCommunicationDelegate <NSObject>

- (void)receivedJSON:(NSData *)objectNotation forRequestType:(RequestType)requestType;
- (void)fetchingFailedWithError:(NSError *)error;

@end

@interface ServerCommunication : NSObject

@property (weak, nonatomic) id<ServerCommunicationDelegate> delegate;

- (void)getDataFromURL:(NSString *)urlString forRequestType:(RequestType)requestType;

@end
