// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Partecipante.m instead.

#import "_Partecipante.h"

const struct PartecipanteAttributes PartecipanteAttributes = {
	.cap = @"cap",
	.cap_ist = @"cap_ist",
	.cellulare = @"cellulare",
	.cellulare_add = @"cellulare_add",
	.citta = @"citta",
	.citta_ist = @"citta_ist",
	.codice = @"codice",
	.cognome = @"cognome",
	.da_aggiornare = @"da_aggiornare",
	.dipartimento = @"dipartimento",
	.email = @"email",
	.email_add = @"email_add",
	.fax = @"fax",
	.fax_add = @"fax_add",
	.id = @"id",
	.indirizzo = @"indirizzo",
	.indirizzo_ist = @"indirizzo_ist",
	.istituto = @"istituto",
	.nome = @"nome",
	.note = @"note",
	.paese = @"paese",
	.paese_ist = @"paese_ist",
	.posizione = @"posizione",
	.presente = @"presente",
	.provincia = @"provincia",
	.provincia_ist = @"provincia_ist",
	.specialita = @"specialita",
	.telefono = @"telefono",
	.telefono_add = @"telefono_add",
};

const struct PartecipanteRelationships PartecipanteRelationships = {
	.partec_evento = @"partec_evento",
	.partec_regist_inv = @"partec_regist_inv",
	.partec_scelta_inv = @"partec_scelta_inv",
};

const struct PartecipanteFetchedProperties PartecipanteFetchedProperties = {
};

@implementation PartecipanteID
@end

@implementation _Partecipante

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Partecipante" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Partecipante";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Partecipante" inManagedObjectContext:moc_];
}

- (PartecipanteID*)objectID {
	return (PartecipanteID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"da_aggiornareValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"da_aggiornare"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"presenteValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"presente"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic cap;






@dynamic cap_ist;






@dynamic cellulare;






@dynamic cellulare_add;






@dynamic citta;






@dynamic citta_ist;






@dynamic codice;






@dynamic cognome;






@dynamic da_aggiornare;



- (BOOL)da_aggiornareValue {
	NSNumber *result = [self da_aggiornare];
	return [result boolValue];
}

- (void)setDa_aggiornareValue:(BOOL)value_ {
	[self setDa_aggiornare:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveDa_aggiornareValue {
	NSNumber *result = [self primitiveDa_aggiornare];
	return [result boolValue];
}

- (void)setPrimitiveDa_aggiornareValue:(BOOL)value_ {
	[self setPrimitiveDa_aggiornare:[NSNumber numberWithBool:value_]];
}





@dynamic dipartimento;






@dynamic email;






@dynamic email_add;






@dynamic fax;






@dynamic fax_add;






@dynamic id;



- (int16_t)idValue {
	NSNumber *result = [self id];
	return [result shortValue];
}

- (void)setIdValue:(int16_t)value_ {
	[self setId:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveIdValue {
	NSNumber *result = [self primitiveId];
	return [result shortValue];
}

- (void)setPrimitiveIdValue:(int16_t)value_ {
	[self setPrimitiveId:[NSNumber numberWithShort:value_]];
}





@dynamic indirizzo;






@dynamic indirizzo_ist;






@dynamic istituto;






@dynamic nome;






@dynamic note;






@dynamic paese;






@dynamic paese_ist;






@dynamic posizione;






@dynamic presente;



- (BOOL)presenteValue {
	NSNumber *result = [self presente];
	return [result boolValue];
}

- (void)setPresenteValue:(BOOL)value_ {
	[self setPresente:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitivePresenteValue {
	NSNumber *result = [self primitivePresente];
	return [result boolValue];
}

- (void)setPrimitivePresenteValue:(BOOL)value_ {
	[self setPrimitivePresente:[NSNumber numberWithBool:value_]];
}





@dynamic provincia;






@dynamic provincia_ist;






@dynamic specialita;






@dynamic telefono;






@dynamic telefono_add;






@dynamic partec_evento;

	

@dynamic partec_regist_inv;

	
- (NSMutableSet*)partec_regist_invSet {
	[self willAccessValueForKey:@"partec_regist_inv"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"partec_regist_inv"];
  
	[self didAccessValueForKey:@"partec_regist_inv"];
	return result;
}
	

@dynamic partec_scelta_inv;

	
- (NSMutableSet*)partec_scelta_invSet {
	[self willAccessValueForKey:@"partec_scelta_inv"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"partec_scelta_inv"];
  
	[self didAccessValueForKey:@"partec_scelta_inv"];
	return result;
}
	






@end
