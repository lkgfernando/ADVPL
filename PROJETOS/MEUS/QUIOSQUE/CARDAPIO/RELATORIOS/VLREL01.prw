#Include "Totvs.ch"
#Include "FWMVCDef.ch"


/*/{Protheus.doc} User Function VLREL01
    (Come�o de um projeto para impress�o de relat�rio via MarkBrowse)
    @type  Function
    @author Fernando Rodrigues
    @since 07/08/2023
    @version 1.0
    @param , , 
    @return Nil, , 
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function VLREL01()
    Private oMark
    
    oMark := FWMarkBrowse():New()
    oMark:Setalias('SZ2')

    oMark:SetSemaphore(.T.)
    oMark:SetDescription('Sele��o de Produtos do card�pio')
    


Return Nil
