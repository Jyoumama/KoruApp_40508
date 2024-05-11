import { Turbo } from "@hotwired/turbo-rails";

document.addEventListener("turbo:load", () => {
    document.addEventListener("click", (event) => {
        if (event.target.matches(".delete-reservation")) {
            event.preventDefault();
            const confirmResult = confirm("削除してよろしいですか？");
            if (confirmResult) {
                const link = event.target;
                const url = link.getAttribute("href");
                const csrfToken = document.querySelector('meta[name="csrf-token"]').content;
                fetch(url, {
                    method: "DELETE",
                    headers: {
                        "X-CSRF-Token": csrfToken,
                        "Content-Type": "application/json",
                    },
                    credentials: "same-origin",
                }).then((response) => {
                    if (response.ok) {
                        // Successful deletion will replace the current page using Turbo
                        Turbo.visit(window.location.href, { action: "replace" });
                    }
                });
            }
        }
    });
});
