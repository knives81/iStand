//
//  DefaultDelegate.m
//  iStand
//
//  Created by Maurizio Pinzi on 01/06/12.
//  Copyright (c) 2012 Almawave. All rights reserved.
//

#import "DefaultDelegate.h"

@implementation DefaultDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //NSLog(@"Testo %@",text);
    if(![text isEqualToString:@"\n"])
    {
        NSUInteger newLength = (textView.text.length - range.length) + text.length;
        if(newLength <= CHAR_TEXT_VIEW)
        {
            return YES;
        } else {
            NSUInteger emptySpace = CHAR_TEXT_VIEW - (textView.text.length - range.length);
            textView.text = [[[textView.text substringToIndex:range.location] 
                              stringByAppendingString:[text substringToIndex:emptySpace]]
                             stringByAppendingString:[textView.text substringFromIndex:(range.location + range.length)]];
            return NO;
        }
    }
    else {
        return NO;
    }
    
}

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSUInteger newLength = (textField.text.length - range.length) + string.length;
    if(newLength <= CHAR_TEXT_FIELD)
    {
        return YES;
    } else {
        NSUInteger emptySpace = CHAR_TEXT_FIELD - (textField.text.length - range.length);
        textField.text = [[[textField.text substringToIndex:range.location] 
                           stringByAppendingString:[string substringToIndex:emptySpace]]
                          stringByAppendingString:[textField.text substringFromIndex:(range.location + range.length)]];
        return NO;
    }
}

@end
