/*
    compilador:
    http://remix.ethereum.org/#appVersion=0.7.7&optimize=false&version=soljson-v0.4.11+commit.68ef5810.js
*/

//ICO TTcoins

//versao do solidity
pragma solidity ^0.4.11;
 
contract TTcoin_ico {
 
    //Total de Tokens	 
    uint public max_TTcoins = 1000000;
    //Taxa cotacao do token por dolar	
    uint public usd_to_TTcoins = 1000;
    //total de Tokens comprados por investidores	
    uint public total_TTcoins_bought = 0;
    
    //funcoes de equivalencia
    mapping(address => uint) equity_TTcoins;
    mapping(address => uint) equity_usd;
 
    //verificando se o investidor pode comprar o token
    modifier can_buy_TTcoins(uint usd_invested) {
        require (usd_invested * usd_to_TTcoins + total_TTcoins_bought <= max_TTcoins);
        _;
    }
 
    //retorna o valor do investimento em tokens
    function equity_in_TTcoins(address investor) external constant returns (uint){
        return equity_TTcoins[investor];
    }
 
    //retorna o valor do investimento em dolares
    function equity_in_usd(address investor) external constant returns (uint){
        return equity_usd[investor];
    }
 
    //compra de tokens
    function buy_TTcoins(address investor, uint usd_invested) external 
    can_buy_TTcoins(usd_invested) {
        uint TTcoins_bought = usd_invested * usd_to_TTcoins;
        equity_TTcoins[investor] += TTcoins_bought;
        equity_usd[investor] = equity_TTcoins[investor] / 1000;
        total_TTcoins_bought += TTcoins_bought;
    }
 
    //venda de tokens
    function sell_TTcoins(address investor, uint TTcoins_sold) external {
        equity_TTcoins[investor] -= TTcoins_sold;
        equity_usd[investor] = equity_TTcoins[investor] / 1000;
        total_TTcoins_bought -= TTcoins_sold;
    }
    
}