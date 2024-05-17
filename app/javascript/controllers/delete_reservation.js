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

