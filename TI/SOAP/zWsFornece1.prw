#Include "Totvs.ch"
#Include "APWebSrv.ch"
#Include "TopConn.ch"


WsService zWSForn Description "Web service with supplier functions"

    WsData cNewRace as String
    WsData cNewSend as String


    WsMethod NewForn      Description "Create new supplier"


EndWsService




WsMethod NewForn WsReceive cNewRace WsSend cNewSend WsService zWSForn
    Local aArea           := fwGetArea()        
    Local lRet            := .T.                
    Local jJsonRece                             
    //Local cDirLog         := '\x_logs\'         
    Local nI                                              
    Local cError          := ""                 
    Local jResponse       := JsonObject():New() 
    Local cLog            := ""                 
    Local aErros                              
    
    Private lMsHelpAuto   := .T.                        
    Private lAutoErrNoFile:= .T.                        
    Private lMsErroAuto   := .F.                        
    Private oModel        := fwLoadModel("MATA020M")    
    Private oSA2Mod                                     




    jJsonRece   := JsonObject():New()
    cError      := jJsonRece:FromJson(::cNewRace)

    If ! Empty(cError) .Or. Len(::cNewRace) < 20
        jResponse['errorId']    := 'NEW001'
        jResponse['error']      := 'Parse do Json'
        jResponse['solution']   := 'Erro ao fazer o Parse do Json'
    Else

        If Empty(jJsonRece:GetJsonObject('cod'))            .Or. ;
           Empty(jJsonRece:GetJsonObject('loja'))           .Or. ;
           Empty(jJsonRece:GetJsonObject('razaoSocial'))    .Or. ;
           Empty(jJsonRece:GetJsonObject('nomeFantasia'))   .Or. ;
           Empty(jJsonRece:GetJsonObject('tipo'))           .Or. ;
           Empty(jJsonRece:GetJsonObject('end'))            .Or. ;
           Empty(jJsonRece:GetJsonObject('bairro'))         .Or. ;
           Empty(jJsonRece:GetJsonObject('cidade'))         .Or. ;
           Empty(jJsonRece:GetJsonObject('estado'))         .Or. ;
           Empty(jJsonRece:GetJsonObject('cep'))            .Or. ;
           Empty(jJsonRece:GetJsonObject('cnpj')) 

           jResponse['errorId']    := 'NEW002'
           jResponse['error']      := 'Campos(s) Obrigagorios não preenchidos'
           jResponse['solution']   := 'Existem campos que não foram enviados, revise a estrutura do seu Json'
        Else

            oModel:SetOperation(3)
            oModel:Activate()

            oSA2Mod     := oModel:getModel("SA2MASTER")
            oSA2Mod:SetValue('A2_COD'   , jJsonRece:GetJsonObject('cod'))
            oSA2Mod:SetValue('A2_LOJA'  , jJsonRece:GetJsonObject('loja'))
            oSA2Mod:SetValue('A2_NOME'  , jJsonRece:GetJsonObject('razaoSocial'))
            oSA2Mod:SetValue('A2_NREDUZ', jJsonRece:GetJsonObject('nomeFantasia'))
            oSA2Mod:SetValue('A2_TIPO'  , jJsonRece:GetJsonObject('tipo'))
            oSA2Mod:SetValue('A2_END'   , jJsonRece:GetJsonObject('end'))
            oSA2Mod:SetValue('A2_BAIRRO', jJsonRece:GetJsonObject('bairro'))
            oSA2Mod:SetValue('A2_EST'   , jJsonRece:GetJsonObject('estado'))
            oSA2Mod:SetValue('A2_MUN'   , jJsonRece:GetJsonObject('cidade'))
            oSA2Mod:SetValue('A2_CEP'   , jJsonRece:GetJsonObject('cep'))
            oSA2Mod:SetValue('A2_CGC'   , jJsonRece:GetJsonObject('cnpj'))


            If oModel:VldData()

                If oModel:CommitData()
                    lMsErroAuto := .F.
                Else
                    lMsErroAuto := .T.

                EndIf
            Else
                lMsErroAuto := .T.
            EndIf

            If lMsErroAuto
                // Captura o log direto pelo oModel
                cLog := ""
                aErros := {}
                nI := 0
    
                aErros := oModel:GetErrorMessage()
                For nI := 1 To Len(aErros)
                    If ValType(aErros[nI]) == 'C'
                         cLog += aErros[nI] + ' | '
                    ElseIf ValType(aErros[nI]) == 'A'
                        cLog += aErros[nI][2] + ' | '
                    EndIf
                 Next nI

                jResponse['errorId']  := 'NEW003'
                jResponse['error']    := 'Erro na inclusão do registro'
                jResponse['solution'] := cLog  // vai mostrar o erro real aqui
            Else
                jResponse['note']       := 'Registro incluido com sucesso'
            EndIf


       EndIf
          
    EndIf

    oModel:Deactivate()

    ::cNewSend := jResponse:ToJson()

    fwRestArea(aArea)
Return lRet
