DelegateClass class generator - generates a base class in which all the methods of the passed class are implemented to delegate to an underlying object.

class IrcBotSink < DelegateClass(Cinch::Bot)
end