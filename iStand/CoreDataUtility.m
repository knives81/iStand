//
//  CoreDataUtility.m
//  iStand
//
//  Created by Maurizio Pinzi on 04/06/12.
//  Copyright (c) 2012 Almawave. All rights reserved.
//

#import "CoreDataUtility.h"
#import "CampoDinamico.h"
#import "Scelta.h"
#import "Partecipante.h"
#import "Evento.h"

@implementation CoreDataUtility

+(void) insertSceltaWithEvento:(Evento*)evento 
              withPartecipante:(Partecipante*)partecipante 
                     inContext:(NSManagedObjectContext*)context
{
    
    NSSet *campiDinamici = evento.evento_campod_inv;			
    NSSortDescriptor *sortByOrdinamento = [[NSSortDescriptor alloc] initWithKey:@"ordinamento" ascending:YES];        
    NSArray *campiDinamiciSortati = [[campiDinamici allObjects]sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortByOrdinamento]];  
    
	for (CampoDinamico *campo in campiDinamiciSortati) 
	{
		Scelta *scelta = [NSEntityDescription insertNewObjectForEntityForName:@"Scelta" inManagedObjectContext:context];
		
		scelta.scelta_partec = partecipante;
		scelta.scelta_campod = campo;
		scelta.ordinamento = campo.ordinamento;
		
		if(campo.tipo==[NSNumber numberWithInt:0])
		{
			scelta.valore_flag = @"nochoice";
		}
		else if(campo.tipo==[NSNumber numberWithInt:1])
		{
			scelta.valore_nota = @"";
		}	
		else if(campo.tipo==[NSNumber numberWithInt:2])
		{        
			scelta.valore_multiple = @"Seleziona...";
			scelta.posizione_multiple = [NSNumber numberWithInt:0];
		}
	}
}


@end
