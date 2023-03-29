#Include "Totvs.ch"

/*/{Protheus.doc} User Function zOO02
    (long_description)
    @type  Function
    @author Fernando Rodrigues
    @since 28/02/2023
    @version 1.0
    @param , , 
    @return , , 
    @example
    (examples)
    @see (links_or_references)
    /*/

User Function zOO02()
    Local oPessoa
    Local cNome := "Fernando"
    Local dNascimento := sToD("19850330")

    oPessoa := zPessoa():New(cNome, dNascimento)


    oPessoa:MostraIdade()
Return 
