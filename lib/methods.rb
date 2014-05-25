# this allows you to input a proc such as THREE that has been defined and repeats 
# the operation as many times as the number itself in order to return it
def to_integer(proc)
    proc[-> n { n + 1 }][0]
end

# returns a real true/false value by evaluating it as true/false
def to_boolean(proc)
  IF[true][false]
end

