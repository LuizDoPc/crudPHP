<?php
require_once 'control.php';


$nome = $_GET['nome'];
$cpf = $_GET['cpf'];
$tc = $_GET['tc'];
$endereco = $_GET['endereco'];
$data = $_GET['data'];



cadastraCliente($nome, $cpf, $tc, $endereco, $data);