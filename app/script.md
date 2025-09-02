## Part 1

Hi, we are Vincent and Herdi, and we're here to do a Demo.

Today we are going to talk about Property-based testing. But, before
going into details on that, let us start with a motivating example.
Here, we have defined our own `reverse` function, which reverses a list.
Like any good software developer, we have added two unit tests to
check that it works correctly: an empty list and an odd-length list.

**run base test with no modifications**
Now, can anyone here come up with additional test-cases?
* Testcase for even amount of numbers.
* Testcase for big numbers.
* Testcase for negative numbers.

However even if we added a more exhaustive test suite, there could still be a
risk of an adveserial or weird edgecase.

For example, in this case by reversing the list,
and removing all instances of the number 42.
Here, we would need to have a test-case with the value 42 to catch this!
Although contrived, missing edge cases like this is a weakness with unit tests.
**Add this case during speech, run and show that it succeeds with this fault!**

## Part 2
This leads us to our main topic for this demo, property-based testing with QuickCheck.
Property based testing is a form of automated testing. It works by defining a property
we wish to be fulfilled on a testable component. With the property defined,
our testing library - QuickCheck - will generate inputs for this property and verify
that it holds.


In this case, the property we wish to test is that reverse is an inverse of itself,
meaning if we apply reverse twice to a list, we get back the original list!

**Run faulty reverse and show that it fails**
When testing this on our custom reverse function we can see that it properly captures
the edge case of 42, by checking this property on a thousand randomly generated lists.
Then when a counterexample is found, QuickCheck returns this example for manual
review.

Finding a counter-example, however, is not guaranteed if the test-space is too small.
For example, let us only run 3 generated tests.
**Modify *const 1000* to *const 3***
As we can see, this fails to find a counter-example.

## Part 3
Now, we understand the basics of property-based testing, to use randomly
generated examples of a specific data-structure and try to find
counter-examples that violate the property. However, note that until now
the data-structures we've used are built-into the language and automatically
supported by QuickCheck. But what if we want to use custom datatypes or data-structures?
Lets look at an example!

Here we see an embedded domain-specific language, meant to represent
artihmetic expressions. Evaluation is straight forward, and results in an
integer.

Using static analysis, we can simplify the expressions quite a bit. For e.g.
we know that adding zero to a number will result in the same number. Using
basic math knowledge, we can extend this simplify function with many other
cases as well!

Now, how would we verify that our simplify function works correctly.
By defining properties:
1. Evaluation should be preserved
2. A simplified expression is smaller than or equal to the original expression

But, as this comment suggest: How does QuickCheck now how to generate arbitrary
expressions? Well, we define it by defining the `arbitrary` function for expressions.
Since the datatype is self-recursive, we give it a depth.
Expressions of depth 1 are literals, and any other depth will recursively
create an arbitrary expression.

So, since we have defined how we can create arbitrary expressions, we can
apply this to property-based testing! <demonstrate>

Now, let us change something to break it. Let us make zero-removal into
one-removal. This is clearly false, and running it we get a counter-example.
But, this counter-example looks quite big. We know that simply having
an expression Add (Lit 0) (Lit 1) should fail. Can we do something
about this? This is where shrinking comes in! Let us tell QuickCheck how
it should simplify a counter-example that it finds. So what this says is
that for any subexpression, we can test this to see that it violates the property.
If it still does, that is a smaller counterexample.
**Uncomment and run shrink**

## Part 4
Perfect. Now for some trivia and recap. We chose to do this demonstration
in Haskell, and Quickcheck, since it was this library that created what
we now know as property-based testing.

Specifically for devops, Quickcheck and property-based testing automates
test-writing, turning it into declarative reasoning and functionality specification
instead. This of course also scales better, as implementation details are abstracted
and complex properties can be chained together.
It also provides a broader test coverage, as random generation can catch many
edge cases the programmer's did not think about!

However, it also comes with flaws. As we could see, given a small test-space
we may not find counter-examples. Furthermore, programmer's might miss
testing the functionality with property-based tests, like the case where
reversing twice is equal to the identity function.

The most imporant take-away is that property-based allows us to
avoid the grunt-work of writing tests and instead reason about
properties that our code should satisfy, allowing automation, abstraction
and scalability.