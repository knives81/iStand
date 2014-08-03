//
//  CurlSegue.m
//  iStand
//
//  Created by Maurizio Pinzi on 16/08/12.
//  Copyright (c) 2012 Almawave. All rights reserved.
//

#import "CurlSegue.h"

@implementation CurlSegue

-(void)perform
{
    ((UIViewController*)self.destinationViewController).modalTransitionStyle = UIModalTransitionStylePartialCurl;

    [self.sourceViewController presentModalViewController:self.destinationViewController animated:YES];
}

@end
