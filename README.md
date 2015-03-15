## Lexical Scoping and <<- Tutorial
### Lexical scoping tutorial for help in understanding R Programming assignment 2.

Let's start simple and just play around at the command prompt first.

I'm going to assume you understand some basics and I'm going to just review them here:
If you typed `x <- 5` in at the command prompt, and then called `ls()`, you would see that x existed in the workspace and was listed. However, in a cleared workspace (by typing `rm(list=ls())`), if you created a function:
```{r}
sum5 <- function(x) {
        x <- x + 5
        print(x)
}
```
You could call this function, by typing `sum5(4)` and it would run the code, assign a value to x using your argument (4), and then assign a new value to x by adding x + 5.  Your new x will be 9, and the function will return 9, but any subsequent call of `ls()` will not show that x exists. That is because it doesn't. It only existed temporarily while the function was running its calculations.

What if we tried this:
```{r}
sum5 <- function(y) {
        x <<- y + 5
        print(x)
}
```
Now this is very different. The <<- operator means that x is not being assigned locally (within the function) but is being assigned in the environment in which the function was defined. In this case, that environment is the global environment.

So, if we ran `sum5(9)` here, the function returns the sum of 9 and 5, but now, if we call `ls()`, we will find that x exists in the workspace. We can type `x` and see that its value is 14.

What if we did this?:
```{r}
rm(list=ls())  ## clears the workspace
sum5 <- function(x) {
        x <<- x + 5
        print(x)
}
```

Now, if we ran `sum5(9)` here, the function will return the value of 9. Why? Try calling `ls()` this time. You will see that x does exist like it did before. The <<- operator defined x in the global environment, because that is where the function where <<- was used was defined. 

But why did the function print 9 and not 13?  The scoping rules of R mean that when we the function came to the line `print(x)`, it first looks locally, and the function has an x we used as an argument for the function. While this function is running, there are effectively two x's. When it is finished, there is only one.

Now, all of this could give you the wrong idea about the <<- operator, and make you think that it defines a value up one environment outside where it is used. So let's look at something more similar to the assignment functions. You may prefer to copy and paste these into an R script, then source them to the workspace:

```{r}
cacheSet <- function(x = NULL) {
        cache1 <- x
        getfunction <- function() cache1
        setfunction <- function(y = NULL) {
                cache1 <<- y 
        }
        list(get = getfunction, set = setfunction)
}
```
I've purposely made the function names different from the list object names which we use to access those functions, to aid in differentiation and readibility.

Here is the second function:
```{r}
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
```
Ok, did you copy and paste these into R? 

Let's look at what they do.

First, call the `cacheSet()` function. You can set the cache to be any object, and the results of this function need to be assigned to a variable. Here is one example:
```{r}
cache <- cacheSet(5)
```
This sets the cache as whatever you put in the argument, here we just cached the value 5. It then creates a short list of functions and assigns the list to the variable 'cache'. By creating these functions within another function, we have created an isolated environment where the functions were defined. This is where the <<- operator comes into play. When used in these functions, it assigns a variable which lives in that environment, where they were created. So when we call:
```{r}
cacheGetSet(cache, 6)
```
...we see the old cache value called up and printed, and the new value being set and printed. 

Because the functions being called in `cacheGetSet()` were created in another function, lexical scoping says that when the <<- operator is used, it assigns variables within that environment. When a function from that environment is called to return a value, that function first looks in that environment where it was created, and finds the values which were assigned with <<-.