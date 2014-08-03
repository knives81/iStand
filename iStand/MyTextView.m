//
//  MyTextView.m
//  iStand
//
//  Created by Maurizio Pinzi on 31/05/12.
//  Copyright (c) 2012 Almawave. All rights reserved.
//

#import "MyTextView.h"
#import <QuartzCore/QuartzCore.h>


@implementation MyTextView
@synthesize strongDelegate;

- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
   
    if (self) {
        [self customize];
        
    }
   
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self customize];
        
    }
    
    return self;
}
-(void)customize
{
    self.clipsToBounds = NO;
    [[self layer] setBorderColor:[[UIColor grayColor] CGColor]];
    [[self layer] setBorderWidth:2];
    [[self layer] setCornerRadius:15];
    [[self layer] setShadowColor:[[UIColor blackColor] CGColor]];
    [[self layer] setShadowRadius:2.0f];
    [[self layer] setShadowOffset:CGSizeMake(3, 3)];
    [[self layer] setShadowOpacity:0.8f];
    
    
    self.strongDelegate = [[DefaultDelegate alloc]init];
    self.delegate = self.strongDelegate;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
}*/




@end
