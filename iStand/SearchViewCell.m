//
//  SearchViewCell.m
//  iStand
//
//  Created by Maurizio Pinzi on 22/03/12.
//  Copyright (c) 2012 Almawave. All rights reserved.
//

#import "SearchViewCell.h"

@implementation SearchViewCell
@synthesize lblEmail;
@synthesize lblNomeCognome;
@synthesize lblCodice;

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
