#INCLUDE "PROTHEUS.CH"
#INCLUDE "VKEY.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "JPEG.CH"
#INCLUDE "MSMGADD.CH"

/*
// ##############################################################################################
// Projeto: AULA DE CRIA��O DE TELA
// Modulo : SIGAATF
// Fonte  : ABREZZ4.prw
// -------------+----------------------+---------------------------------------------------------
// Data         | Autor                | Descricao
// -------------+----------------------+---------------------------------------------------------
// 08/06/2022   | FERNADO.RODRIGUES    | CRIA��O DE RDMAKE
// -------------+----------------------+---------------------------------------------------------*/ 

User Function ABREZZ4()
    PRIVATE cCadastro := "Cadastro de UM Clientes"

    PRIVATE aRotina   :={{"Pesquisar", "AxPesqui", 0, 1}, ;
                        {"Visualizar"                  , "AxVisual", 0, 2} , ;
                        {"Alterar"                     , "AxAltera", 0, 4} , ;
                        {"Incluir"                     , "AxInclui", 0, 3} , ;
                        {"Excluir"                     , "AxDeleta", 0, 5}}

    PRIVATE cDelFunc  := ".T." //valida��o para exclus�o. Pode-se utilizar ExecBlock

    PRIVATE cString   := "ZZ4"
    PRIVATE cCondicao := ""
    PRIVATE aIndSB1   := {}
    PRIVATE cCampo
    PRIVATE aCampos   := {}

    DbSelectArea("ZZ4")
    DbSetOrder(1)

    //Asort(aCampos,,,{ |x, y|x[1]<y[1] })
    DbSelectArea(cString)
    mBrowse( 6,1,22,75,cString,aCampos,cCampo)

Return
