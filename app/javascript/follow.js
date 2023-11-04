document.addEventListener("turbo:load", () => {
  const followButtons = document.querySelectorAll(".follow-button");
  
  followButtons.forEach((button) => {
    button.addEventListener("click", async (e) => {
      e.preventDefault();
      
      const userId = button.getAttribute("data-user-id");
      const follow1 = document.getElementById(`follow1_${userId}`);
      const follow2 = document.getElementById(`follow2_${userId}`);
      
      // 非同期リクエストでフォロー状態を取得
      const response = await fetch(`/users/${userId}/check_follow_status`, {
        method: "GET",
        headers: {
          "Accept": "application/json",
        },
      });
      
      if (response.ok) {
        const data = await response.json();
        
        if (data.following) {
          // フォロー中の場合
          follow1.style.display = "none";
          follow2.style.display = "block";
        } else {
          // フォローしていない場合
          follow1.style.display = "block";
          follow2.style.display = "none";
        }
      } else {
        // エラー処理
        console.error("フォロー状態の取得に失敗しました");
      }
    });
  });
});

 //const followButtons = document.querySelectorAll(".follow-button");
  //const follow1 = document.getElementById("follow1");
  //const follow2 = document.getElementById("follow2");

  //follow1.addEventListener("click", () => {
  //  follow1.style.display = "none";
  //  follow2.style.display = "block";
  //});

  //follow2.addEventListener("click", () => {
  //  follow1.style.display = "block";
  //  follow2.style.display = "none";
  //});


  //followButtons.forEach((button) => {
    //button.addEventListener("click", (e) => {

      // フォロー中・フォローするボタンを切り替える
      //const followButton = button.closest(".follow-button");
      //const unfollowButton = button.closest(".unfollow-button");

      //if (followButton) {
      //  followButton.style.display = "none";
      //  unfollowButton.style.display = "block";
      //} else {
      //  followButton.style.display = "block";
      //  unfollowButton.style.display = "none";
      //}
    //});
  //});
//});