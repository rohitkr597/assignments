//
//  CommunicationManager.m
//  Pharmacy
//
//  Created by Rohit Kumar on 07/11/16.
//  Copyright © 2016 Walmart. All rights reserved.
//

#import "CommunicationManager.h"
#import "JSONBuilder.h"
#import "Utility.h"

@implementation CommunicationManager

-(void)fetchDataFromURL:(NSString *)urlString withParameter:(NSDictionary *)paramDict forRequestType:(RequestType)requestType {

    NSString *urlStringWithQuesryString = [Utility addQueryStringToUrlString:urlString withDictionary:paramDict];
    
    [self.communicator getDataFromURL:urlStringWithQuesryString forRequestType:requestType];
}

#pragma mark - Communicator Manager Delegate

- (void)receivedJSON:(NSData *)objectNotation forRequestType:(RequestType)requestType
{
    NSError *error = nil;
    
    if (requestType == PHAuthentication) {
         [self.delegate didReceiveResult:[JSONBuilder dictionaryForAuthtication:objectNotation error:&error]];
    }
    
    else if (requestType == PHPrescription) {
        
        [self.delegate didReceiveResult:[JSONBuilder pharmaListFromJSON:objectNotation error:&error]];
        
    }
    
    else if (requestType == PHSubmitPrescription) {
         [self.delegate didReceiveResult:[JSONBuilder dictionaryForAuthtication:objectNotation error:&error]];
    }
   
    if (error != nil) {
        [self.delegate didFailWithError:error];
        
    }

}

- (void)fetchingFailedWithError:(NSError *)error
{
    [self.delegate didFailWithError:error];
}




@end
