#import "SFBackgroundDebris.h"


@interface SFBackgroundDebris ()

@property (nonatomic) float speedfactor;

@end


@implementation SFBackgroundDebris


- (id)init
{
    self = [super init];

    if (self)
    {
        float rnd = CCRANDOM_0_1();

        self.position = ccp((CGFloat) ([CCDirector sharedDirector].view.frame.size.width * CCRANDOM_0_1()),
                            [CCDirector sharedDirector].view.frame.size.height);

        self.speedfactor = (float) ([CCDirector sharedDirector].view.frame.size.height - (1.0 * rnd + 0.5));
        float size = (float) (2.0 * rnd + 0.5);
        GLubyte color = (GLubyte) (80.0 * rnd + 130.0);

        CCNodeColor *square = [[CCNodeColor alloc] initWithColor:[CCColor colorWithRed:color green:color blue:color]
                                                           width:size
                                                          height:size];
        [self addChild:square];
    }

    return self;
}

- (void)update:(CCTime)aTimeDelta
{
	if (self.position.y <= 0.0)
	{
		[self removeFromParentAndCleanup:YES];

	}
	else
	{
		CGPoint newPosition = CGPointMake(self.position.x,
                                          (CGFloat) (self.position.y - _speedfactor * aTimeDelta));
		self.position = newPosition;
	}
}

@end