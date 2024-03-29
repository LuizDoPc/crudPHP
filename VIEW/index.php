<?php
    header('Content-Type: text/html; charset=ISO-8859-1');

    function __autoload($class_name){
        require_once '../MODEL/'.$class_name . '.php';
    }

    require_once '../CONTROL/control.php';
?>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>CRUD</title>
    <link rel="stylesheet" href="../CSS/bootstrap.min.css">
    <link rel="stylesheet" href="../CSS/bootstrap-select.min.css">
    <link rel="stylesheet" href="../CSS/remodal.css">
    <link rel="stylesheet" href="../CSS/remodal-default-theme.css">
    <script src="../JS/jquery-3.1.0.js"></script>
    <script src="../JS/bootstrap.min.js"></script>
    <script src="../JS/bootstrap-select.min.js"></script>
    <script src="../JS/remodal.min.js"></script>

    <style>
        #title{
            font-family: "Century Gothic";
            font-size: 2vw;
        }
        #header{
            margin-bottom: 5vw;
        }
        .conteudo{
            box-shadow: 4px 6px 31px -4px rgba(0,0,0,0.75);
            padding: 1vw;
        }
        .subtitle{
            font-family: "Century Gothic";
            font-size: 1vw;
            margin-bottom: 1vw;
        }
        .form{
            margin-bottom: .5vw;
        }
        .input-group-addon{
            min-width: 7vw;
        }
        .item{
            width: 20vw;
            height: 2vw;
            border: 1px black solid;
            margin-bottom: .5vw;
            padding: .4vw;
            user-select: none;
            cursor: pointer;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        #gp2{
            display: none;
        }
    </style>

    <script>
        function atualiza_lista_clientes() {
            $.get('../CONTROL/atualiza-lista-clientes.php', function (res) {
                $('#res-cliente').html(res);
            });
        }

        $(document).ready(function () {
            $('#enviar').click(function () {
                $.get('../CONTROL/recebe-cliente.php', $('#form').serialize());
                atualiza_lista_clientes();
                $('#form').trigger('reset');
            });

            $(document).on('click', '.item', function () {
                var inst = $('[data-remodal-id=modal]').remodal();

                var id = $(this).data('id');


                $.get('../CONTROL/retorna-cliente.php', {'id':id}, function (res) {
                    $('#res-modal').html(res);
                    $('.selectpicker').selectpicker();
                    $('.selectpicker').selectpicker('refresh');
                    $('.data-modal').prop("disabled", true);
                });


                inst.open();
            });

            $('#update').click(function () {
                $('#gp1').hide();
                $('#gp2').show();
                $('.data-modal').prop("disabled", false);
            });
            $('#cancel').click(function () {
                $('#gp2').hide();
                $('#gp1').show();
                $('.data-modal').prop("disabled", true);
            });

            $('#envia-update').click(function () {
                $.get('../CONTROL/update-cliente.php', $('#form-modal').serialize(), function () {
                    var inst = $('[data-remodal-id=modal]').remodal();
                    $('#gp2').hide();
                    $('#gp1').show();
                    $('.data-modal').prop("disabled", true);
                    inst.close();
                    atualiza_lista_clientes();
                });
            });

            $('#delete').click(function () {
                $.get('../CONTROL/deleta-cliente.php', $('#form-modal').serialize(), function () {
                    var inst = $('[data-remodal-id=modal]').remodal();
                    $('#gp2').hide();
                    $('#gp1').show();
                    $('.data-modal').prop("disabled", true);
                    inst.close();
                    atualiza_lista_clientes();
                });
            });
        });
    </script>
</head>
<body>


<!-- MODAL INICIO-->

<div class="remodal" data-remodal-id="modal" data-remodal-options="hashTracking: false, closeOnOutsideClick: false">

    <button data-remodal-action="close" class="remodal-close"></button>
    <h1>Cliente</h1>

    <div id="res-modal"></div>

    <br>
    <div class="btn-group-justified" id="gp1">
        <div class="btn btn-danger" id="delete">DELETE</div>
        <div class="btn btn-default" id="update">UPDATE</div>
    </div>
    <div class="btn-group-justified" id="gp2">
        <div class="btn btn-danger" id="cancel">CANCEL</div>
        <div class="btn btn-primary" id="envia-update">ENVIAR</div>
    </div>
</div>


<!-- MODAL FIM-->

    <div class="row" id="header">
        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xs-offset-5 col-sm-offset-5 col-md-offset-5 col-lg-offset-5" id="title">CRUD Cliente</div>
    </div>

    <div class="row">
        <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 col-xs-offset-1 col-sm-offset-1 col-md-offset-1 col-lg-offset-1 conteudo">

            <form id="form">
                <div class="row">
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                        <div class="subtitle">CADASTRO</div>
                    </div>
                </div>
                <div class="row form">
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                        <div class="input-group">
                            <div class="input-group-addon">Nome</div>
                            <input type="text" name="nome" class="form-control">
                        </div>
                    </div>
                </div>
                <div class="row form">
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                        <div class="input-group">
                            <div class="input-group-addon">CPF</div>
                            <input type="text" name="cpf" id="cpf" class="form-control">
                        </div>
                    </div>
                </div>
                <div class="row form">
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                        <div class="input-group">
                            <div class="input-group-addon">Telefone Celular</div>
                            <input type="text" name="tc" id="tc" class="form-control">
                        </div>
                    </div>
                </div>
                <div class="row form">
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                        <div class="input-group">
                            <div class="input-group-addon">Endereco</div>
                            <input type="text" name="endereco" id="endereco" class="form-control">
                        </div>
                    </div>
                </div>
                <div class="row form">
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                        <div class="input-group">
                            <div class="input-group-addon">Data Nasc</div>
                            <input type="date" name="data" id="data" class="form-control">
                        </div>
                    </div>
                </div>               
            </form>
            <div class="btn-group-justified">
                <div class="btn btn-primary" id="enviar">Enviar</div>
            </div>

        </div>

        <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 col-xs-offset-1 col-sm-offset-1 col-md-offset-1 col-lg-offset-1 conteudo" id="res">
            <div class="row" align="center">
                <div class="subtitle">CLIENTES</div>
            </div>
            <div class="row" align="center">
                <div id="res-cliente">
                    <?php
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
                    ?>
                </div>
            </div>
        </div>
    </div>
</body>
</html>