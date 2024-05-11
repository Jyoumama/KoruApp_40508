import { Turbo } from "@hotwired/turbo-rails";
Turbo.start();

document.addEventListener("turbo:load", function() {
  document.querySelectorAll('.delete-reservation').forEach(element => {
    element.addEventListener('click', function(event) {
      if (!confirm('本当に削除してよろしいですか？')) {
        event.preventDefault(); // キャンセルされた場合はリクエストを阻止
      }
    });
  });
});
  //document.addEventListener("click", function(event) => {
    // if (event.target.matches(".delete-reservation")) {
    //   event.preventDefault();
    //   const confirmResult = confirm("削除してよろしいですか？");
    //   if (confirmResult) {
    //     const link = event.target;
    //     const url = link.getAttribute("href");
    //     const csrfToken = document.querySelector(
    //       'meta[name="csrf-token"]'
    //     ).content;
    //     fetch(url, {
    //       method: "DELETE",
    //       headers: {
    //         "X-CSRF-Token": csrfToken,
    //         "Content-Type": "application/json",
    //       },
    //       credentials: "same-origin",
    //     }).then((response) => {
    //       if (response.ok) {
    //         // 削除が成功した場合は、Turboを使用して現在のページを置換
    //         Turbo.visit(window.location.href, { action: "replace" });
    //       }
    //     });
    //   }
    // }
//   });
// });
