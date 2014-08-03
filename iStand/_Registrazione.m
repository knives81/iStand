// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Registrazione.m instead.

#import "_Registrazione.h"

const struct RegistrazioneAttributes RegistrazioneAttributes = {
	.data_entrata = @"data_entrata",
};

const struct RegistrazioneRelationships RegistrazioneRelationships = {
	.regist_evento = @"regist_evento",
	.regist_partec = @"regist_partec",
};

const struct RegistrazioneFetchedProperties RegistrazioneFetchedProperties = {
};

@implementation RegistrazioneID
@end

@implementation _Registrazione

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Registrazione" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Registrazione";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Registrazione" inManagedObjectContext:moc_];
}

- (RegistrazioneID*)objectID {
	return (RegistrazioneID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic data_entrata;






@dynamic regist_evento;

	

@dynamic regist_partec;

	






@end
