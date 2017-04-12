# Liskov substitution principle
Subtypes must be substitutable for their supertypes.  
If S is a subtype of T, then objects of type T in a program may be replaced with objects of type S without altering any of the desirable properties of that program.  
Subclasses are all that their superclasses are, plus more, so this substitution should always work.  

The Liskov Substitution Principle also applies to duck types.  
When relying on duck types, every object that asserts that it plays the duck’s role must completely implement the duck’s API. Duck types should be substitutable for one another.  