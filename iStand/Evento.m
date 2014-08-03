#import "Evento.h"
#import "Partecipante.h"
#import "CampoDinamico.h"
#import "CoreDataUtility.h"
#import "Registrazione.h"

@implementation Evento

-(Partecipante*)insertPartecipanteInContext:(NSManagedObjectContext*)context
                                 withCodice:(NSString*)codice
                                  withWsUrl:(NSString*)urlWsdl
{
	Partecipante *partecipante = NULL;
	NSSet *setPartecipanti = self.evento_partec_inv;
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"codice == %@", codice];
	NSSet *setPartecipantiIndividuati = [setPartecipanti filteredSetUsingPredicate:predicate];
	
	
	//inserisco il nuovo partecipante
	if([setPartecipantiIndividuati count]==0)
	{
		
		partecipante = [NSEntityDescription
						insertNewObjectForEntityForName:@"Partecipante" 
						inManagedObjectContext:context];
		
		[partecipante init:codice];
		int retWs = [partecipante getFromWs:urlWsdl barCode:codice];            
		partecipante.partec_evento = self;		
		[CoreDataUtility insertSceltaWithEvento:self withPartecipante:partecipante inContext:context];
        
	}        
	//carico il partecipante esistente
	else
	{
		partecipante = [[setPartecipantiIndividuati allObjects] objectAtIndex:0];			
	}
	//registro l'entrata sia che ho creato si che l'ho trovato
	Registrazione *registrazione = [NSEntityDescription
									insertNewObjectForEntityForName:@"Registrazione" 
									inManagedObjectContext:context];        
	registrazione.data_entrata = [NSDate date];        
	registrazione.regist_evento = self;
	registrazione.regist_partec = partecipante;
	
	return partecipante;
}

-(int)countPartecipanti
{
    NSArray *partecipanti = [self.evento_partec_inv allObjects];
    return partecipanti.count; 
    
    

}

-(NSString*)toString
{
    NSString *str = @"";
    str= [str stringByAppendingFormat:@"\nEvento: %@\n", self.titolo];
    
    NSSet* partecipanti = self.evento_partec_inv;
    for(Partecipante* part in partecipanti)
    {
        str = [str stringByAppendingFormat:@"\t%@\n",[part toString]];
    }
    
    return str;
}
-(NSMutableString*)toString2
{
    NSMutableString *str = NULL;
    str= [NSMutableString stringWithFormat:@"\nEvento: %@\n", self.titolo];
    
	NSSet *campi = self.evento_campod_inv;
    for (CampoDinamico *campo in campi)
	{
        [str appendFormat:@"\t%@\n",[campo toString]];
    }
    return str;
}
@end
