// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Opzione.m instead.

#import "_Opzione.h"

const struct OpzioneAttributes OpzioneAttributes = {
	.ordinamento = @"ordinamento",
	.valore = @"valore",
};

const struct OpzioneRelationships OpzioneRelationships = {
	.opzione_campod = @"opzione_campod",
	.opzione_scelta_inv = @"opzione_scelta_inv",
};

const struct OpzioneFetchedProperties OpzioneFetchedProperties = {
};

@implementation OpzioneID
@end

@implementation _Opzione

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Opzione" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Opzione";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Opzione" inManagedObjectContext:moc_];
}

- (OpzioneID*)objectID {
	return (OpzioneID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"ordinamentoValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"ordinamento"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic ordinamento;



- (int16_t)ordinamentoValue {
	NSNumber *result = [self ordinamento];
	return [result shortValue];
}

- (void)setOrdinamentoValue:(int16_t)value_ {
	[self setOrdinamento:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveOrdinamentoValue {
	NSNumber *result = [self primitiveOrdinamento];
	return [result shortValue];
}

- (void)setPrimitiveOrdinamentoValue:(int16_t)value_ {
	[self setPrimitiveOrdinamento:[NSNumber numberWithShort:value_]];
}





@dynamic valore;






@dynamic opzione_campod;

	

@dynamic opzione_scelta_inv;

	
- (NSMutableSet*)opzione_scelta_invSet {
	[self willAccessValueForKey:@"opzione_scelta_inv"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"opzione_scelta_inv"];
  
	[self didAccessValueForKey:@"opzione_scelta_inv"];
	return result;
}
	






@end
