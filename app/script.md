## Part 1

Hi, we are Vincent and Herdi doing a Demo presentation.

Today we are going to talk about Property based testing.

However, before that weneed to talk abouthow testing is normallydone.
This is the standardtesting enviroment a lot of people here are
familiar with, unit-testing. In this case we test if our own
reverse function sucessfully reverses a list, by checking it against
two hand written test cases.

What could be added?
* Testcase for even amount of numbers.
* Testcase for big numbers.
* Testcase for negative numbers.

However even if we added a more exaustive test solution, there could still be a risk ofan adveserial or weird edgecase.

We can emulate this by changing this function topass our test, while still being wrong. In this case by reversing the list,
and removing all instances of the number 42. If we then do not have a testcase explicitly checking a list containing 42 it
will pass. This is one of the major weaknesses with unit tests.

## Part 2
This leads us to our main topic for this demo, property-based testing with QuickCheck. Property based testing is a form of automated testing,
which is a part of devops.

Instead of checking some distinct value for an expected output, we instead check that the function or data structure satisfies
some specific property.

In this case we choose to use the property of the reverse function being the inverse to itself.
This means that if we apply reverse twice to any list of numbers, it would act as the identity and return the same original list.

When testing this on our custom reverse function we can see that it properly captures the edge case of 42, by checking this
property on a thousand randomly generated lists. Then when a counterexample is found, QuickCheck returns this example for manual
review.

Finding a counter-example, however, is not guaranteed if the test-space is too small. For example, let us only run 3 generated tests.
As we can see, this fails to find a counter-example.

A limitation of this approach is that this property does not actually capture the full semantics of the reverse function.

If we where to change reverse2 to the identity function, i.e. does nothing to the list. Property-based testing does not
catch that this is wrong, since it satisfies this property.

## Part 3
Now, we understand the basics of property-based testing, to use randomly
generated examples of a specific data-structure and try to find
counter-examples that violate the property. However, note that until now
the only data-structure we've been using has been lists of ints. But what
if we want to use custom datatypes or data-structures? Lets look at an example!

Here we see an embedded domain-specific language, meant to represent
artihmetic expressions. Evaluation is straight forward, and results in an
integer.

Using static analysis, we can simplify the expressions quite a bit. For e.g.
we know that adding zero to a number will result in the same number. Using
basic math knowledge, we can extend this simplify function with many other
cases as well!

Now, how would we verify that our simplify function works correctly. One
way of doing this is to check that it preserves semantics, in other words
that evaluating an expression before and after simplification should
give us the same result. So, as you can see we do not get any type errors?
How does this work? Does Haskell know how to generate arbitrary exressions?
No!

We need to tell the Quickcheck library how we can generate an arbitrary
expressions. Since the datatype is self-recursive, we give it a depth.
Expressions of depth 1 are literals, and any other depth will recursively
create an arbitrary expression.

So, since we have defined how we can create arbitrary expressions, we can
apply this to property-based testing! <demonstrate>

Now, let us change something to break it. Let us make zero-removal into
one-removal. This is clearly false, and running it we get a counter-example.
But, this counter-example looks quite big. We know that simply having
an expression Add (Lit 0) (Lit 1) should fail. Can we do something
about this? This is where shrinking comes in! Let us tell QuickCheck how
it should simplify a counter-example that it finds. Here, in an addition,
if any of the two inner-expressions also make us fail the property, that is
a smaller counter-example! Now, if we re run it we get this small example!
Nice!

## Part 4
You can breathe out, its over now. That was quite technical. You might ask
why Haskell? First off, best language ever. Secondly, QuickCheck, written for
Haskell, was written in the year 2000 by John Hughes and Koen Claeseen, and
has laid the ground-work for every other quickcheck-esque library in any
language you might use, whether that be C, C++, Java, Javascript etc. It
also introduced property-based testing as a concept!

As we could see with our examples, quickchecking abstracts the test-writing
and makes it declarative - allowing a more formal reasoning about your code.
This of course comes with strong correctness guarantees, as it covers more
test-cases. We get a broader test coverage, and higher scalability through
abstraction as we can string together properties to create tests that would be impractical to write by hand.

However, it also comes with flaws. As we could see, given a small test-space
we may not find counter-examples. Furthermore, programmer's might miss
testing the functionality with property-based tests, like the case where
reversing twice is equal to the identity function.

The most imporant take-aways, however, is that property-based allows us to
avoid the grunt-work of writing unit-tests and instead reason about
properties that our code should have. This automates test writing,
and also helps keep the functionality in mind.