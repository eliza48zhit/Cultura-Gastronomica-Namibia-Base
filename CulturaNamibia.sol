// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title CulturaNamibia
 * @dev Registro de procesos de fermentacion de cereales y capas termicas de coccion.
 * Serie: Sabores de Africa (38/54)
 */
contract CulturaNamibia {

    struct Plato {
        string nombre;
        string ingredientes;
        string preparacion;
        uint256 nivelFermentacion;  // Control de pH y probioticos (1-10)
        uint256 capasEstratificadas; // Numero de niveles en la olla Potjie (1-10)
        bool usaMijoMahangu;        // Grano base de la dieta namibia
        uint256 likes;
        uint256 dislikes;
    }

    mapping(uint256 => Plato) public registroCulinario;
    uint256 public totalRegistros;
    address public owner;

    constructor() {
        owner = msg.sender;
        // Inauguramos con el Oshikundu (Ingenieria de la Fermentacion)
        registrarPlato(
            "Oshikundu", 
            "Mijo perla (Mahangu), harina de sorgo, agua, azucar residual.",
            "Fermentacion corta (24h) de harinas de cereales para obtener una bebida nutritiva y probiotica.",
            8, 
            1, 
            true
        );
    }

    function registrarPlato(
        string memory _nombre, 
        string memory _ingredientes,
        string memory _preparacion,
        uint256 _fermentacion, 
        uint256 _capas,
        bool _usaMahangu
    ) public {
        require(bytes(_nombre).length > 0, "Nombre requerido");
        require(_fermentacion <= 10, "Escala de fermentacion excedida");

        totalRegistros++;
        registroCulinario[totalRegistros] = Plato({
            nombre: _nombre,
            ingredientes: _ingredientes,
            preparacion: _preparacion,
            nivelFermentacion: _fermentacion,
            capasEstratificadas: _capas,
            usaMijoMahangu: _usaMahangu,
            likes: 0,
            dislikes: 0
        });
    }

    function darLike(uint256 _id) public {
        require(_id > 0 && _id <= totalRegistros, "ID invalido");
        registroCulinario[_id].likes++;
    }

    function darDislike(uint256 _id) public {
        require(_id > 0 && _id <= totalRegistros, "ID invalido");
        registroCulinario[_id].dislikes++;
    }
}
