function process_stdin
  # read stdin and assign to variable
  read -z stdin

  # check that stdin is not empty
  if string length -q $stdin
    echo $stdin | yj | jaq $argv
  end
end

function process_args
  set filter $argv[1]
  set files $argv[2..-1]

  for file in $files
    set contents (cat $file)
    if string length -q $contents
      echo $contents | yj | jaq $filter
    end
  end
end

function yaq --description='yj | jaq' --wraps 'jaq'
  # set fish_trace 0

  if test (count $argv) -eq 0
    jaq --help
    return 1
  end

  if test (count $argv) -eq 1
    process_stdin $argv
    return $status
  end

  if test (count $argv) -gt 1
    process_args $argv
    return $status
  end

  echo "yaq: invalid arguments: $argv"
  return 1
end
