import Ignite

struct AboutPage: StaticPage {
    let path = "/about"
    let title = "About"

    var layout: AboutLayout {
        AboutLayout()
    }

    @HTMLBuilder
    var body: some HTML {
        Text(title)
            .font(.title1)

        Text("Mission")
            .font(.title2)

        Text("This project aims to provide a fast track to programmers to learn another programming language quicker. Also, it aspires to become an invaluable resource for maintaining a decent skill level for infrequently used languages.")

        Text("My story")
            .font(.title2)

        Text("I started learning programming languages in circa 2002. Over the years I got acquainted with Assembly, Pascal, C, PHP, C++, C#, D, Java, JavaScript, TypeScript, Perl, Ruby, Lua, Python, Visual Basic, Swift, Kotlin, and probably others that I already forgot about. I am a programmer professionally, but I’ve moved between domains and languages. Sometimes switching completely, sometimes coming back to old tools in my toolbox. And one day I realized, when coming back to a language I have learned once before and haven’t touched for several years since, that I don’t know how to use it anymore. What a pity, surely there’s a way to jog these old memories somehow?!")

        Text("Well, maybe there is and maybe there isn’t. I haven’t tried hypnosis yet. But what’s definitely possible is to learn faster when you already know the underlying concepts. Sadly, most resources focus on teaching programming from scratch or going into robust explanation of nitty gritty details, and I’m glad they do. Yet, there seem to be an unfilled space for professionals who just need a quick, practical analogy and the right examples to get going in a few days.")

        Text("Let’s be honest, there will be languages you will use every day, and there will be languages you’ll turn to for specific tasks occasionally. Let’s be even more honest, with more and more competency, you no longer choose work because you get to write it in a certain language. You need to solve a problem and you’re picking the right tool for it (or someone else does for you, wink, wink, legacy codebases).")

        Text("This project was born to help me stay versatile in different environments. I no longer have to spend weeks on learning another language, again. Maybe it can do the same for you.")

        Text("What it is")
            .font(.title2)

        Text("It’s a digest for those who know what they want to write, but don’t have the words. This gives you the words, so you can write a program — now.")

        Text("It’s a perspective from which you can look at all programming languages and approach them in a similar way, building out your knowledge. Having the same overarching structure helps to compare features and piece concepts together. Starting with Basics that describe essentials for writing a program, adding Error Handling for robustness, and expanding into Abstractions for more expressiveness hence more concise code that is easier to read.")

        Text("It’s a cheatsheet you can come back to to refresh your memory.")

        Text("And hopefully one day it will become a platform where you can practice common programming tasks safely.")

        Text("What it is not")
            .font(.title2)

        Text("It is not an exhaustive language reference. I recommend you to read those instead, if you have the time. I usually do multiple times for every language I learn. This is a shortcut to the essentials.")

        Text("It doesn’t teach you how to program. Sorry, you still have to do the hard part of learning the fundamental programming concepts yourself. After, you may get a boost from Codaglot.")

        Text("It doesn’t show you APIs, platform configuration, or ecosystem, yet. The focus is on the syntax and built-in language features. This is to make the scope manageable for me. But we’ll see what the future brings.")

        Text("Commitment")
            .font(.title2)

        Text("The main functionality is and will always remain free. There will be no ads. It is a learning resource that I myself use as a quick reference and I’d be delighted if someone else also found it useful. It’s enough of a reward by itself.")

        Text("Future plans")
            .font(.title2)

        Text("I’d really like to write a chapter about asynchronous programming, concurrency, and reactive programming.")

        Text("I’d love to bring more languages on board. Particularly Swift, which is my other bread and butter, JavaScript and TypeScript that are notorious in the web environment, C#, especially useful with the Unity game engine and the Windows platform, and Python for universal, all-round scripting.")

        Text("Interactivity would do marvels for learning, either code-alongs directly on the web site or programming challenges with colorful output.")

        Text("And a knowledge base of practical tips (e.g. how to log KMP exceptions on iOS) and examples of how to implement common tasks, like writing to a file, making a network request, and so on, could be quite useful.")

    }
}
