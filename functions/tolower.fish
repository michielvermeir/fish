function tolower --wraps='tr' --description='converts all characters in a string to lowercase'
  tr '[:upper:]' '[:lower:]' $argv; 
end
