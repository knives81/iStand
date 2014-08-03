//
//  MyTextField.h
//  iStand
//
//  Created by Maurizio Pinzi on 01/06/12.
//  Copyright (c) 2012 Almawave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefaultDelegate.h"

@interface MyTextField : UITextField
{
}
@property (nonatomic,strong) DefaultDelegate *strongDelegate;

@end
