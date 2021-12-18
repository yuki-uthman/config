function neovroom

  vroom --crawl --neovim --servername=FOO --out vroom.out

  nvim -c "Vroom" vroom.out

end
