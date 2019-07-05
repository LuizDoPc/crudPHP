<?php
header('Content-Type: text/html; charset=ISO-8859-1');
function __autoload($class_name){
    require_once '../MODEL/'.$class_name . '.php';
}

$id = $_GET['id'];



$c = new Cliente($id);




echo '<form id="form-modal">
                <input type="hidden" name="id" value="'.$c->getIdCliente().'">
                <div class="row form">
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                        <div class="input-group">
                            <div class="input-group-addon">Nome</div>
                            <input type="text" name="nome" class="form-control data-modal" value="'.$c->getNome().'">
                        </div>
                    </div>
                </div>
                <div class="row form">
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                        <div class="input-group">
                            <div class="input-group-addon">CPF</div>
                            <input type="text" name="cpf" class="form-control data-modal" value="'.$c->getCPF().'">
                        </div>
                    </div>
                </div>
                <div class="row form">
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                        <div class="input-group">
                            <div class="input-group-addon">Telefone Celular</div>
                            <input type="text" name="tc" class="form-control data-modal" value="'.$c->getTelefoneCelular().'">
                        </div>
                    </div>
                </div>
                <div class="row form">
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                        <div class="input-group">
                            <div class="input-group-addon">Endereco</div>
                            <input type="text" name="endereco" class="form-control data-modal" value="'.$c->getEndereco().'">
                        </div>
                    </div>
                </div>
                <div class="row form">
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                        <div class="input-group">
                            <div class="input-group-addon">Data Nasc</div>
                            <input type="date" name="data" class="form-control data-modal" value="'.$c->getDataNasc().'">
                        </div>
                    </div>
                </div>
            </form>';