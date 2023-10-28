document.addEventListener("DOMContentLoaded", function() {
  // Intersection Observerのオプションを設定
  const options = {
    root: null, // ビューポートをルートとして使用
    rootMargin: "0px", // ルートのmargin
    threshold: 0.1 // 画像が10%ビューポートに入ったら読み込む
  };

  // Intersection Observerを作成
  const observer = new IntersectionObserver(handleIntersection, options);

  // 画像要素を取得し、監視対象に追加
  const images = document.querySelectorAll(".lazy-load");
  images.forEach(image => {
    observer.observe(image);
  });
});

// Intersection Observerのコールバック
function handleIntersection(entries, observer) {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      const image = entry.target;
      // 画像の`data-src`属性に実際の画像URLが設定されていると仮定
      const src = image.getAttribute("data-src");
      image.src = src;
      // 画像の読み込みをトリガーしたら監視を停止
      observer.unobserve(image);
    }
  });
};
