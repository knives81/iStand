//
//  SearchViewCell.h
//  iStand
//
//  Created by Maurizio Pinzi on 22/03/12.
//  Copyright (c) 2012 Almawave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewCell : UITableViewCell

@property (nonatomic,weak) IBOutlet UILabel *lblCodice;
@property (nonatomic,weak) IBOutlet UILabel *lblNomeCognome;
@property (nonatomic,weak) IBOutlet UILabel *lblEmail;

@end
