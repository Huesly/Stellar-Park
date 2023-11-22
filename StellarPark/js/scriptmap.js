var isInfoPanelOpen = false; // Variable para rastrear si el panel de información está abierto
var infoPanel = document.getElementById("info-parking"); // Elemento de info-parq

function initMap() {
    var senaLocation = { lat: 7.117192172198442, lng: -73.1167041882077 };
    

    // Icono de los marcadores

    var parkingIcon = {
        url: 'https://maps.google.com/mapfiles/ms/icons/parkinglot.png',
        scaledSize: new google.maps.Size(32, 32),
    };

    // pre config para el mapa
    
    var mapOptions = {
        center: senaLocation,
        zoom: 15,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };

    var map = new google.maps.Map(document.getElementById("map"), mapOptions);


    // Marcadores que aparecen en el mapa

    var marker = new google.maps.Marker({
        position: senaLocation,
        map: map,
        title: "Ruby Parking",
        icon: parkingIcon,
    });

    // Marcadores que aparecen en el mapa

    var parkingLocation = { lat: 7.133944426539801, lng: -73.12003356594192 };

    var parkingMarker = new google.maps.Marker({
        position: parkingLocation,
        map: map,
        title: "Sena Bucaramanga",
        icon: parkingIcon,
    });

    // Event to get information at panel 

    parkingMarker.addListener("click", function () {
        if (!isInfoPanelOpen) {

            // Coloca informacion en el div info-panel
            infoPanel.innerHTML = `
                           
            <span id="close-button" onclick="closeInfoPanel()">X</span>
                <center><h2>Ruby Parking</h2>
                <label>Dirección:</label>
                <p>Carrera 25 #45-22</p>
                <p>Teléfono:</p>
                <p> +57 312-576-3227</p>
                <p>Capacidad: <br>Motos: 50 puestos</br><br>Vehiculo: 4 puestos</br></p>
                <p>Tarifa:</p>
                <p>Hora: <br>Motos: $1.000</br><br>Vehiculo: $2.200</br></p>
                <p>Mensualidad: <br>Motos: $35.000</br><br>Vehiculo: $130.000</br></p>
                <p>Horarios: 7PM A 8PM Lunes a Domingo</p></center>
            `;
            isInfoPanelOpen = true;
        } else {
            closeInfoPanel();
        }
    });
}

// Deja el panel de informacion limpio

function closeInfoPanel() {
    infoPanel.innerHTML = ""; 
    isInfoPanelOpen = false;
}

google.maps.event.addDomListener(window, 'load', initMap);
