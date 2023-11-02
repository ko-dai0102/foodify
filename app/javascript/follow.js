document.addEventListener("turbo:load", () => {
  const followButtons = document.querySelectorAll(".follow-button");

  followButtons.forEach((button) => {
    button.addEventListener("click", (e) => {

      // フォロー中・フォローするボタンを切り替える
      const followButton = button.closest(".follow-button");
      const unfollowButton = button.closest(".unfollow-button");

      if (followButton) {
        followButton.style.display = "none";
        unfollowButton.style.display = "block";
      } else {
        followButton.style.display = "block";
        unfollowButton.style.display = "none";
      }
    });
  });
});