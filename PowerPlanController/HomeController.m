//
//  HomeController.m
//  PowerPlanController
//
//  Created by Appcircle on 4/22/16.
//  Copyright © 2016 Appcircle. All rights reserved.
//

#import "HomeController.h"
#import "WebserviceModel.h"
#import "MBProgressHUD.h"
#import "YearlyController.h"
#import "MonthlyController.h"
#import "WeeklyController.h"
#import "PlanController.h"
@interface HomeController ()<UIAlertViewDelegate>
{
    float goalPercent;
}
@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // View customisation
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"user_id"]);
    self.gradiwentView.hidden = YES;
    self.btn_yarlyprogress.layer.borderWidth = self.btn_monthlyprogress.layer.borderWidth = self.btn_weeklyprogress.layer.borderWidth = self.btn_setupPlan.layer.borderWidth = 1;
    self.btn_yarlyprogress.layer.borderColor = self.btn_monthlyprogress.layer.borderColor = self.btn_weeklyprogress.layer.borderColor = self.btn_setupPlan.layer.borderColor =  [UIColor whiteColor].CGColor;
    self.btn_yarlyprogress.layer.cornerRadius = self.btn_monthlyprogress.layer.cornerRadius = self.btn_weeklyprogress.layer.cornerRadius = self.btn_setupPlan.layer.cornerRadius = 5.0F;
    [self getInitialData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark
#pragma mark IBACTIONS
- (IBAction)btnYearlyProgessAction:(id)sender {
    YearlyController *yearly_controller = [self.storyboard instantiateViewControllerWithIdentifier:@"YearlyController"];
    yearly_controller.dictionary_user_data = self.dictionay_user_data;
    yearly_controller.goal = [NSString stringWithFormat:@"%d",(int)goalPercent];
    [self.navigationController pushViewController:yearly_controller animated:YES];
}
- (IBAction)btnMonthlyProgressAction:(id)sender {
    MonthlyController *monthly_controller = [self.storyboard instantiateViewControllerWithIdentifier:@"MonthlyController"];
    monthly_controller.dictionary_user_data = self.dictionay_user_data;
    monthly_controller.goal = [NSString stringWithFormat:@"%d",(int)goalPercent];
    [self.navigationController pushViewController:monthly_controller animated:YES];
    
}
- (IBAction)bntWeeklyProgressAction:(id)sender {
    WeeklyController *weeklycontroller = [self.storyboard instantiateViewControllerWithIdentifier:@"WeeklyController"];
    weeklycontroller.dictionary_user_data = self.dictionay_user_data;
    weeklycontroller.goal = [NSString stringWithFormat:@"%d",(int)goalPercent ];
    [self.navigationController pushViewController:weeklycontroller animated:YES];
    
}
- (IBAction)btnSetPlanAction:(id)sender {
    PlanController *plancontroller = [self.storyboard instantiateViewControllerWithIdentifier:@"PlanController"];
    [self.navigationController pushViewController:plancontroller animated:YES];
    
}
- (IBAction)BTN_percentage:(UIButton *)sender{
    self.gradiwentView.hidden = NO;
    [self.autoCalculateCircleView drawCircleWithPercent:goalPercent
                                               duration:1
                                              lineWidth:15
                                              clockwise:YES
                                                lineCap:kCALineCapRound
                                              fillColor:[UIColor clearColor]
                                            strokeColor:[UIColor orangeColor]
                                         animatedColors:nil];
    [self.autoCalculateCircleView startAnimation];
    self.lblPowerConsumption.text = [NSString stringWithFormat:@"Power Consumed :%.4f KW",[[self.dictionay_user_data objectForKey:@"yearly_consumption"] floatValue]];
}

- (IBAction)btnLogout:(id)sender {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log Out" message:@"Are you sure want to logout" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Logout", nil];
        [alert show];
    });
    

}
#pragma mark
#pragma mark PRIVATE METHODS
//Get initial data
-(void)getInitialData{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *params = [NSString stringWithFormat:@"action=getInitialData&user_id=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]];
    [WebserviceModel getDataWithParams:params urlServer:baseurl withCompletionHandler:^(id response) {
        if ([[response objectForKey:@"status"] isEqualToString:@"success" ]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });
            self.dictionay_user_data = (NSDictionary *)response;
            [self getGoalPercentage];
        }
        else{dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"No data available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        });
           
        }
    } andFailure:^(NSString *errormessage) {
        
    }];
}

//Calculation of goal percentage
-(void)getGoalPercentage{
    float currentConsumption;
    float powerPlan =  [[self.dictionay_user_data objectForKey:@"power_plan"] floatValue];
    if (![[self.dictionay_user_data objectForKey:@"yearly_consumption"] isEqual:[NSNull null]]) {
        currentConsumption = [[self.dictionay_user_data objectForKey:@"yearly_consumption"] floatValue];
    }
    else{
        currentConsumption = 0.0;
    }
    
    float subVal = powerPlan-currentConsumption;
    float divValue = (subVal/powerPlan);
    goalPercent = (divValue)*100;
}
#pragma mark
#pragma mark METHOD FOR HIDE GRADIENT VIEW
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event  {
    UITouch *touch = [touches anyObject];
    if(touch.view.tag==1){
        self.gradiwentView.hidden = YES;
    }
}
#pragma mark
#pragma mark ALERTVIEW DELEGATES
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex!= alertView.cancelButtonIndex ) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user_id"];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
@end
