function neovroom

  if test -z $argv[1]
    vroom --crawl --neovim --servername=FOO --out vroom.out
  else
    vroom vroom/$argv[1] --neovim --servername=FOO --out vroom.out
  end

  nvim -c "Vroom" vroom.out

end
