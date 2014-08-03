#import "_Evento.h"

@interface Evento : _Evento {}

-(NSString*)toString;
-(NSMutableString*)toString2;
-(Partecipante*)insertPartecipanteInContext:(NSManagedObjectContext*)context
                                 withCodice:(NSString*)codice
                                  withWsUrl:(NSString*)urlWsdl;
-(int)countPartecipanti;

@end
