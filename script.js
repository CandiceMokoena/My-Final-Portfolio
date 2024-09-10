let menuIcon = document.querySelector("#menu-icon");
let navbar = document.querySelector(`.navbar`);

menuIcon.onclick = () => {
  menuIcon.classList.toggle("bx-x");
  navbar.classList.toggle("active");
  console.log("Menu toggled");
};
document.addEventListener("DOMContentLoaded", function () {
  let readMoreBtn = document.querySelector("#read-more-btn");
  let moreInfo = document.querySelector("#more-info");

  readMoreBtn.onclick = function () {
    if (moreInfo.style.display === "none") {
      moreInfo.style.display = "block"; // Show the additional paragraph
      readMoreBtn.textContent = "Read Less"; // Change button text
    } else {
      moreInfo.style.display = "none"; // Hide the additional paragraph
      readMoreBtn.textContent = "Read More"; // Change button text
    }
  };
});
AOS.init();
