# twiine

## Version Control
 
Development from now on should follow the below branching protocal:
  * The git repo will have two branches at all times: master and development. They should not be deleted under any conditions.
  * The master branch will only contain bug-free, completed code. Any version on this branch should be considered final. Merge to
    master should only occur when features are completely implemented, additionally any merge to master should be complimented by a 
    new tag.
  * The development branch will contain work-in-progress. Any version on this branch should be compile-time error free, completed,
    but with non-final features. Merge to development branch should only occur when code is finished but yet to be tested for 
    compatibility and run-time errors.
  * Any addition, deletion, or modification of code should be completed on a seperate branch that branched off the development branch.
    The seperate branch can be modified at will by any developers, any not pushed to the server unless needed for collaboration, and 
    deleted afterwards.

## Style/Formatting

Just run the auto formatter and make sure you add commas everywhere. See: https://flutter.dev/docs/development/tools/formatting
and name things like this https://dart.dev/guides/language/effective-dart/style
