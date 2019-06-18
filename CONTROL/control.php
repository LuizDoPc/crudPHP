<?php

require_once '../MODEL/Cliente.php';

function cadastraCliente($nome, $cpf, $tc, $endereco, $data){

    $c = new Cliente();

    $c->setNome($nome);
    $c->setCPF($cpf);
    $c->setTelefoneCelular($tc);
    $c->setEndereco($endereco);
    $c->setDataNasc($data);
    $c->insert();
}

function updateCliente($id, $nome, $cpf, $tc, $endereco, $data){

    $c = new Cliente();

    $c->setIdCliente($id);
    $c->setNome($nome);
    $c->setCPF($cpf);
    $c->setTelefoneCelular($tc);
    $c->setEndereco($endereco);
    $c->setDataNasc($data);


    $c->update($id);
}

function deletaCliente($id){

    $c = new Cliente($id);

    $c->delete($id);
}