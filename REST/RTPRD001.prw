#Include "Totvs.ch"
#Include "RestFul.ch"

WSRESTFUL produtos DESCRIPTION "Manipulacao de Produtos"

    WSMETHOD GET DESCRIPTION  "Listar todos os produtos" WSSYNTAX "/" PATH "/"

END WSRESTFUL


//CRIAÇÃO DOS MÉTADOS

WSMETHOD GET WSSERVICE produtos

    Self:SetResponse("Lista de Produtos")

Return .T.
