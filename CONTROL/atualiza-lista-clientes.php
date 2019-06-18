<?php
header('Content-Type: text/html; charset=ISO-8859-1');

function __autoload($class_name){
    require_once '../MODEL/'.$class_name . '.php';
}

$query = 'SELECT * FROM Cliente;';
$stmt = DB::prepare($query);
$stmt->execute();
if($stmt->rowCount() == 0){
    echo 'Sem registros';
}else {
    while ($row = $stmt->fetch()) {
        echo '<div class="item" data-id="' . $row->idCliente . '">' . $row->nomeCliente . '</div>';
    }
}