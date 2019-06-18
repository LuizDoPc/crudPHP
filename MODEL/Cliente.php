<?php
require_once 'Crud.php';

class Cliente extends Crud {

    protected $table = 'Cliente';

    private $idCliente;
    private $Nome;
    private $CPF;
    private $TelefoneCelular;
    private $Endereco;
    private $DataNasc;
	

    /**
     * Cliente constructor.
     */
    public function __construct(...$id){
        if(count($id) == 1){
            $res = $this->find($id[0]);
            $this->idCliente = $res->idCliente;
            $this->Nome = $res->nomeCliente;
            $this->CPF = $res->CPF;
            $this->TelefoneCelular= $res->telefoneCliente;
            $this->Endereco = $res->enderecoCliente;
            $this->DataNasc = $res->dataNascCliente;
        }
    }


    public function insert(){
        $query = 'INSERT INTO Cliente(
                        nomeCliente, 
                        CPF, 
                        telefoneCliente, 
                        enderecoCliente, 
                        dataNascCliente) 
                  VALUES (:nome, :cpf, :tc, :endereco, :data);';
        if($stmt = DB::prepare($query)){
            $stmt->bindParam(':nome', $this->Nome);
            $stmt->bindParam(':cpf', $this->CPF);
            $stmt->bindParam(':tc', $this->TelefoneCelular);
            $stmt->bindParam(':endereco', $this->Endereco);
            $stmt->bindParam(':data', $this->DataNasc);
            $stmt->execute();
        }

    }
    public function delete($id){
        $query = 'DELETE FROM Cliente WHERE idCliente = :id';

        if($stmt = DB::prepare($query)) {
            $stmt->bindParam(':id', $id);
            return $stmt->execute();
        }
    }
    public function update($id){
        $query = 'UPDATE Cliente SET
                        nomeCliente=:nome,
                        CPF=:cpf,
                        telefoneCliente=:tc,
                        enderecoCliente=:endereco,
                        dataNascCliente=:data
                  WHERE idCliente=:id';

        if($stmt = DB::prepare($query)){
            $stmt->bindParam(':nome', $this->Nome);
            $stmt->bindParam(':cpf', $this->CPF);
            $stmt->bindParam(':tc', $this->TelefoneCelular);
            $stmt->bindParam(':endereco', $this->Endereco);
            $stmt->bindParam(':data', $this->DataNasc);
            $stmt->bindParam(':id', $id);
            $stmt->execute();
        }
    }
    public function find($id){
        $query = 'SELECT * FROM Cliente WHERE idCliente= :id';
        $stmt = DB::prepare($query);
        $stmt->bindParam(':id', $id);
        $stmt->execute();
        return $stmt->fetch();
    }


    /**
     * @return mixed
     */
    public function getIdCliente()
    {
        return $this->idCliente;
    }

    /**
     * @param mixed $idCliente
     */
    public function setIdCliente($idCliente)
    {
        $this->idCliente = $idCliente;
    }

    /**
     * @return mixed?
     */
    public function getNome(){
        return $this->Nome;
    }

    /**
     * @param mixed $Nome
     */
    public function setNome($Nome){
        $this->Nome = $Nome;
    }

    /**
     * @return mixed
     */
    public function getCPF(){
        return $this->CPF;
    }

    /**
     * @param mixed $CPF
     */
    public function setCPF($CPF){
        $this->CPF = $CPF;
    }

    /**
     * @return mixed
     */
    public function getTelefoneCelular(){
        return $this->TelefoneCelular;
    }

    /**
     * @param mixed $TelefoneCelular
     */
    public function setTelefoneCelular($TelefoneCelular){
        $this->TelefoneCelular = $TelefoneCelular;
    }

    /**
     * @return mixed
     */
    public function getEndereco(){
        return $this->Endereco;
    }

    /**
     * @param mixed $Endereco
     */
    public function setEndereco($Endereco){
        $this->Endereco = $Endereco;
    }

    /**
     * @return mixed
     */
    public function getDataNasc(){
        return $this->DataNasc;
    }

    /**
     * @param mixed $DataNasc
     */
    public function setDataNasc($DataNasc){
        $this->DataNasc = $DataNasc;
    }
}