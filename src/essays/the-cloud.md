% the cloud: a tumblr post

_This [article originated on Tumblr](https://www.tumblr.com/juh-wasnt-deactivated19691231/731602959011659776), which presents a login wall before you can finish reading it. I've ported it here for my friends who don't want to log into Tumblr._

_This article has [multiple issues](https://github.com/juh2600/juh.gay/issues/17)._

![Cloud alignment matrix meme](/images/cloud-alignment-matrix.png)

# Foreword

you can stop reading if:

- you’re not interested in a moderate understanding of how the cloud works
- you’re not willing to think about what i’m saying

anyways we got one singular note so let’s go! even though i’m going to disagree with a lot of people, i’m not here because i’m angry; i’m here to ramble and infodump the way all those autismposts say they love to see people do :) let’s try categorizing some ideas i saw in the notes:

1. Concept
2. Security
3. Durability, Availability, Reliability
4. Education
5. Self-hosting
6. Miscellaneous

a lot of this turned out to be about cloud storage specifically, but cloud compute also presents a lot of interesting challenges! I know much less about that though.

## About the author

I fix one of the largest clouds. As in, I walk into the club with my static dissipative boots, put on my gloves, and handle those precious hard drives with your data on them, all the way to the disk crusher (yes, really). There are at least thousands of people with the same job, maybe O(10k) or even O(100k). I’m going to keep it fairly generic here; I’m not interested in sharing details about my employer or their operations.

I am _not_ an expert on cloud storage! Those folks are software and reliability engineers. I’d love to learn more from them, but frankly, if I ever have to talk to them, it’s because something has gone very horribly wrong right in front of me. (I don’t think I’ve ever had to do that.)

# Concept

![supa-hot-lava wrote: #that's what the fuck it is?](https://64.media.tumblr.com/c70657e95bf530ee519a8ecaf0706155/80b35fa2a7cdabe0-f0/s1280x1920/e905e26ee7bf8550de589523c993b5a8bab0dc0c.jpg)

![sourfires wrote: #i wish i could beam this information into everyones brains #its never bad to know more about computers](https://64.media.tumblr.com/d713f4d7f7d3acb7a8f58439457aaac9/80b35fa2a7cdabe0-89/s1280x1920/42173801c9f4ff2f0d575e513cc1dae441e52bae.jpg)

![rizzrustbolt wrote: #incorrect #it's actually all stored on immortal cruciform enslaved humans hanging out in underground passages](https://64.media.tumblr.com/964712318b387a6eb29c09e91e5e54ec/80b35fa2a7cdabe0-2c/s1280x1920/c1b8393ebaeb68643b9b4627b2db59c90efaec02.jpg)

![esper-aroon wrote: #i mena i kinda knew this? but also not this bluntly #thanks #internet security](https://64.media.tumblr.com/7b12ffb26b0ae78bfb1890bad36fe884/80b35fa2a7cdabe0-a3/s1280x1920/782a3dff4afc21f6098889bf44c8c2d14383f02f.jpg)

![this-girl-is wrote: #i was so baffled #when ppl started talking about "the cloud" #like #do you mean... servers? #they were convinced that "the cloud" was not servers #readers... it was servers #but thanks for the bizarre sense of being untethered from reality #it was a great warm up for brexit](https://64.media.tumblr.com/808e40bc62f2164c04f3dec20237b515/80b35fa2a7cdabe0-fa/s1280x1920/4cb6feb44991123b28d48d151efe3fcc94901654.jpg)

![mcdubs42 wrote: #I'm a computer scientist and it took me years to grasp the cloud for this exact reason #there is no cloud!!! data does not exist in the ether!!! it has to be *somewhere*!!!!!](https://64.media.tumblr.com/ef6a40228e6acca40e6371bbde99600d/80b35fa2a7cdabe0-a2/s1280x1920/1896a4ed20b9ff13c8018eeb244b88b4d556d8e1.jpg)

![uhf-comm-pass wrote: #this is true #but also #'cloud computing' DOES mean something specific from a technical/engineering perspective #which is distinct from just 'someone else's computer #clouds are generally 1) large distributed computer systems managed by centralized teams #2) that provide access to shared pools of resources (such as storage network and compute) #3) to a very large number of customers #4) and are generally geographically redundant #(that's off the top of my head so maybe not 100% accurate) #but from the perspective of a regular user you can definitely think about it as 'someone else's computer' #maybe I would say 'it's someone else's computer that's too big to fail' #in the sense that it's usually going to be more reliable -- if one computer in the cloud fails your data is still safe on other replicas #but when the cloud goes down as a whole it REALLY goes down #and many people and companies and services and areas may be affected at once #message queue](https://64.media.tumblr.com/0f42422f6ddc7fb146a1b832023577be/80b35fa2a7cdabe0-83/s500x750/9995a8bb375b7d931db822813b3148be09f59194.png)

The cloud is someone else’s computer. Except that both “someone” and “computer” should be very, very plural. The cloud is more like a bunch of Walmarts full of computers scattered around the world, maintained and operated by tens of thousands of people. There are multiple clouds out there, each one operated by different companies: for example, Amazon, Google, and Microsoft each run separate clouds. You can run your own cloud too, as long as you have the finances and skills to pull it off. “The Cloud” is less about it being someone else’s computer, and more about how you can **abstract services from physical resources to make operations easier**. (For a lot of folks, the fact that someone else is running the hardware is the biggest part of what makes it easier. If hardware ops isn’t your specialty (as a business or team) or interest (as an individual), you shouldn’t be doing it!)

I also want to mention [delay line memory](https://href.li/?https://en.wikipedia.org/wiki/Delay-line_memory) because it’s cool and matches better what people apparently think of when they hear “cloud storage”.

# Security

![thumbthumb wrote: #i never thought very hard about this #i figured yeah yeah it's on a server sure #but when u put it this way my shit feels wayyy less secure lmao #oh well :emoji of person standing i think:](https://64.media.tumblr.com/fc4a2a8f3c39aa75acf0cb55a35ff5d3/80b35fa2a7cdabe0-65/s1280x1920/fe0cb90f2d5aafeebccae58580ec48a12b25d74b.jpg)

![spring-or-summer wrote: #the way my job is migrating to the cloud.. #and literally almost every file i use has sensitive data of some kind :sob emoji:](https://64.media.tumblr.com/6cd8e3725f53fe26a4bbd97297543e14/80b35fa2a7cdabe0-1f/s1280x1920/27353e443b6cf39b10a367ff6ab087f7e309b9e4.jpg)

![babblingfishes wrote: #to be fair there is some differences between the cloud and someone else's computer #namely that it's more likely to be someone else's multiple computers #as a good cloud service typically saves it on a few separate servers for both backup reasons and server speed reasons #but yeah unless they're advertising full encryption they can totally see your stuff](https://64.media.tumblr.com/b26ced5a6dc56af823397e46dd0a5284/80b35fa2a7cdabe0-8d/s1280x1920/f407c8716da0457233de93d1cadde32c00edafc7.png)

![alessandriana wrote: #YUP #it's no more secure than anyone else's computer](https://64.media.tumblr.com/05d32c56cef3da6ed3515134596f4662/80b35fa2a7cdabe0-2b/s1280x1920/24c1dff22c588844f5d1643acabc36ae0ce05249.jpg)

If you aren’t spending every waking hour on hardening your system and network, then your computer is guaranteed a security train wreck. Cloud operators can afford teams of security engineers, kernel developers, and other roles focused on delivering and validating security of their environments. They’re not perfect, but they’re generally going to be waaay more secure than any machine in your home, or probably any machine you will physically interact with in your entire life.

What kind of security are you looking for?

- Physical security? Data center premises are much more secure than your front door, I can promise.
- OS-level security? Cloud providers have the influence to either fix kernels and important packages themselves, or press third parties to do so.
- Defense against being surveilled by a state actor, either en masse or as a target? You don’t stand much of a chance here either way, sorry. Cloud providers generally allow you to trade off the risk of your hardware being monitored and tampered with directly, for the risk of the provider being willing to hand over data. You always have the power to encrypt your data _on top of what the provider offers_, and I encourage you to take advantage of that. Various groups have done some amazing work with hardware and firmware monitoring, including power analysis, TEMPEST, bugging hard drive firmware, spooky Ethernet jack mods, and trunk sniffing. If you’re not an expert, you have no hope; if you are an expert, you know there hasn’t been hope for a long time.
- Encryption in transit? Across the Internet, TLS is standard, and post-quantum encryption is entering the scene. Within your LAN, you need to take additional precautions if you want to prevent data leakage between poorly-written and untested consumer-grade services (not to mention genuine spyware provided by trusted parties). Within a cloud…your mileage may vary, though you won’t know it. It’s up to the provider to choose to encrypt traffic within their network; sometimes they do, and sometimes they don’t. They should.
- Encryption at rest? You can’t beat a cloud provider here, really. At home, you usually have no encryption, but if you really know what you’re doing, you might have FDE and striping going on. In the cloud, you (should) have FDE, striping across thousands of drives, and several un-publicly-documented layers of abstraction between the drive and your data.
- Encryption in processing? Fully homomorphic encryption (FHE) is an up-and-coming thing, it exists in a rudimentary form, it’s not yet efficient enough to take the stage, and I’m looking forward to it.

The good news is, cloud resources can be pretty secure, even for sensitive data like one user mentioned. There are certifications and laws about good security practices, and ensuring that data centers pass those audits is a big deal that companies take seriously, because there’s a lot of money on the line. Medical, financial, and government contracts could fall through in a heartbeat if the provider doesn’t pass muster.

# Durability, Availability, Reliability

![just7frogsinapeoplesuit wrote: #I have been diligently refusing to use a single cloud storage system since they first introduced them #I like my external drive that functions without the internet thanks #it's my stuff I'm not putting it in someone else's garage](https://64.media.tumblr.com/faa51e374cb01406c1277c3d1657ce29/80b35fa2a7cdabe0-7e/s1280x1920/1ce5c0c0409c8521f60ab3c0f340de0a23a5a489.png)

![pbdigital wrote: #it's a good simplification for anyone that doesn't need to know more #technically different from simply offsite storage as it generally is distributed across multiple hard drives #with redundancy if it's good #and also structured in such a way that any failure or movement of data on the part of the provider shouldn't have any real effect on the co (truncated in image)](https://64.media.tumblr.com/45c92f5e31a4d35adb78090b9d31d063/80b35fa2a7cdabe0-52/s1280x1920/e60b5000511c41071da3d0b23032aa51ac799289.png)

![foxoftheasterisk wrote: #i thought the idea behind 'the cloud' was that it wasn't stored on just one computer? #rather it's distributed/duplicated in a way that makes it less likely your data is lost/inaccessible? #i mean yeah ultimately it's just stored on other machines somewhere but](https://64.media.tumblr.com/aceebe1fbb274b27fe81c9773f332096/80b35fa2a7cdabe0-61/s1280x1920/62332a12166411635d317f1d92f22dde9c7827a0.png)

![an unspecified user edited the meme shirt to read: "There is no cloud. It's just someone else's 200+ person team of $180k/year sysadmins and datacenter ops specialists with a 24/7 follow-the-sun oncall rotation and multi-region DR plan". caption: "hate these memes because they never actually represent what companies or users are paying for when they move to the cloud." tags: #please please just pay $7 a month for backblaze or dropbox or google drive or whatever i promise it's worth it #your external hard drives WILL die and you won't have them in a RAID configuration or your apartment will get flooded or they'l get knocked #off the table or something and you will not have your backups #above the point where you're paying $10 a month then we can talk about other options for data you don't care about losing #but below that you're not going to find a more reliable cost-efficient option than commodity cloud providers](https://64.media.tumblr.com/a428c7416faf239a6d6112d2fa75ffd4/80b35fa2a7cdabe0-7a/s500x750/c1318cf3a98f115ad7bbb0840fa8ebdb96595b77.png)

![ray-vin wrote: #which is why I don't use it #if I don't trust my own shit not to fail how am I gonna trust something I can't even see](https://64.media.tumblr.com/dd8d200ca437faaec8ddbaee31352e61/80b35fa2a7cdabe0-30/s1280x1920/0fcb6d1d6048ffe575639ab92703a9c0a6769a8f.png)

[You will never match the durability of a good cloud provider.](https://href.li/?https://cloud.google.com/blog/products/storage-data-transfer/understanding-cloud-storage-11-9s-durability-target)

Your hard drives will fail, your SSDs will fail. Your tapes might outlast you, but you probably don’t have those. Cloud hardware fails too. But they don’t just have backups, they have backups of backups of backups of backups! When a drive fails, they don’t try to recover the data from it. They scrap it. There is _no_ concern about whether they’ll be able to reconstruct the data (unless that’s the software team you work on, in which case, ensuring that is your job). Data is replicated and split up across:

- drives
- servers
- racks
- power feeds
- different ends of the room
- different rooms in the building
- different buildings on the campus
- different campuses throughout a region

They may stop there: there are some regulatory requirements about not migrating data out of a region or country or whatever. I’m not up on policy matters, so I can’t say much about that.

So. Cloud storage is more durable than personal storage. Do you need that?

Maybe! I can’t say. How valuable is the data? If you’re storing medical records, you likely need cloud-grade durability guarantees. If you’re hosting a Minecraft server, the cloud might be a good idea for other reasons, but it’s certainly not essential.

![thelostself wrote: I had an argument with an older history professor once when I was in university. She thought anything saved to the cloud would last forever, was way more likely to be preserved than something written on paper. She literally did not understand that it was still just in a physical place that could be destroyed in like a fire, or a bombing, or even by a really determined person with a hammer. Like the fact that some people actually think the internet and cloud storage somehow exist completely without physical form just blows my mind. #cloud storage](https://64.media.tumblr.com/aab2ae8f4cd28901d5413a3d08360f12/80b35fa2a7cdabe0-d5/s540x810/b91fc208359b02b246b7924698f047358e14e04f.png)

This argument about the durability of cloud storage versus a piece of paper was interesting, because even in her apparent confusion, the professor seemed to grasp the point of cloud storage better. If I write something down on paper, and I put the same content on a hard drive, they have the same durability: they can both be lost, destroyed, mislabeled, etc. We can see that digital storage is then at least as durable as a hard paper copy, clay tablet, VHS tape, even another hard drive. But the point of the cloud is to reduce the impact of any incident, through redundancy and whatnot: so while your paper document will be destroyed when it is destroyed, you could feasibly blow up a data center and still recover a whole lot of data. It would be a massive undertaking, and there could be losses, but it’s not unimaginable. Can you make photocopies of your paper document and store them around the world? Yes, but…you’ve just created a “cloud”, essentially. A paper cloud! Like…a library system…

# Education

![autamyton wrote: #one of my old professors was once asked to put together a unit on cloud computing #his response was that there's barely enough content to fill more than a couple weeks' worth of classes #like he *could* teach to allow students to be aws or azure certified #but this was supposed to be part of the computer science major and from a theory perspective cloud computing is really uninteresting #cloud computing #computer science](https://64.media.tumblr.com/fd727f8f2590d3f1d5eaa00e23e7914f/80b35fa2a7cdabe0-73/s1280x1920/2cc1b4ae813393d3204531c47939febf9d39d89a.png)

![carriemebags wrote: #first thing i learned in my cloud engineering course](https://64.media.tumblr.com/21ba3d2091232394c916d66bec187ebd/80b35fa2a7cdabe0-a7/s1280x1920/b88f0440205ad5b1294f05baa3cc520a6a33c43b.png)

There’s actually a lot to learn about cloud computing. Maybe not as much when it comes to user operations, but if you flip the table around and examine the problems in operating the cloud as the provider, well…there are decades of _exciting_ research and experience to wade through. You can absolutely fill a semester with theoretical discussion of:

- redundancy
- failover
- load balancing
- multi-tenant security
- traffic engineering
- software service management
- distributed storage approaches

and that’s without getting into the more practical weeds of:

- hardware selection
- vendor management
- certifications and audits
- building construction
- cooling and power architecture
- deployment and operation optimization
- hardware security modules
- access controls
- supply chain operations
- resource forecasting
- local government relations
- geology and meteorology
- finance
- and more!

# Self-hosting

![infernalfurn(...) wrote: #which is why i refuse to use it for anything :)](https://64.media.tumblr.com/c9b6eda89e7bd62e6b787159a88a1b8e/80b35fa2a7cdabe0-7b/s1280x1920/503a90da1658f3751500767ff923dc59d4d01de1.png)

![brothercrush wrote: #wow posts that convince me to finally get myself some heavy duty external storage and stop paying cloud rent](https://64.media.tumblr.com/b13634cd4c1ee27c719671d18abec45b/80b35fa2a7cdabe0-67/s1280x1920/13588dd516e2faaa6933d5c4363c6f0e946c81a0.png)

![marian-hawke wrote: #literally #ill die before i use any type of cloud storage #ill use a 5 billion terabyte nas as a desktop drive that takes up an entire room in my house before i use the cloud](https://64.media.tumblr.com/b6ed3eb507e78d2bda5a30e3530ec3d6/80b35fa2a7cdabe0-56/s1280x1920/400c73a28de384d115b66f504364813d37b49a4b.png)

![cornbreadcreamer wrote: #build a nas #create your own cloud that you own #and download pirated movies to it #this is the way](https://64.media.tumblr.com/00c75724dc309f3f42def1b46a827c1c/80b35fa2a7cdabe0-09/s1280x1920/f59b1e0176d940b6aae5d554875e9164a2ea3e5b.png)

There are some cloud concepts that you can scale down! My friends have agreements to colocate servers in each others’ labs to provide some geo-redundancy for their backups. There are clustered storage technologies like Ceph, which I haven’t tried out yet. VPNs allow you to tie servers together across multiple locations. TrueNAS offers a relatively easy introduction to decent storage practices on a single-machine level. But the closer you want to get to building your own cloud-grade service, the more it’s going to cost, in time and money. I’m enjoying it as a learning exercise. There is so much to do in between setting up LDAP for authentication and bare metal orchestration! Network architecture is hard! Storage is expensive for mortals! Sourcing power safely in my apartment is even a challenge. If you want to share your experiences with building your own cloud environments, my DMs are always open and I’m eager to learn :)

Anyways, if you’re willing to do the work to build whatever level of service you require, then go you! If you’re railing against something you don’t understand because it’s new and run by people you don’t like, well, I don’t think I can help you.

# Miscellaneous

![irbcallmefynn wrote: The cloud is so useful in concept but when you think about it for a second it actually sucks. I hate rentals, I hate subscriptions, I hate limited trials](https://64.media.tumblr.com/7b607358b35b4f683b5557fe126fee94/80b35fa2a7cdabe0-3e/s1280x1920/462d07bb2474e1b0150fad2acf981756476028e8.png)

![fagnumopus wrote: #just like with real rent its exploitative and predatory and dangerous #and just like with real rent the best option is to buy your own #used is ok](https://64.media.tumblr.com/b24f53dcf73647b686e9c9beb88b3010/80b35fa2a7cdabe0-6b/s1280x1920/ee027f24a1cd209fbcb34eb18987f95a9574c3b9.png)

The cloud doesn’t run for free. Imagine if your landlord were actually looking out for the property you lived in. There are real costs involved here, and the opex tradeoff for moving to self-hosted storage is your time (as well as electricity and cooling, which are likely negligible here). How much time will you spend ensuring that your local storage solution is healthy? Is that time worth more or less than what the cloud provider is charging? Do you need the cloud’s level of durability, or is some data loss acceptable? Do you need high availability, or is some downtime acceptable? If your internet goes down, how likely are you to need that data during the outage? What’s the cost of not having it during the outage? These are questions you must answer for yourself. I would argue that cloud storage and compute are not inherently bad, and a subscription model makes more sense than a single payment in this case. (hey i took a stand on something almost, look at me go)

![catgirlwarrior wrote: #also makes it hit harder that your data is not in your own possession. you are renting space on a shelf in their library #but there's realistically no guarantee they won't some day decide that's actually *their* book and you're j... (truncated in image)](https://64.media.tumblr.com/13a75c8cbf129fbd43bf5181797de8c9/80b35fa2a7cdabe0-e1/s1280x1920/3b81aef7278f9021dc93e147cb7f48a00d2671a8.png)

A user mentioned that once you give your data to the cloud, they now have de facto power over that data, and that’s true. I’m all for discussing the technicals of what a cloud _can_ be when done right, but this is more of a policy matter, which is where I have to step out, because I’m less interested in how humans choose to squander their opportunities.

Another user mentioned that “used is ok”. Used servers are fine, just stress test them first. Used storage…is fine if you don’t care about your data. There are so many ways to falsify drive health stats. Unless your storage is sealed from the OEM when you get it, you have no idea where it’s been, _you don’t know what firmware it’s really running_, and you should not trust it, at all. With that said, it’s cheaper, so go right ahead 🤪

![alimsurana wrote: #i hate web2.0](https://64.media.tumblr.com/431d5f3a26b573bd0470382f592b83fa/80b35fa2a7cdabe0-b3/s1280x1920/573074ecf8d03b6548f2817e4168890eca853384.png)

web1.0 + semantics ftw

# Conclusion

I hope you enjoyed and/or learned something! I woke up at 2100 and it’s now about 0315 and I’ve spent six hours on this post apparently. I’m going to pump this bitch full of tags because I’m having fun and you can’t stop me! purrrr say thank you mommy for the awesome notes

[i'll high five anyone who noticed that the apostrophes in the original post are upside down](https://juh-wasnt-deactivated19691231.tumblr.com/tagged/i%27ll%20high%20five%20anyone%20who%20noticed%20that%20the%20apostrophes%20in%20the%20original%20post%20are%20upside%20down) [security](https://juh-wasnt-deactivated19691231.tumblr.com/tagged/security) [cloud](https://juh-wasnt-deactivated19691231.tumblr.com/tagged/cloud) [cloud security](https://juh-wasnt-deactivated19691231.tumblr.com/tagged/cloud%20security) [internet security](https://juh-wasnt-deactivated19691231.tumblr.com/tagged/internet%20security) [cloud storage](https://juh-wasnt-deactivated19691231.tumblr.com/tagged/cloud%20storage) [hard drives](https://juh-wasnt-deactivated19691231.tumblr.com/tagged/hard%20drives) [storage](https://juh-wasnt-deactivated19691231.tumblr.com/tagged/storage) [infodump](https://juh-wasnt-deactivated19691231.tumblr.com/tagged/infodump) [moderate effort post](https://juh-wasnt-deactivated19691231.tumblr.com/tagged/moderate%20effort%20post) [computer science](https://juh-wasnt-deactivated19691231.tumblr.com/tagged/computer%20science) [redundancy](https://juh-wasnt-deactivated19691231.tumblr.com/tagged/redundancy) [resilience](https://juh-wasnt-deactivated19691231.tumblr.com/tagged/resilience) [durability](https://juh-wasnt-deactivated19691231.tumblr.com/tagged/durability) [reliability](https://juh-wasnt-deactivated19691231.tumblr.com/tagged/reliability) [hdd](https://juh-wasnt-deactivated19691231.tumblr.com/tagged/hdd) [ssd](https://juh-wasnt-deactivated19691231.tumblr.com/tagged/ssd) [public cloud](https://juh-wasnt-deactivated19691231.tumblr.com/tagged/public%20cloud) [education](https://juh-wasnt-deactivated19691231.tumblr.com/tagged/education) [learning](https://juh-wasnt-deactivated19691231.tumblr.com/tagged/learning) [self hosting](https://juh-wasnt-deactivated19691231.tumblr.com/tagged/self%20hosting) [computers](https://juh-wasnt-deactivated19691231.tumblr.com/tagged/computers) [servers](https://juh-wasnt-deactivated19691231.tumblr.com/tagged/servers) [data center](https://juh-wasnt-deactivated19691231.tumblr.com/tagged/data%20center) [opinion](https://juh-wasnt-deactivated19691231.tumblr.com/tagged/opinion) [availability](https://juh-wasnt-deactivated19691231.tumblr.com/tagged/availability) [high availability](https://juh-wasnt-deactivated19691231.tumblr.com/tagged/high%20availability) [TEMPEST](https://juh-wasnt-deactivated19691231.tumblr.com/tagged/TEMPEST) [surveillance](https://juh-wasnt-deactivated19691231.tumblr.com/tagged/surveillance) [data centers](https://juh-wasnt-deactivated19691231.tumblr.com/tagged/data%20centers)