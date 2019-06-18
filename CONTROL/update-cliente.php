<?php
require_once 'control.php';


$id = $_GET['id'];
$nome = $_GET['nome'];
$cpf = $_GET['cpf'];
$tc = $_GET['tc'];
$endereco = $_GET['endereco'];
$data = $_GET['data'];


updateCliente($id, $nome, $cpf, $tc, $endereco, $data);