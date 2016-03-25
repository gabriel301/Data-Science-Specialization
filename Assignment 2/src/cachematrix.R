## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function
##This function creates a special "matrix" object that can cache its inverse.
makeCacheMatrix <- function(x = matrix()) {
        ##set the inverse of the matrix as null everytime a new matrix is created
        inv <- NULL
        
        ##Set the matrix. If a new matrix is set, this inverse is set to null
        set<- function(y)
        {
          x<<-y
          inv<<-NULL
        }
        
        ##get the matrix data
        get<- function() x
        
        ##set the inverse of the matrix
        setInv <- function(i) inv<<-i
        
        #get the inverse of the Matrix
        getInv <- function() inv
        
        ##put the functions in a list
        list(set=set,get=get,setInv = setInv, getInv=getInv)

}


## Write a short comment describing this function
##This function computes the inverse of the special "matrix" returned by makeCacheMatrix above. If the inverse has already been calculated (and the matrix has not changed),
##then the cachesolve should retrieve the inverse from the cache.
cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
        inv<- x$getInv()
        ##if the inverse is already calculated, return the pre-calculated value
        if(!is.null(inv))
        {
          message("getting cached data")
          return(inv)
        }
        ##if the inverse is not calculated yet, get the matrix and
        ##calculate its inverse and then return the inverse
        data<- x$get()
        inv<- solve(data,...)
        x$setInv(inv)
        inv
}
