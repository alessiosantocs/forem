function enableReadMore() {
  document.querySelectorAll(".crayons-story__content-preview").forEach(function (item) {
    const parent = item;
    if (parent.className.includes("read-")) {
      return;
    }
    const innerContent = item.children[0];
    if (innerContent.clientHeight > parent.clientHeight) {
      parent.className += " read-more";
    }
  })

  document.querySelectorAll(".crayons-story__content-preview > button.btn-read-more").forEach(function (item) {
    item.addEventListener("click", function () {
      const parent = item.parentElement;
      parent.className = parent.className.replace("read-more", "read-all");
    })
  })
}

window.setInterval(enableReadMore, 100);
