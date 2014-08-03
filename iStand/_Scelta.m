// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Scelta.m instead.

#import "_Scelta.h"

const struct SceltaAttributes SceltaAttributes = {
	.ordinamento = @"ordinamento",
	.posizione_multiple = @"posizione_multiple",
	.valore_flag = @"valore_flag",
	.valore_multiple = @"valore_multiple",
	.valore_nota = @"valore_nota",
};

const struct SceltaRelationships SceltaRelationships = {
	.scelta_campod = @"scelta_campod",
	.scelta_opzione = @"scelta_opzione",
	.scelta_partec = @"scelta_partec",
};

const struct SceltaFetchedProperties SceltaFetchedProperties = {
};

@implementation SceltaID
@end

@implementation _Scelta

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Scelta" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Scelta";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Scelta" inManagedObjectContext:moc_];
}

- (SceltaID*)objectID {
	return (SceltaID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"ordinamentoValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"ordinamento"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"posizione_multipleValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"posizione_multiple"];
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





@dynamic posizione_multiple;



- (int16_t)posizione_multipleValue {
	NSNumber *result = [self posizione_multiple];
	return [result shortValue];
}

- (void)setPosizione_multipleValue:(int16_t)value_ {
	[self setPosizione_multiple:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitivePosizione_multipleValue {
	NSNumber *result = [self primitivePosizione_multiple];
	return [result shortValue];
}

- (void)setPrimitivePosizione_multipleValue:(int16_t)value_ {
	[self setPrimitivePosizione_multiple:[NSNumber numberWithShort:value_]];
}





@dynamic valore_flag;






@dynamic valore_multiple;






@dynamic valore_nota;






@dynamic scelta_campod;

	

@dynamic scelta_opzione;

	

@dynamic scelta_partec;

	






@end
