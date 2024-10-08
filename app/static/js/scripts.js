
// Espera a que el DOM esté completamente cargado
document.addEventListener('DOMContentLoaded', function() {
// Menú Desplegable: Controla la funcionalidad de mostrar y ocultar el contenido del menú desplegable
const dropdowns = document.querySelectorAll('.dropdown');

dropdowns.forEach(dropdown => {
    dropdown.addEventListener('mouseover', function() {
        this.querySelector('.dropdown-content').style.display = 'block';
    });

    dropdown.addEventListener('mouseout', function() {
        this.querySelector('.dropdown-content').style.display = 'none';
    });
});

  // Carrusel de Imágenes: Maneja la lógica para mostrar y cambiar automáticamente las imágenes del carrusel
let currentIndex = 0;
const slides = document.querySelectorAll('.carousel img');
const indicators = document.querySelectorAll('.carousel-indicators button');

function showSlide(index) {
    const carouselWidth = document.querySelector('.carousel').clientWidth;

    slides.forEach((slide, i) => {
        slide.style.transform = `translateX(${(i - index) * carouselWidth}px)`;
    });

    indicators.forEach((indicator, i) => {
        indicator.classList.toggle('active', i === index);
    });

    currentIndex = index;
}

indicators.forEach((button, index) => {
    button.addEventListener('click', () => showSlide(index));
});

showSlide(0);

setInterval(function() {
    let nextIndex = (currentIndex + 1) % slides.length;
    showSlide(nextIndex);
}, 5000);


// Alternancia de Secciones: Alterna la visibilidad de diferentes secciones según la interacción del usuario
function alternarSeccion(seccionId) {
    var seccion = document.getElementById(seccionId);
    if (seccion.classList.contains('visible')) {
        seccion.classList.remove('visible');
        seccion.classList.add('oculto');
    } else {
        ocultarTodasLasSecciones(); 
        seccion.classList.remove('oculto');
        seccion.classList.add('visible');
    }
}
// Ocultar Todas las Secciones: Función que oculta todas las secciones visibles en la página
function ocultarTodasLasSecciones() {
    var secciones = document.querySelectorAll('.rectangulo');
    secciones.forEach(function(seccion) {
        seccion.classList.remove('visible');
        seccion.classList.add('oculto');
    });
}
//Agrega eventos a los enlaces para alternar las secciones al hacer clic en ellos
document.querySelectorAll('.barra-opciones a').forEach(function(link) {
    link.addEventListener('click', function(e) {
        e.preventDefault();
        var target = this.getAttribute('data-target');
        alternarSeccion(target); 
    });
});
});
