function! s:BufInfo()
  echo "\n----- バッファに関する情報 -----"
  echo "bufnr('%') = " . bufnr('%') . "	// 現在のバッファ番号"
  echo "bufnr('$') = " . bufnr('$') . "	// 最後のバッファ番号"
  echo "bufnr('#') = " . bufnr('#') . "	// 直前のバッファ番号？（仕様がよくわからない）"
  for i in range(1, bufnr('$'))
    echo  "bufexists(" . i . ") = ".bufexists(i)
    echon " buflisted(" . i . ") = ".buflisted(i)
    echon " bufloaded(" . i . ") = ".bufloaded(i)
    echon " bufname(" . i . ") = ".bufname(i)
  endfor
  echo "// bufexists(n) = バッファnが存在するか"
  echo "// buflisted(n) = バッファnがリストにあるか"
  echo "// bufloaded(n) = バッファnがロード済みか"
  echo "// bufname(n) = バッファnの名前"

  echo "\n----- ウィンドウに関する情報 -----"
  echo "winnr() = "    . winnr()    . "	// 現在のウィンドウ番号"
  echo "winnr('$') = " . winnr('$') . "	// 最後のウィンドウ番号"
  echo "winnr('#') = " . winnr('#') . "	// 直前のウィンドウ番号？（仕様がよくわからない）"
  for i in range(1, winnr('$'))
    echo "winbufnr(" . i . ") = ".winbufnr(i) . "	// ウィンドウ" . i . "に関連付くバッファ番号"
  endfor


endfunction
command! -nargs=0 BufInfo call s:BufInfo()


" [bufinfo zettel](2107160706)
" [fuzzy finder](2107132016)
