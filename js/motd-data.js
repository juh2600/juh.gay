lines = `
If it ain't leaking, it's probably empty.
Everyone's gotta be somewhere
holy fucking bingle. what?! :3
you know how it is with spaghetti
hold my lemonade i'm doing some cursed shit
That took a lot more alcohol than I expected
friendship ended with unistrut. now 8020 is my best friend
this pig needs a different shade of lipstick
That's not what I meant by "hubby behavior"...
Hope is not a strategy
To the car, emergency refueling is so simple.
We don't give a shit what color sasuke is because he's a roughness today
Situation has evolved since this was written. Update if you remember what it evolved into.
It's not that I can't, it's that I can't <em>and</em> don't want to
You wouldn't download more nines
damn, we are cuddling. what if i bit you for no reason 😳
If I can kidnap your child without them noticing, they're going in the faraday cage until they look up
I've been talking to <em>you</em> all day, so now I'm an asshole
Buy with confidence: HWHXCZYH.
That software looks shitty enough to run on Linux
the taco bell nacho cheese just woos my soul like nothing else can
We love the environment as much as we love socks!
Two scope probes and a microphone!
Did you defrost the hamster lights?
flat is justice!
Deep down, I never finished high school
If anything, alcoholism tends to cause matlab addiction
You can lead a horse to water, but you can't make him converge
\`m' for help is my bitch
The wedding budget is really cutting into the Jeep fund
He was young, dumb, and full of...unfulfilled promises
As you can see, it yeets off to fucking wherever, making it absolutely useless as a spline.
But I don't want a hot water heater. I want a <em>cold</em> water heater
the m in musl stands for meme
This is my transfer case. There are many like it, but most of them aren't this bad.
you just want an excuse to get me alone in a forest :<
He is not to be sneezed at
Quiet, you've been sealed
And then the fire nation attached!
Well I noticed some smoke coming from the right hand side of the screen, so I opened the console, and it was just full of flames.
If my hypothesis is correct, the metronomes should develop a latex kink.
Couldn't have said it myself!
only nixon could save china
the sky is peeling off, and it's...sharp) Kanban car...room flesh stains
I hate to gatekeep BLÅHAJ, but if it doesn't come from the children's section of IKEA, then it's just sparkling shark plushie
in one eye and out the other
in one speaker and out the other
Is it planned obsolescence if you just need the thing to last until the user dies?
if you're nothing without the ants, then you shouldn't have them
A fish needs a man, like a woman needs a bicycle
we can't all be gay, but we can all do crime
Don't give up, Shamiko! He's totally gay!
Don't give up, Shamiko! Visit more hot springs to learn about Japan's bathing culture!
chanserv said trans rights
men can be ladies too :<
every time someone says 'that scrolly thing is neat' i roll over in my grave
we all have an uncle joe. but we all need an uncle iroh
I'd keep it brief; I've never heard you say anything interesting before.
god bless quora
I have just been informed that I am not LGBTQ+. This comes as a shock to many of us, especially those who still think I'm pretty gay.
Don't give up, Shamiko! Train hard to bring tragedy to our nation!
do you know how many thoughts it took me to figure out which way was up so i could get up in the right direction??
Wouldn't you like to know, weatherboy?
I'd like to go out and see people, but it defeats the purpose of staying home and being alone, which is to not get sick and die.
don't use that tone of font with me >:(
(i,s,o,g,r,a,m)
My artist isn't really an artist, so I'll gain polygons as he learns how to art
Having an affair isn't about making wise decisions
no amount of sexism will help me finish this inordinate amount of spaghetti
linear time, logarithmic space, polynomial rising~
It's always a good idea to color coordinate your bones
Tinder be like nope nope nope nope nope oooh forklifts
this is the problem with you philosophers, one spider in your sink and you lose it
If a document is approved in the woods and no one is around to read it, does it exist?
Failure will no longer be recognized
`.split('\n').filter(x => x);

// one motd for the whole page, per load
const motd = `<q>${lines[Math.floor(Math.random() * lines.length)]}</q>`;

const getMotd = () => motd;
