//
//  CoreDataUtility.h
//  iStand
//
//  Created by Maurizio Pinzi on 04/06/12.
//  Copyright (c) 2012 Almawave. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Evento;
@class Partecipante;

@interface CoreDataUtility : NSObject
{
}
+(void) insertSceltaWithEvento:(Evento*)evento 
              withPartecipante:(Partecipante*)partecipante 
                     inContext:(NSManagedObjectContext*)context;
@end
