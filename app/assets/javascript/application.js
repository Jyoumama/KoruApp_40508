// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "delete_reservation" 

import { Turbo } from "@hotwired/turbo-rails";
Turbo.start();

document.addEventListener("turbo:load", () => {
  document.addEventListener("click", (event) => {
    if (event.target.matches(".delete-reservation")) {
      event.preventDefault();
      const confirmResult = confirm("削除してよろしいですか？");
      if (confirmResult) {
        const link = event.target;
        const url = link.getAttribute("href");
        const csrfToken = document.querySelector(
          'meta[name="csrf-token"]'
        ).content;
        fetch(url, {
          method: "DELETE",
          headers: {
            "X-CSRF-Token": csrfToken,
            "Content-Type": "application/json",
          },
          credentials: "same-origin",
        }).then((response) => {
          if (response.ok) {
            // 削除が成功した場合は、Turboを使用して現在のページを置換
            Turbo.visit(window.location.href, { action: "replace" });
          }
        });
      }
    }
  });
});