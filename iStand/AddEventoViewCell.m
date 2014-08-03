//
//  AddEventoViewCell.m
//  iStand
//
//  Created by Maurizio Pinzi on 08/04/12.
//  Copyright (c) 2012 Almawave. All rights reserved.
//

#import "AddEventoViewCell.h"

@implementation AddEventoViewCell

@synthesize imgTipoCampo;
@synthesize lblDescrCampo;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
