//
//  MyTextField.m
//  iStand
//
//  Created by Maurizio Pinzi on 01/06/12.
//  Copyright (c) 2012 Almawave. All rights reserved.
//

#import "MyTextField.h"

@implementation MyTextField
@synthesize strongDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.strongDelegate = [[DefaultDelegate alloc]init];
        self.delegate = self.strongDelegate;
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        self.strongDelegate = [[DefaultDelegate alloc]init];
        self.delegate = self.strongDelegate;
        
    }
    
    return self;
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
