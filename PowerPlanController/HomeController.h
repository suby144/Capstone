//
//  HomeController.h
//  PowerPlanController
//
//  Created by Appcircle on 4/22/16.
//  Copyright © 2016 Appcircle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KNCirclePercentView.h"

@interface HomeController : UIViewController
@property (strong, nonatomic) NSDictionary *dictionay_user_data;
@property (strong, nonatomic) IBOutlet UIButton *btn_yarlyprogress;
@property (strong, nonatomic) IBOutlet UIButton *btn_monthlyprogress;
@property (strong, nonatomic) IBOutlet UIButton *btn_weeklyprogress;
@property (strong, nonatomic) IBOutlet UIButton *btn_setupPlan;
@property (strong, nonatomic) IBOutlet UIView *gradiwentView;
@property (strong, nonatomic) IBOutlet UILabel *lblPowerConsumption;
@property (weak, nonatomic) IBOutlet KNCirclePercentView *autoCalculateCircleView;
- (IBAction)btnYearlyProgessAction:(id)sender;
- (IBAction)btnMonthlyProgressAction:(id)sender;
- (IBAction)bntWeeklyProgressAction:(id)sender;
- (IBAction)btnSetPlanAction:(id)sender;
- (IBAction)BTN_percentage:(UIButton *)sender;
- (IBAction)btnLogout:(id)sender;
@end
