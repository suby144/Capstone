//
//  PlanController.h
//  PowerPlanController
//
//  Created by Appcircle on 4/22/16.
//  Copyright © 2016 Appcircle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlanController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *txtPrice;
@property (strong, nonatomic) IBOutlet UITextField *txtPower;
@property (strong, nonatomic) IBOutlet UIView *view_plan;
- (IBAction)btnUpdatePlan:(id)sender;
- (IBAction)btnBack:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *img_bg;
@end
