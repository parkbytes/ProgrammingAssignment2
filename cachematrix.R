## Below are two R functions that create a special object to store a matrix
## and cache its inverse. It is assumed the matrix stored is invertible.

## The first function, makeCacheMatrix, creates a special object which is 
## a list whose elements are functions and does the following:
## - set the value of the matrix 
## - get the value of the matrix
## - set the value of the matrix's inverse
## - get the value of the matrix's inverse

## Note: The reference to parent (or enclosing) environment is also stored in the special object.
## The functions in list gain this rereferce when they are created during a call to makeCacheMatrix,  
## The matrix of interest and its inverse are part of this referenced environment and 
## their values are read or written when the respective function from the list is invoked. 

makeCacheMatrix <- function(x = matrix()) {
    matrixInv <- NULL # placeholder for storing inverse but nothing exists yet 

    set <- function(y) {
        x <<- y     # replaces matrix x in parent
        matrixInv <<- NULL    # nullify the inverse in cache whenever x changes
        
        message("New matrix stored and cache cleared! Use cacheSolve to refresh cache.")
    }
    
    get <- function() {
        x  
    }
        
    
    setInv <- function(inverse) {
        matrixInv <<- inverse #store the inverse matrix. 
    }
    
    getInv <- function() {
        matrixInv
    }
    
    ## Return a list containing above functions
    list(set = set, get = get, getInv = getInv, setInv = setInv)

}


## The cacheSolve function below computes the inverse of the matrix in the special object returned 
## by makeCacheMatrix function above.
##
## It does a check first on the special "matrix" object to see if the inverse is already calculated.
##
## If the check passes (i.e. inverse is already calculaetd and matrix hasn't changed since last calc) 
## then the inverse retrieved from the special object's cache is returned.
##
## Otherwise, the inverse is calculated using R's solve function and the result saved to the 
## special object's cache.

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of matrix in special object 'x'
         
        inverse <- x$getInv()  # using function in list to get value of matrix's inverse
        
        ##  inverse is not NULL means data in cache.
        if(!is.null(inverse)) {
            message("Retrieving cached data..")
            return(inverse)  # break execution here and return inverse matrix
        }
        
        #  inverse is NULL, so calculate inverse and store with the object
        data <- x$get()  # using list function to get value of matrix
        
        invData <- solve(data)  #calculate inverse matrix
        
        x$setInv(invData)  # save into cache using setInv list function 
        invData  # return inverse matrix
}

