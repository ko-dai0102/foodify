document.addEventListener("turbo:load", () => {
const followerOpen = document.getElementById("followerModalOpen");
const followingOpen = document.getElementById("followingModalOpen");
const buttonClose = document.querySelector(".modalClose")
const modal = document.getElementById("modal")

followerOpen.addEventListener("click", () => {
  modal.style.display = "block";
});

buttonClose.addEventListener("click", () => {
  modal.style.display = "none";
});

document.addEventListener("click", (e) => {
  if(e.target == modal) {
    modal.style.display = "none";
  };
});

}); 