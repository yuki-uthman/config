#!/usr/bin/env fish

# exexute grep 
if grep fish /etc/shells
    echo Found fish
else if grep bash /etc/shells
    echo Found bash
else
    echo Got nothing
end

# compares string
if test "$fish" = "flounder"
    echo FLOUNDER
end

# or

# compares number
if test "$number" -gt 5
    echo $number is greater than five
else
    echo $number is five or less
end
