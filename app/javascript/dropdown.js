const parentMenuItem = document.querySelectorAll('.menu-item');

// イベントを付加
for (let i = 0; i < parentMenuItem.length; i++) {
  parentMenuItem[i].addEventListener('mouseover', dropDownMenuOpen);
  parentMenuItem[i].addEventListener('mouseleave', dropDownMenuClose);
}


// ドロップダウンメニューを開く処理
function dropDownMenuOpen(e) {
  // 子メニューa要素
  const childMenuLink = e.currentTarget.querySelectorAll('.drop-menu-link');

  // is-activeを付加
  for (let i = 0; i < childMenuLink.length; i++) {
    childMenuLink[i].classList.add('is-active');
  }
}

// ドロップダウンメニューを閉じる処理
function dropDownMenuClose(e) {
  // 子メニューリンク
  const childMenuLink = e.currentTarget.querySelectorAll('.drop-menu-link');
  
  // is-activeを削除
  for (let i = 0; i < childMenuLink.length; i++) {
    childMenuLink[i].classList.remove('is-active');
  }
}