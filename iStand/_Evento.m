// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Evento.m instead.

#import "_Evento.h"

const struct EventoAttributes EventoAttributes = {
	.data_al = @"data_al",
	.data_creazione = @"data_creazione",
	.data_dal = @"data_dal",
	.organizzazione = @"organizzazione",
	.titolo = @"titolo",
};

const struct EventoRelationships EventoRelationships = {
	.evento_campod_inv = @"evento_campod_inv",
	.evento_partec_inv = @"evento_partec_inv",
	.evento_regist_inv = @"evento_regist_inv",
};

const struct EventoFetchedProperties EventoFetchedProperties = {
};

@implementation EventoID
@end

@implementation _Evento

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Evento" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Evento";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Evento" inManagedObjectContext:moc_];
}

- (EventoID*)objectID {
	return (EventoID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic data_al;






@dynamic data_creazione;






@dynamic data_dal;






@dynamic organizzazione;






@dynamic titolo;






@dynamic evento_campod_inv;

	
- (NSMutableSet*)evento_campod_invSet {
	[self willAccessValueForKey:@"evento_campod_inv"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"evento_campod_inv"];
  
	[self didAccessValueForKey:@"evento_campod_inv"];
	return result;
}
	

@dynamic evento_partec_inv;

	
- (NSMutableSet*)evento_partec_invSet {
	[self willAccessValueForKey:@"evento_partec_inv"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"evento_partec_inv"];
  
	[self didAccessValueForKey:@"evento_partec_inv"];
	return result;
}
	

@dynamic evento_regist_inv;

	
- (NSMutableSet*)evento_regist_invSet {
	[self willAccessValueForKey:@"evento_regist_inv"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"evento_regist_inv"];
  
	[self didAccessValueForKey:@"evento_regist_inv"];
	return result;
}
	






@end
