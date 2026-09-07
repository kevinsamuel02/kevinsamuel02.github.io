// ===== Año dinámico en el footer =====
document.getElementById('year').textContent = new Date().getFullYear();

// ===== Navbar: fondo al scrollear =====
const navbar = document.getElementById('navbar');
window.addEventListener('scroll', () => {
    navbar.classList.toggle('scrolled', window.scrollY > 10);
}, { passive: true });

// ===== Menú mobile =====
const navToggle = document.getElementById('nav-toggle');
const navLinks = document.getElementById('nav-links');

navToggle.addEventListener('click', () => {
    navToggle.classList.toggle('open');
    navLinks.classList.toggle('open');
});

navLinks.querySelectorAll('a').forEach(link => {
    link.addEventListener('click', () => {
        navToggle.classList.remove('open');
        navLinks.classList.remove('open');
    });
});

// ===== Scrollspy: resalta el link de la sección visible =====
const sections = document.querySelectorAll('section[id], header[id]');
const navAnchors = document.querySelectorAll('.nav-links a');

const spyObserver = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        const id = entry.target.getAttribute('id');
        const anchor = document.querySelector(`.nav-links a[href="#${id}"]`);
        if (!anchor) return;
        if (entry.isIntersecting) {
            navAnchors.forEach(a => a.classList.remove('active'));
            anchor.classList.add('active');
        }
    });
}, { rootMargin: '-45% 0px -50% 0px', threshold: 0 });

sections.forEach(section => spyObserver.observe(section));

// ===== Toggle de tema claro/oscuro (persistido) =====
const themeToggle = document.getElementById('theme-toggle');
const root = document.documentElement;
const savedTheme = localStorage.getItem('theme');

if (savedTheme) {
    root.setAttribute('data-theme', savedTheme);
} else if (window.matchMedia('(prefers-color-scheme: light)').matches) {
    root.setAttribute('data-theme', 'light');
}

themeToggle.addEventListener('click', () => {
    const current = root.getAttribute('data-theme') === 'light' ? 'light' : 'dark';
    const next = current === 'light' ? 'dark' : 'light';
    root.setAttribute('data-theme', next);
    localStorage.setItem('theme', next);
});

// ===== Scroll reveal =====
const revealObserver = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.classList.add('in-view');
            revealObserver.unobserve(entry.target);
        }
    });
}, { threshold: 0.15 });

document.querySelectorAll('.reveal, .reveal-stagger').forEach(el => revealObserver.observe(el));

// ===== Email: copiar al portapapeles como respaldo de mailto =====
const emailLink = document.getElementById('email-link');
const copyToast = document.getElementById('copy-toast');

emailLink.addEventListener('click', () => {
    const email = emailLink.getAttribute('data-email');
    if (navigator.clipboard) {
        navigator.clipboard.writeText(email).then(() => {
            copyToast.classList.add('visible');
            setTimeout(() => copyToast.classList.remove('visible'), 2000);
        }).catch(() => {});
    }
});

// ===== Botón volver arriba =====
const backToTop = document.getElementById('back-to-top');
window.addEventListener('scroll', () => {
    backToTop.classList.toggle('visible', window.scrollY > 500);
}, { passive: true });

backToTop.addEventListener('click', () => {
    window.scrollTo({ top: 0, behavior: 'smooth' });
});

