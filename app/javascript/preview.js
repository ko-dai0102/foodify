document.addEventListener('turbo:load', function(){
  const itemForm = document.getElementById('new_item');
  const previewSpace = document.getElementById('previews');

  if (!itemForm) return null;

  const fileField = document.getElementById('item_form_image');
  fileField.addEventListener('change', function(e){
    const file = e.target.files[0];
    const blob = window.URL.createObjectURL(file);

    // 既存のプレビューをクリア
    previewSpace.innerHTML = '';

    // divを生成
    const previewWrapper = document.createElement('div');
    previewWrapper.setAttribute('class', 'preview');

    // 画像を生成
    const previewImage = document.createElement('img');
    previewImage.setAttribute('class', 'preview-image');
    previewImage.setAttribute('src', blob);

    // 画像をブラウザに表示
    previewSpace.appendChild(previewWrapper);
    previewWrapper.appendChild(previewImage);
  });
});