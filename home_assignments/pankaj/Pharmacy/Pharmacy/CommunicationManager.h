//
//  CommunicationManager.h
//  Pharmacy
//
//  Created by Rohit Kumar on 07/11/16.
//  Copyright © 2016 Walmart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerCommunication.h"

@protocol ComunicationMangerDelegate <NSObject>

- (void)didReceiveResult:(id)result;
- (void)didFailWithError:(NSError *)error;

@end

@interface CommunicationManager : NSObject <ServerCommunicationDelegate>

@property (strong, nonatomic) ServerCommunication *communicator;
@property (weak, nonatomic) id<ComunicationMangerDelegate> delegate;

-(void)fetchDataFromURL:(NSString *)urlString withParameter:(NSDictionary *)paramDict forRequestType:(RequestType)requestType;

@end
