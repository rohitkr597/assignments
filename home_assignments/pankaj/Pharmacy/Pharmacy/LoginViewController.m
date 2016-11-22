//
//  ViewController.m
//  Pharmacy
//
//  Created by Rohit Kumar on 07/11/16.
//  Copyright © 2016 Walmart. All rights reserved.
//

#import "LoginViewController.h"
#import "CommunicationManager.h"
#import "PrescriptionViewController.h"
#import "NSString+EmailValidation.h"

@interface LoginViewController ()<ComunicationMangerDelegate> {
    CommunicationManager *manager;
}

@property (nonatomic,strong) NSString *customerId;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    manager = [[CommunicationManager alloc] init];
    manager.communicator = [[ServerCommunication alloc] init];
    manager.communicator.delegate = manager;
    manager.delegate = self;
}

- (void)didReceiveResult:(id)result{

    NSDictionary *resultDictionary = (NSDictionary *)result;
    
    if ([[resultDictionary objectForKey:@"status"] isEqualToString:@"OK"]) {
        // Move to next view
        
        self.customerId = [resultDictionary objectForKey:@"customerId"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self performSegueWithIdentifier:@"detailView" sender:self];
        });
    }
    else{
        [self showAlert:[resultDictionary objectForKey:@"error"]];
    }
}

- (void)didFailWithError:(NSError *)error{
    NSLog(@"Fail with error %@",error);
}

- (BOOL)validateTextFields{
    if (![self.userNameTextFiled.text isValidEmail]) {
        return false;
    }
    if (self.passwordTextField.text.length < 6) {
        return false;
    }
    return true;
}

- (IBAction)loginAction:(id)sender {
    
    if ([self validateTextFields]) {
        
        NSString *emailAddress = self.userNameTextFiled.text;
        NSString *password = self.passwordTextField.text;
        
        NSMutableDictionary *paramDictionary = [[NSMutableDictionary alloc] init];
        [paramDictionary setObject:emailAddress forKey:@"emailId"];
        [paramDictionary setObject:password forKey:@"pwd"];
    
         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{ // 1
        
        [manager fetchDataFromURL:@"http://172.28.124.224:8081/customers/authenticate" withParameter:paramDictionary forRequestType:PHAuthentication];
             
         });
    }
    else{
        [self showAlert:@"Wrong emailId or password"];
    }
}

-(void)showAlert: (NSString *)message{
    
    dispatch_async(dispatch_get_main_queue(), ^{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    
    [self presentViewController:alertController animated:YES completion:nil];
        
    });
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"detailView"]) {
        PrescriptionViewController *preVC = [segue destinationViewController];
        preVC.customerId = self.customerId;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
