#import "CCLabelTTF+GameFont.h"
#import "CCEffectInvert.h"


@implementation CCLabelTTF (GameFont)

+ (CCLabelTTF *)gameLabelWithSize:(CGFloat)size
{
    CCLabelTTF *label = [[CCLabelTTF alloc] initWithString:@"" fontName:@"Courier-Bold" fontSize:size];
    label.color = [CCColor blackColor];

    CCEffectPixellate *effectPixellate = [[CCEffectPixellate alloc] initWithBlockSize:3.0];
    CCEffectInvert *effectInvert = [[CCEffectInvert alloc] init];
    CCEffectStack *effectStack = [[CCEffectStack alloc] initWithEffects:effectInvert, effectPixellate, nil];

    label.effect = effectStack;

    return label;
}

@end