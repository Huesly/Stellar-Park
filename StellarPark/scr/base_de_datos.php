<?php
/*
CRUD con PostgreSQL y PHP
@Carlos Eduardo Perez Rueda
@Fecha: 2023-05-08
==============================================================================
Este archivo se encarga de conectar a la base de datos y traer un objeto PDO
==============================================================================
 */
/*echo "Entré a conectarme";*/
$contraseña         = "yoshida-san0712";
$usuario            = "postgres";
$nombreBaseDeDatos  = "STELLARPARK";
#Puede ser 127.0.0.1 o el nombre de tu equipo; o la IP de un servidor remoto
$server = "localhost";
$puerto = "5432";
try
{
    $base_de_datos = new PDO("pgsql:host=$server;port=$puerto;dbname=$nombreBaseDeDatos", $usuario, $contraseña);
    $base_de_datos->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    echo "Me Conecté";
}

catch (Exception $e)
{
    echo "Ocurrió un error con la base de datos: " . $e->getMessage();
}