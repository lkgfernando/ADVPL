#Include "Totvs.ch"




/*/{Protheus.doc} ZFORMU01
(long_description)
@type  Function
@author FERNANDO RODRIGUES
@since 01/02/2026
@version
@param , ,
@return cMensagem, ,
@example
(examples)
@see (links_or_references)
    /*/
User Function ZFORMU01()
	Local aArea     := fwGetArea()
	Local cMensagem := ""
	Local nMeses    := 1
	Local dDataHoje := Date()
	Local dDataRef  := sToD("")
	Local dHa1Mes   := MonthSub(dDataHoje,1)

    If SA1->A1_PESSOA == "J"
        nMeses := 3
    
    Else
        nMeses := 3

    EndIf

    dDataRef := MonthSub(dDataHoje, nMeses)

    If Empty(SA1->A1_ULTCOM)

        cMensagem := "Nunca comprou, avalie o cadastro"
    else

        If SA1->A1_ULTCOM < dHa1Mes
            cMensagem := "Passou limite de meses, contato com cliente urgente"
        
        ElseIf SA1->A1_ULTCOM < dHa1Mes
            cMensagem := "Não compra faz 1 mês atento"
        
        else
            
            cMensagem := "Comprou no periodo"

        EndIf

        
    EndIf



	fwRestArea(aArea)
Return cMensagem
