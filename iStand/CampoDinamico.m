#import "CampoDinamico.h"
#import "Opzione.h"

@implementation CampoDinamico

- (NSString*)toString
{
    NSString *str = @"";
	str= [str stringByAppendingFormat:@"\t\t\nCampoDinamico =  nome:%@ - ord:%@ - tipo:%@|", self.nome, self.ordinamento,self.tipo];
	NSSet *opzioni = self.campod_opzione_inv;
	for (Opzione *opzione in opzioni) 
	{
		str=[str stringByAppendingFormat:@"%@:%@|",opzione.ordinamento,opzione.valore];
	}
	return str;
}


@end
