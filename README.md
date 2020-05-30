# twiine

A new Flutter application.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Version Control for Developers -10/12/2018
 
For future commits:
  * Any commit that changes the internal logics should be followed by a detailed commit  message that describes in detail what feature
    are modified, and should start with "CORE:".
  * Any commit that does not change the internal logics should have a commit message that is brief, and should not start with "CORE".
 
Development from now on should follow the below branching protocal:
  * The git repo will now have two branches at all times: master and development. They should not be deleted under any conditions.
  * The master branch will only contain bug-free, completed code. Any version on this branch should be considered final. Merge to
    master should only occur when features are completely implemented, additionally any merge to master should be complimented by a 
    new tag.
  * The development branch will contain work-in-progress. Any version on this branch should be compile-time error free, completed,
    but with non-final features. Merge to development branch should only occur when code is finished but yet to be tested for 
    compatibility and run-time errors.
  * Any addition, deletion, or modification of code should be completed on a seperate branch that branched off the development branch.
    The seperate branch can be modified at will by any developers, any not pushed to the server unless needed for collaboration, and 
    deleted afterwards. 
  * All bugs should be recorded in the Issuelog.txt file and branched off to be modified.
  * A graph is provided below to visualize the process.

<pre>
    (initla code)										 (version 1)
	master 						----> 					   master
	     \										  	    /(merge)
      (branch)\   (initial code)   	       (incompatibility issue found)  /--->   	development/
	       \   development  	 	---->	development	 ----/	  (updated compatible code)
	            \    \			      /   /	   \		            /
                     \    \(branch)	     (merge) /   /	    \(branch)	           /(merge)
	      (branch)\    \     mapReader ---->    /   /(merge)     \	 Issue1  ---->    /
		       \(development and debugging)    /	    (fix compatibility issue)
		        \                             /
		         \    playerMovement ---->   /
		           (development and debugging)
</pre>
