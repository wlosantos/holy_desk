import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    // Encontra o input e o tooltip dentro do elemento controlado
    const input = this.element.querySelector("input");
    const tooltip = this.element.querySelector("div.absolute");

    if (input && tooltip) {
      // Mostrar o tooltip imediatamente se há um erro
      if (input.classList.contains("border-red-500")) {
        tooltip.classList.remove(
          "invisible",
          "opacity-0",
          "group-hover:visible",
          "group-hover:opacity-100"
        );
        tooltip.classList.add("visible", "opacity-100");

        // Configurar um timer para esconder o tooltip após alguns segundos (opcional)
        setTimeout(() => {
          // Deixa visível no hover após o timeout
          tooltip.classList.add(
            "invisible",
            "opacity-0",
            "group-hover:visible",
            "group-hover:opacity-100"
          );
          tooltip.classList.remove("visible", "opacity-100");
        }, 5000); // Esconde após 5 segundos
      }

      // Mostrar no focus ainda
      input.addEventListener("focus", () => {
        tooltip.classList.remove("invisible", "opacity-0");
        tooltip.classList.add("visible", "opacity-100");
      });

      // Esconder no blur
      input.addEventListener("blur", () => {
        tooltip.classList.add("invisible", "opacity-0");
        tooltip.classList.remove("visible", "opacity-100");
      });
    }
  }
}
