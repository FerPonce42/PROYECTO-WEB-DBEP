// carreras.js

// Función para mostrar las pestañas
function showTab(tabName) {
    console.log(`Mostrando la pestaña: ${tabName}`); // Para depuración
    const tabs = document.querySelectorAll('.text-section');
    tabs.forEach(tab => {
        // Mantener la sección de detalles siempre visible
        if (tab.id === tabName || tab.classList.contains('details')) {
            tab.classList.remove('oculto');
        } else {
            tab.classList.add('oculto');
        }
    });
}

// Espera a que el DOM esté completamente cargado
document.addEventListener('DOMContentLoaded', function() {
    // Asegúrate de que la sección de detalles siempre esté visible
    const detalles = document.querySelector('.details');
    detalles.classList.remove('oculto'); // Asegúrate de que no esté oculta

    // Event listeners para los enlaces del menú
    document.querySelectorAll('.barra-opciones a').forEach(function(link) {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            var target = this.getAttribute('data-target');
            showTab(target); // Llama a la función para mostrar la sección correspondiente
        });
    });
});
