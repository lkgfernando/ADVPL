#Include "Totvs.ch"
#Include "FWMVCDef.ch"


/*/{Protheus.doc} User Function zMVC11
    (long_description)
    @type  Function
    @author Fernando Rodrigues
    @since 20/09/2023
    @version 1.0
    @param , , 
    @return , , 
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function zMVC11()
    Local aArea      := FWGetArea()
    Local lWorkedOut := .F.
    Local oModel
    Local oZD1Mod
    Local aError     := {}

    dbSeletcArea('ZD1')

    oModel := FWLoadModel("zMVC01") //u_z01Model()
    oModel:SetOperation(3)
    oModel:Activate()

    oZD1Mod := oModel:GetModel("ZD1MASTER")
    oZD1Mod:SetValue("ZD1_CODIGO",  GetSXENum("ZD1", "ZD1_CODIGO"))
    oZD1Mod:Setvalue("ZD1_NOME",    "CHITAOZINHO E XORORO"        )
    oZD1Mod:SetValue("ZD1_DTFORM",  cToD("01/01/1969")            )
    oZD1Mod:SetValue("ZD1_OBSERV",  "OBSERVACAO TESTE EXECAUTO"   )
    ConfirmSX8()

    SA2->(dbCloseArea())
    If oModel:VldData() .And. oModel:CommitData()
        lWorkedOut := .T.
    Else
        lWorkedOut := .F.
    EndIf

    If ! lWorkedOut 

        aError := oModel:GetErrorMessage()

        AutoGrLog("Id do formulario de origem: " + ' [' + AllToChar(aError[01]) + ']')
        AutoGrLog("Id do Campo de origem:      " + ' [' + AllToChar(aError[02]) + ']')
        AutoGrLog("Id do formulario de erro:   " + ' [' + AllToChar(aError[03]) + ']')
        AutoGrLog("Id do campo de erro:        " + ' [' + AllToChar(aError[04]) + ']')
        AutoGrLog("Id do erro:                 " + ' [' + AllToChar(aError[05]) + ']')
        AutoGrLog("Mensagem do erro:           " + ' [' + AllToChar(aError[06]) + ']')
        AutoGrLog("Mensagem da solucao:        " + ' [' + AllToChar(aError[07]) + ']')
        AutoGrLog("Valor do atributo:          " + ' [' + AllToChar(aError[08]) + ']')
        AutoGrLog("Valor anterior:             " + ' [' + AllToChar(aError[09]) + ']')

        MostraErro()

    EndIf
    
    FWRestArea(aArea)
Return 
