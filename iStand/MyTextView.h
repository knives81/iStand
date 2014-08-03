//
//  MyTextView.h
//  iStand
//
//  Created by Maurizio Pinzi on 31/05/12.
//  Copyright (c) 2012 Almawave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefaultDelegate.h"


@interface MyTextView : UITextView
{
     
}
@property (nonatomic,strong) DefaultDelegate *strongDelegate;

-(void)customize;
@end
