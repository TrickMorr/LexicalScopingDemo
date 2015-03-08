## lexical scoping function demo

## This is a very basic demo of the concept of lexical
## scoping in the context of assignment 2.

## These two functions work together much in the 
## same way that the two functions in the vector
## sample from the assignment do, and also in the 
## way that your two matrix functions will when you 
## complete the assignment.

## The main difference is that these are VERY simple.

## This first function takes one argument of any object. 
## If no argument is entered, default behavior sets the
## cache to NULL.




cacheSet <- function(x = NULL) {
        cache1 <- x
        getfunction <- function() cache1
        setfunction <- function(y = NULL) {
                cache1 <<- y 
        }
        list(get = getfunction, set = setfunction)
}

## The output of the cacheSet function is a list, which 
## should be assigned to a variable, like this:
## YourVariable <- cacheSet("any object you want")

## The list has two only items, named, in the list,
## 'get' and 'set', and which are the functions;
## getfunction() and setfunction().

## The functions in the list are called by the second 
## function created in this script: 'cacheGetSet()', but
## can also be called by the user via the list index 
## operator,'$', like this:

## YourVariable$get()
## YourVariable$set()

## the $get() function returns whatever is stored 
## in the cache. It takes no argument, and will return 
## an error if given one.

## The $set() function takes one argument, and that can be
## any object you wish to store in the cache. If no argument
## is entered, default sets cache to NULL. 

## Now for the next function:

cacheGetSet <- function(cache, x = NULL, ...) {
        cache2 <- cache$get()
        message("Checking cache...")
        if(is.null(cache2)) {
                message("No previously cached value.")
        } else { 
                print(cache2)
        }
        message("Setting new cached value...")
        cache$set(x)
        print(cache$get())
        message("Finished.")
        
        
}

## This function takes two arguments: whatever variable 
## you assigned the results of the first function to, and
## a new object to be stored in the cache. If no new object
## is entered, default behavior sets the cache to NULL.

## The only output of this function are the messages.
## This way, if the cached value were something 
## extremely large, it is not printed to the workspace, and
## you can decide to look at it by calling $get() 
## in any way you like.

## For example, if the object stored in the cache were a very
## large matrix, you could check it using expressions like:
## dim(YourVariable$get())
## head(YourVariable$get())
## ... and so on.

