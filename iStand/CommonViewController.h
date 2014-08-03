//
//  CommonViewController.h
//  iStand
//
//  Created by Maurizio Pinzi on 24/06/12.
//  Copyright (c) 2012 Almawave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonViewController : UIViewController
{}

-(void)actionsBasedOnOrientation:(UIInterfaceOrientation)or forView:(UIView*)myview;
-(void)printOrientation:(UIInterfaceOrientation)orient
                 method:(NSString*)nameMethod;

@end
