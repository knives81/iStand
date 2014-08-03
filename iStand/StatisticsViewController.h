//
//  StatisticsViewController.h
//  iStand
//
//  Created by Maurizio Pinzi on 08/06/12.
//  Copyright (c) 2012 Almawave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"

@class Evento;

@interface StatisticsViewController : CommonViewController
{
    Evento *eventoScelto;
}

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) Evento *eventoScelto;


@end
