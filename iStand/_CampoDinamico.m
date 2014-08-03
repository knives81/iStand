// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CampoDinamico.m instead.

#import "_CampoDinamico.h"

const struct CampoDinamicoAttributes CampoDinamicoAttributes = {
	.nome = @"nome",
	.ordinamento = @"ordinamento",
	.tipo = @"tipo",
};

const struct CampoDinamicoRelationships CampoDinamicoRelationships = {
	.campod_evento = @"campod_evento",
	.campod_opzione_inv = @"campod_opzione_inv",
	.campod_scelta_inv = @"campod_scelta_inv",
};

const struct CampoDinamicoFetchedProperties CampoDinamicoFetchedProperties = {
};

@implementation CampoDinamicoID
@end

@implementation _CampoDinamico

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"CampoDinamico" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"CampoDinamico";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"CampoDinamico" inManagedObjectContext:moc_];
}

- (CampoDinamicoID*)objectID {
	return (CampoDinamicoID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"ordinamentoValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"ordinamento"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"tipoValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"tipo"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic nome;






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





@dynamic tipo;



- (int16_t)tipoValue {
	NSNumber *result = [self tipo];
	return [result shortValue];
}

- (void)setTipoValue:(int16_t)value_ {
	[self setTipo:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveTipoValue {
	NSNumber *result = [self primitiveTipo];
	return [result shortValue];
}

- (void)setPrimitiveTipoValue:(int16_t)value_ {
	[self setPrimitiveTipo:[NSNumber numberWithShort:value_]];
}





@dynamic campod_evento;

	

@dynamic campod_opzione_inv;

	
- (NSMutableSet*)campod_opzione_invSet {
	[self willAccessValueForKey:@"campod_opzione_inv"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"campod_opzione_inv"];
  
	[self didAccessValueForKey:@"campod_opzione_inv"];
	return result;
}
	

@dynamic campod_scelta_inv;

	
- (NSMutableSet*)campod_scelta_invSet {
	[self willAccessValueForKey:@"campod_scelta_inv"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"campod_scelta_inv"];
  
	[self didAccessValueForKey:@"campod_scelta_inv"];
	return result;
}
	






@end
