//
//  PlanController.m
//  PowerPlanController
//
//  Created by Appcircle on 4/22/16.
//  Copyright © 2016 Appcircle. All rights reserved.
//

#import "PlanController.h"
#import "WebserviceModel.h"
#import "MBProgressHUD.h"

@interface PlanController ()<UITextFieldDelegate>

@end

@implementation PlanController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view_plan.layer.borderWidth = 1;
    self.view_plan.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.txtPower.delegate =self;
    self.txtPrice.delegate = self;
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
- (IBAction)btnUpdatePlan:(id)sender{
    if (![self.txtPrice.text  isEqual:@""]&& ![self.txtPower.text  isEqual: @""]) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES ];
        NSString *params = [NSString stringWithFormat:@"action=updatePlan&user_id=%@&power_plan=%@&price_plan=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"],self.txtPower.text,self.txtPrice.text];
        [self updatePlan :params];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error!" message:@"Both fields cannot be nil" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark
#pragma mark METHOD FOR HIDE KEYBOARD
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event  {
    [self.txtPrice resignFirstResponder];
    [self.txtPower resignFirstResponder];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}
-(void)updatePlan :(NSString *)parameters{
    
    [WebserviceModel getDataWithParams:parameters urlServer:baseurl withCompletionHandler:^(id response) {
        if ([[response objectForKey:@"status"] isEqualToString:@"success" ]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.txtPower.text = self.txtPrice.text = @"";
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Your plan successfully updated!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
            });
            
        }
    } andFailure:^(NSString *errormessage) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Network Error" message:@"Some error has been occured" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
    
    
}
#pragma mark - UITEXTFIED DELEGATES
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    return YES;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    [self.view endEditing:YES];
    return YES;
}

#pragma mark - KEYBOARD MOVEMENTS
- (void)keyboardDidShow:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = -20.0f;
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
