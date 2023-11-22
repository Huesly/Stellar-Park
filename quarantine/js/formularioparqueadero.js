const formulario = document.getElementById('formulario');
const inputs = document.querySelectorAll('#formulario input');

const expresiones = {
    nit: /^\d{8,10}-\d$/, // NIT en formato numérico con 8 a 10 dígitos, seguido de un guion y un dígito.
    nombre: /^[a-zA-ZÀ-ÿ\s]{1,40}$/, // Letras y espacios, pueden llevar acentos.
    password: /^.{4,12}$/, // 4 a 12 dígitos.
    correo: /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/,
    telefono: /^\d{7,14}$/, // 7 a 14 dígitos.
}

const campos = {
    nit: false,
    nombre: false,
    password: false,
    correo: false,
    telefono: false
}

const validarFormulario = (e) => {
    switch (e.target.name) {
        case "nit":
            validarCampo(expresiones.nit, e.target, 'nit');
            break;
        case "nombre":
            validarCampo(expresiones.nombre, e.target, 'nombre');
            break;
        case "password":
            validarCampo(expresiones.password, e.target, 'password');
            validarPassword2();
            break;
        case "password2":
            validarPassword2();
            break;
        case "correo":
            validarCampo(expresiones.correo, e.target, 'correo');
            break;
        case "telefono":
            validarCampo(expresiones.telefono, e.target, 'telefono');
            break;
    }
}

const validarCampo = (expresion, input, campo) => {
    if (expresion.test(input.value)) {
        document.getElementById(`grupo__${campo}`).classList.remove('formulario__grupo-incorrecto');
        document.getElementById(`grupo__${campo}`).classList.add('formulario__grupo-correcto');
        document.querySelector(`#grupo__${campo} i`).classList.add('fa-check-circle');
        document.querySelector(`#grupo__${campo} i`).classList.remove('fa-times-circle');
        document.querySelector(`#grupo__${campo} .formulario__input-error`).classList.remove('formulario__input-error-activo');
        campos[campo] = true;
    } else {
        document.getElementById(`grupo__${campo}`).classList.add('formulario__grupo-incorrecto');
        document.getElementById(`grupo__${campo}`).classList.remove('formulario__grupo-correcto');
        document.querySelector(`#grupo__${campo} i`).classList.add('fa-times-circle');
        document.querySelector(`#grupo__${campo} i`).classList.remove('fa-check-circle');
        document.querySelector(`#grupo__${campo} .formulario__input-error`).classList.add('formulario__input-error-activo');
        campos[campo] = false;
    }
}

inputs.forEach((input) => {
    input.addEventListener('keyup', validarFormulario);
    input.addEventListener('blur', validarFormulario);
});

formulario



formulario.addEventListener('submit', (e) => {
    e.preventDefault();

    const terminos = document.getElementById('terminos');

    if (campos.nit && campos.nombre && campos.correo && campos.telefono && terminos.checked) {
        formulario.reset();

        document.getElementById('formulario__mensaje-exito').classList.add('formulario__mensaje-exito-activo');
        setTimeout(() => {
            document.getElementById('formulario__mensaje-exito').classList.remove('formulario__mensaje-exito-activo');
        }, 5000);

        document.querySelectorAll('.formulario__grupo-correcto').forEach((icono) => {
            icono.classList.remove('formulario__grupo-correcto');
        });

        window.location.href = "registropark.html"; // Cambiar al menú principal
    } else {
        document.getElementById('formulario__mensaje').classList.add('formulario__mensaje-activo');
    }
});





// agregar input box extra si es necesario 


let contadorCamposVehiculo = 1; // Inicializado con 1 campo existente
let contadorCamposMensualidad = 1; // Inicializado con 1 campo existente

function agregarCampo2() {
	if (contadorCamposMensualidad < 4) {
		contadorCamposMensualidad++;
		const nuevoCampo2 = document.createElement('div');
		nuevoCampo2.classList.add('formulario__grupo-input');
		nuevoCampo2.innerHTML = `
			<label for="mensualidad${contadorCamposMensualidad}" class="formulario__label">Costo mensualidad ${contadorCamposMensualidad}</label>
			<input type="text" class="formulario__input" id="mensualidad name="mensualidad" ${contadorCamposMensualidad}" placeholder="Digitar precio mensualidad">
			<button type="button" class="formulario__btn" onclick="eliminarCampo2(this)">Eliminar</button>
		`;
		document.getElementById('campos-extra-mensualidad').appendChild(nuevoCampo2)
	} else {
		botonAgregar2.disabled = true;
	}
}

function agregarCampo() {
	if (contadorCamposVehiculo < 4) {
		contadorCamposVehiculo++;
		const nuevoCampo = document.createElement('div');
		nuevoCampo.classList.add('formulario__grupo-input');
		nuevoCampo.innerHTML = `
			<label for="vehiculo${contadorCamposVehiculo}" class="formulario__label">Costo por hora, ${contadorCamposVehiculo}</label>
			<input type="text" class="formulario__input" id="vehiculo1 name="vehiculo1" ${contadorCamposVehiculo}" placeholder="Digitar precio">
			<button type="button" class="formulario__btn" onclick="eliminarCampo(this)">Eliminar</button>
		`;
		document.getElementById('campos-extra-vehiculo').appendChild(nuevoCampo);
	} else {
		botonAgregar.disabled = true;
	}
}



function eliminarCampo(button) {
	const campoAEliminar = button.parentElement;
	campoAEliminar.remove();
	contadorCamposVehiculo--;
	botonAgregar.disabled = false; // Habilita el botón de agregar después de eliminar un campo
}

function eliminarCampo2(button) {
	const campoAEliminar2 = button.parentElement;
	campoAEliminar2.remove();
	contadorCamposMensualidad--;
	botonAgregar2.disabled = false; // Habilita el botón de agregar después de eliminar un campo
}





