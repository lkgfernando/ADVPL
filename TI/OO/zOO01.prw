#Include "Totvs.ch"

/*/{Protheus.doc} zPessoa
    (long_description)
    @author Fernando Rodrigues
    @since 28/02/2023
    @version 1.0
    /*/
Class zPessoa
    //Atributos
    Data cNome
    Data nIdade
    Data dNascimento

    //Métodos
    Method New() CONSTRUCTOR
    Method MostraIdade()

EndClass


/*/{Protheus.doc} New
    (long_description)
    @author Fernando Rodrigues
    @since 28/02/2023
    @version 1.0
    @param cNome,dNascimento,, param_type, 
    @return , , 
    /*/
Method New(cNome, dNascimento) Class zPessoa
    //Atributos valores nos atributos do objeto instanciado
    ::cNome := cNome
    ::dNascimento := dNascimento
    ::nIdade := fCalcIdade(dNascimento)
Return Self

/*/{Protheus.doc} MostraIdade
    (long_description)
    @author Fernando Rodrigues
    @since 28/02/2023
    @version 1.0
    @param , , 
    @return , , 
    /*/
Method MostraIdade() Class zPessoa
    Local cMsg := ""

    cMsg := "A <b>pessoa</b> " + ::cNome + " tem " + cValToChar(::nIdade) + " anos!"
    MsgInfo(cMsg, "Atenção")    
Return 


/*/{Protheus.doc} fCalculaIdade
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 28/02/2023
    @version 1.0
    @param dNascimento, string, Data de nascimento
    @return nIdade, , 
    @example
    (examples)
    @see (links_or_references)
/*/
Static Function fCalcIdade(dNascimento)
    Local nIdade
    nIdade := DateDiffYear(dDataBase, dNascimento)
Return nIdade
