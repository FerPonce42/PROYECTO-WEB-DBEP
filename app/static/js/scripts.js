// Espera a que el DOM esté completamente cargado
document.addEventListener('DOMContentLoaded', function() {
    // Menú desplegable
    const dropdowns = document.querySelectorAll('.dropdown');

    dropdowns.forEach(dropdown => {
        dropdown.addEventListener('mouseover', function() {
            this.querySelector('.dropdown-content').style.display = 'block';
        });

        dropdown.addEventListener('mouseout', function() {
            this.querySelector('.dropdown-content').style.display = 'none';
        });
    });

    // Carrusel de imágenes
    let currentIndex = 0;
    const slides = document.querySelectorAll('.carousel img');
    const indicators = document.querySelectorAll('.carousel-indicators button');

    function showSlide(index) {
        slides.forEach((slide, i) => {
            slide.classList.toggle('fade', i !== index);
            indicators[i].classList.toggle('active', i === index);
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
function ocultarTodasLasSecciones() {
    var secciones = document.querySelectorAll('.rectangulo');
    secciones.forEach(function(seccion) {
        seccion.classList.remove('visible');
        seccion.classList.add('oculto');
    });
}
document.querySelectorAll('.barra-opciones a').forEach(function(link) {
    link.addEventListener('click', function(e) {
        e.preventDefault();
        var target = this.getAttribute('data-target');
        alternarSeccion(target); 
    });
});
});
