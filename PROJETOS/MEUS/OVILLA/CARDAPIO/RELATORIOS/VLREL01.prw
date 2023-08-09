#Include "Totvs.ch"
#Include "FWMVCDef.ch"


/*/{Protheus.doc} User Function VLREL01
    (Começo de um projeto para impressão de relatório via MarkBrowse)
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
    oMark:SetDescription('Seleção de Produtos do cardápio')
    


Return Nil
