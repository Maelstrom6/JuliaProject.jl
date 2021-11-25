export double

"""
    double(x)
    double(x::String)

Doubles things

# Examples
```jldoctest
using JuliaProject

double(2)

# output

4
```
"""
double(x) = 2x
double(x::String) = x * x
