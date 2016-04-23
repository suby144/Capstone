//
//  LoginController.m
//  PowerPlanController
//
//  Created by Appcircle on 4/22/16.
//  Copyright © 2016 Appcircle. All rights reserved.
//

#import "LoginController.h"
#import "HomeController.h"
#import "MBProgressHUD.h"
#import "WebserviceModel.h"
@interface LoginController ()<UIAlertViewDelegate,UITextFieldDelegate>

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // View customisation
    self.view_login.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.view_login.layer.borderWidth = 1;
    self.view_login.layer.cornerRadius = 2;
    self.txt_email.delegate =self;
    self.txt_password.delegate =self;
}
-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark IBACTIONS
- (IBAction)btnLogin:(id)sender {
    if ([self.txt_password.text  isEqual:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error!" message:@"Enter your password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if ([self.txt_email.text isEqual:@""]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error!" message:@"Enter your email" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self LoginWithUserName:self.txt_email.text andPassword:self.txt_password.text];
    }
}

- (IBAction)hideKeypad:(id)sender {
    [sender resignFirstResponder];
}
#pragma mark
#pragma mark IBACTIONS
-(void)LoginWithUserName :(NSString *)user_name andPassword:(NSString*)password{
    
    NSString *parameters = [NSString stringWithFormat:@"action=userLogin&user_name=%@&password=%@",user_name,password];
    [WebserviceModel getDataWithParams:parameters urlServer:baseurl withCompletionHandler:^(id response) {
        if ([[response objectForKey:@"status"] isEqualToString:@"success"]) {
            [[NSUserDefaults standardUserDefaults] setObject:[response objectForKey:@"user_id"] forKey:@"user_id"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                HomeController *objhome = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeController"];
                [self.navigationController pushViewController:objhome animated:NO];
            });
        }
        else{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Invalid Login" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            });
        }
    } andFailure:^(NSString *errormessage) {
        NSLog(@"%@",errormessage);
    }];
}
#pragma mark
#pragma mark METHOD FOR HIDE GRADIENT VIEW
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event  {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.txt_email resignFirstResponder];
        [self.txt_password resignFirstResponder];
    });
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == alertView.cancelButtonIndex) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.txt_password.text = @"";
            self.txt_email.text = @"";
            [MBProgressHUD hideHUDForView:self.view animated:YES];
             [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
        });
        
    }
}
#pragma mark - UITEXTFIED DELEGATES
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    return YES;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    
    return YES;
}

#pragma mark - KEYBOARD MOVEMENTS
- (void)keyboardDidShow:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = -30;
        self.view.frame = f;
    }];
    
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = 0.0f;
        self.view.frame = f;
    }];
}

@end