// ===== Estadísticas académicas =====
const datosAcademicos = {
    totalMateriasPlan: 43, // Total de materias del plan de estudios
    materias: [
        // Estados posibles: "Promocionada", "Final", "Cursada" (si debes final)
        { nombre: "Álgebra y Geometría Analítica", nota: 8, estado: "Promocionada" },
        { nombre: "Análisis de Sistemas de Información", nota: 10, estado: "Final" },
        { nombre: "Sistemas y Procesos de Negocios", nota: 9, estado: "Promocionada" },
        { nombre: "Análisis Matemático I", nota: 10, estado: "Promocionada" },
        { nombre: "Análisis Matemático II", nota: 8, estado: "Promocionada" },
        { nombre: "Arquitectura de Computadores", nota: 8, estado: "Promocionada" },
        { nombre: "Física I", nota: 10, estado: "Promocionada" },
        { nombre: "Física II", nota: 8, estado: "Promocionada" },
        { nombre: "Ingeniería y Sociedad", nota: 9, estado: "Promocionada" },
        { nombre: "Lógica y Estructuras Discretas", nota: 6, estado: "Final" },
        { nombre: "Probabilidad y Estadística", nota: 9, estado: "Promocionada" },
        { nombre: "Algoritmos y Estructuras de Datos", nota: 10, estado: "Final" },
        { nombre: "Sintaxis y Semántica de los Lenguajes", nota: 9, estado: "Promocionada" },
        { nombre: "Ingles Técnico I", nota: 8, estado: "Final" },
        { nombre: "Paradigmas de Programacion", nota: 8, estado: "Promocionada" },
        { nombre: "Sistemas Operativos", nota: 9, estado: "Promocionada" },
        { nombre: "Economía", nota: 9, estado: "Promocionada" },
        { nombre: "Análisis Numérico", nota: 9, estado: "Promocionada" },
        // Ejemplo de materia cursada pero sin final:
        // { nombre: "Análisis Matemático II", nota: null, estado: "Cursada" },
    ]
};

function cargarEstadisticas() {
    const materias = datosAcademicos.materias;

    const promocionadas = materias.filter(m => m.estado === 'Promocionada').length;
    const finales = materias.filter(m => m.estado === 'Final').length;
    const cursadas = materias.filter(m => m.estado === 'Cursada').length;
    const aprobadasTotal = promocionadas + finales;
    const pendientes = datosAcademicos.totalMateriasPlan - (aprobadasTotal + cursadas);

    const materiasConNota = materias.filter(m => m.nota !== null && m.nota > 0);
    const sumaNotas = materiasConNota.reduce((sum, m) => sum + m.nota, 0);
    const promedio = materiasConNota.length > 0 ? (sumaNotas / materiasConNota.length).toFixed(2) : 0;

    const porcentaje = Math.min(100, (aprobadasTotal / datosAcademicos.totalMateriasPlan) * 100).toFixed(1);

    document.getElementById('promedio-val').innerText = promedio;
    document.getElementById('materias-val').innerText = `${aprobadasTotal} / ${datosAcademicos.totalMateriasPlan}`;
    document.getElementById('progreso-val').innerText = `${porcentaje}%`;

    setTimeout(() => {
        document.getElementById('progress-fill').style.width = `${porcentaje}%`;
    }, 500);

    const isLight = document.documentElement.getAttribute('data-theme') === 'light';
    const accent = isLight ? '#0284c7' : '#38bdf8';
    const accent2 = isLight ? '#0369a1' : '#2e86de';

    const ctx = document.getElementById('miCarreraChart').getContext('2d');
    new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: ['Promocionadas', 'Final Aprobado', 'Debo Final', 'Pendientes'],
            datasets: [{
                data: [promocionadas, finales, cursadas, pendientes],
                backgroundColor: [accent, accent2, '#feca57', '#576574'],
                borderWidth: 0
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: 'bottom',
                    labels: { color: getComputedStyle(document.body).getPropertyValue('--text-muted') }
                }
            }
        }
    });

    const listaContainer = document.getElementById('subjects-list');
    listaContainer.innerHTML = '';

    materias.forEach(m => {
        if (!m.nota) return;

        const div = document.createElement('div');
        div.className = 'subject-item';
        const esNotaAlta = m.nota >= 9;
        div.innerHTML = `<span class="subject-name">${m.nombre}</span><span class="subject-grade ${esNotaAlta ? 'high' : ''}">${m.nota}</span>`;
        listaContainer.appendChild(div);
    });

    // El observer de reveal ya corrió sobre el contenedor vacío; forzamos visibilidad de las materias.
    listaContainer.classList.add('in-view');
}

document.addEventListener('DOMContentLoaded', cargarEstadisticas);
