//
// Publisher
//  - Exposes values of a certain type over time
//  - Can be completed or optionally fail with an error
//
// Subject
//  - A mutable publisher (has the ability to send new values after it’s initialisation)
//  - There are two subject types available:
//  - CurrentValueSubject - as the name indicates, this subject type has access to the current value
//  - PassthroughSubject - as the name indicates, this subject passes the current value through, i.e. it has no access to it
//
// Subscriber
//  - Receives values from publishers / subjects
//
// Operator
//  - Modifies values that are send from publishers / subjects
//
