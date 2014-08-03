// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Registrazione.h instead.

#import <CoreData/CoreData.h>


extern const struct RegistrazioneAttributes {
	__unsafe_unretained NSString *data_entrata;
} RegistrazioneAttributes;

extern const struct RegistrazioneRelationships {
	__unsafe_unretained NSString *regist_evento;
	__unsafe_unretained NSString *regist_partec;
} RegistrazioneRelationships;

extern const struct RegistrazioneFetchedProperties {
} RegistrazioneFetchedProperties;

@class Evento;
@class Partecipante;



@interface RegistrazioneID : NSManagedObjectID {}
@end

@interface _Registrazione : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (RegistrazioneID*)objectID;




@property (nonatomic, strong) NSDate* data_entrata;


//- (BOOL)validateData_entrata:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Evento* regist_evento;

//- (BOOL)validateRegist_evento:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) Partecipante* regist_partec;

//- (BOOL)validateRegist_partec:(id*)value_ error:(NSError**)error_;





@end

@interface _Registrazione (CoreDataGeneratedAccessors)

@end

@interface _Registrazione (CoreDataGeneratedPrimitiveAccessors)


- (NSDate*)primitiveData_entrata;
- (void)setPrimitiveData_entrata:(NSDate*)value;





- (Evento*)primitiveRegist_evento;
- (void)setPrimitiveRegist_evento:(Evento*)value;



- (Partecipante*)primitiveRegist_partec;
- (void)setPrimitiveRegist_partec:(Partecipante*)value;


@end
