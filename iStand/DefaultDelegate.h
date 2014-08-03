//
//  DefaultDelegate.h
//  iStand
//
//  Created by Maurizio Pinzi on 01/06/12.
//  Copyright (c) 2012 Almawave. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface DefaultDelegate : NSObject  <UITextViewDelegate, UITextFieldDelegate>
{
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

@end
